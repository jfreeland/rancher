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
<<<<<<< Updated upstream
=======

## todo

- cert manager

## homelab

```bash
# https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/kubernetes-cluster-setup/k3s-for-rancher
#curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.32.4+k3s1 sh -s - server --datastore-endpoint="mysql://rancher:${RANCHER_PASSWORD}@tcp(localhost:3306)/rancher"
sudo k3s kubectl get pods -A
helm repo add jetstack https://charts.jetstack.io
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set crds.enabled=true
helm install rancher rancher-stable/rancher --namespace cattle-system --create-namespace --set hostname=192.168.1.200.sslip.io --set bootstrapPassword=${ADMIN_PASSWORD}
# snag /etc/rancher/k3s/k3s.yaml
# do stuff
curl https://raw.githubusercontent.com/rancher/system-agent/main/system-agent-uninstall.sh | sudo sh -
sudo /usr/local/bin/rke2-uninstall.sh
```

or just run single node docker

- https://github.com/Cinderblook/tacklebox/blob/bf6999cc94aba4e601a6b5635f1773695d583825/Kubernetes/k3s-HACluster-Rancher/Rancher/docker-compose.yml
>>>>>>> Stashed changes
