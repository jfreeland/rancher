# AWS region used for all resources
aws_region = "us-east-1"

# AWS zone used for all resources
aws_zone = "us-east-1b"

# Version of cert-manager to install alongside Rancher (format: 0.0.0)
cert_manager_version = "1.17.2"

# Instance type used for all EC2 instances
instance_type = "t3a.xlarge"

# Prefix added to names of all resources
prefix = "test"

# The helm repository, where the Rancher helm chart is installed from
rancher_helm_repository = "https://releases.rancher.com/server-charts/latest"

# Kubernetes version to use for Rancher server cluster
#rancher_kubernetes_version = "v1.24.14+k3s1"
#rancher_kubernetes_version = "v1.32.4+k3s1"
#rancher_kubernetes_version = "v1.31.8+k3s1"
rancher_kubernetes_version = "v1.30.12+k3s1"

# Rancher server version (format: v0.0.0)
#rancher_version = "2.7.9"
rancher_version = "2.11.1"

# Kubernetes version to use for managed workload cluster
#workload_kubernetes_version = "v1.24.14+rke2r1"
#workload_kubernetes_version = "v1.32.4+rke2r1"
#workload_kubernetes_version= "v1.31.8+rke2r1"
workload_kubernetes_version = "v1.30.12+rke2r1"
