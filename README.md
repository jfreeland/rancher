# rancher

i need an rke2 cluster to play with. hacked up from
http://github.com/rancher/quickstart.

```bash
cd terraform/aws
terraform apply -auto-approve
# label nodes to simulate multiple dc's
kubectl label nodes $node topology.kubernetes.io/zone=dc1
kubectl label nodes $node topology.kubernetes.io/zone=dc2
# install flux
flux bootstrap github --owner=jfreeland --repository=flux --branch=main --path=./clusters/rancher-aws --personal --private=false
# do things
for i in $(terraform state list | grep helm); do terraform state rm $i; done
terraform destroy -auto-approve
```
