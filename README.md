# rancher

i need an rke2 cluster to play with. hacked up from
http://github.com/rancher/quickstart.

```bash
terraform apply -auto-approve
flux bootstrap github --owner=jfreeland --repository=flux --branch=main --path=./clusters/rancher-aws --personal --private=false
# do things
for i in $(terraform state list | grep helm); do terraform state rm $i; done
terraform destroy -auto-approve
```

## todo

- cert manager
