# rancher

i need an rke2 cluster to play with. hacked up from
http://github.com/rancher/quickstart.

```bash
terraform apply -auto-approve
# do things
for i in $(terraform state list | grep helm); do terraform state rm $i; done
terraform destroy -auto-approve
```
