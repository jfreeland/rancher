# rancher

i need an rke2 cluster to play with. hacked up from
http://github.com/rancher/quickstart.

```bash
cd terraform/aws
terraform apply -auto-approve
# label nodes to simulate multiple dc's
# or is it annotate?
kubectl label nodes $node topology.kubernetes.io/zone=dc1
# install flux
flux bootstrap github --owner=jfreeland --repository=flux --branch=main --path=./clusters/rancher-aws --personal --private=false
# elastic
curl -u "elastic:$ELASTIC_PW" "https://elastic.ratings.cloud/_things?pretty"
curl -u "elastic:$ELASTIC_PW" "https://elastic.ratings.cloud/_cluster/allocation/explain?pretty" -H "Content-Type: application/json" -d @explain.json | fx
curl -u "elastic:$ELASTIC_PW" "https://elastic.ratings.cloud/_cluster/reroute?pretty" -X POST -H "Content-Type: application/json" -d @reroute.json
# do things
for i in $(terraform state list | grep helm); do terraform state rm $i; done
terraform destroy -auto-approve
```
