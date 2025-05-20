import argparse
import datetime
import json
import os
import random
import sys
import time

from elasticsearch import (ConnectionError, ConnectionTimeout, Elasticsearch,
                           RequestError)
from faker import Faker
from hurry.filesize import size
from tenacity import (retry, retry_if_exception_type, stop_after_attempt,
                      wait_exponential)

SECONDS_BETWEEN_LOGS = 10


def load_bytes():
    try:
        with open(f"{args.env}-bytes", "r") as f:
            return int(f.read())
    except FileNotFoundError:
        return 0


def save_bytes(total):
    with open(f"{args.env}-bytes", "w") as f:
        f.write(str(total))


fake = Faker()

parser = argparse.ArgumentParser(description="Generate logs for Elasticsearch testing.")
parser.add_argument(
    "env",
    choices=["dc1", "dc2"],
    help="Environment to target (dc1 or dc2)",
)
args = parser.parse_args()

elastic_pw = os.getenv("ELASTIC_PW")
if not elastic_pw:
    print("Please set the ELASTIC_PW environment variable.")
    sys.exit(1)

port = 443
host = "elastic.ratings.cloud"
auth = ("elastic", elastic_pw)
if args.env == "dc1":
    index_name = "k8s-dc1"
elif args.env == "dc2":
    index_name = "k8s-dc2"
else:
    sys.exit(1)


client = Elasticsearch(
    hosts=[f"https://{host}:{port}"],
    basic_auth=auth,
    verify_certs=True,
)

log_levels = ["INFO", "WARNING", "ERROR", "DEBUG"]
num_logs = 100000000

total_bytes = load_bytes()


@retry(
    stop=stop_after_attempt(9),
    wait=wait_exponential(multiplier=2, min=1, max=10),
    retry=retry_if_exception_type((ConnectionError, RequestError, ConnectionTimeout)),
    before_sleep=lambda retry_state: print(
        f"Retrying index operation: attempt {retry_state.attempt_number}"
    ),
)
def index_log_entry(client, index_name, log_entry):
    return client.index(index=index_name, body=log_entry)


for i in range(num_logs):
    log_entry = {
        "@timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat(),
        "ip_address": fake.ipv4(),
        "log_level": random.choice(log_levels),
        "message": fake.sentence(nb_words=10),
    }

    log_entry_json = json.dumps(log_entry)
    payload_size = len(log_entry_json.encode("utf-8"))
    total_bytes += payload_size

    try:
        index_log_entry(client, index_name, log_entry)
        print(
            f"indexed log entry: {i}, payload size: {size(payload_size)}, total bytes: {size(total_bytes)}"
        )
        save_bytes(total_bytes)
    except Exception as e:
        print(f"Failed to index log entry {i} after retries: {str(e)}")
        break

    time.sleep(SECONDS_BETWEEN_LOGS)

print("wow this ran to the end")
print(f"Successfully indexed {num_logs} log entries to {index_name}.")
