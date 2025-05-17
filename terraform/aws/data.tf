data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # SUSE

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20241206"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_route53_zone" "selected" {
  name = "ratings.cloud."
}
