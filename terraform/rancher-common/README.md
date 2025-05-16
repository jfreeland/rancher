# Rancher Common Terraform Module

The `rancher-common` module contains all resources that do not depend on a
specific cloud provider. RKE, Kubernetes, Helm, and Rancher providers are used
given the necessary information about the infrastructure created in a cloud
provider.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement_helm)                | 2.10.1   |
| <a name="requirement_local"></a> [local](#requirement_local)             | 2.4.0    |
| <a name="requirement_rancher2"></a> [rancher2](#requirement_rancher2)    | 3.0.0    |
| <a name="requirement_ssh"></a> [ssh](#requirement_ssh)                   | 2.6.0    |

## Providers

| Name                                                                                          | Version |
| --------------------------------------------------------------------------------------------- | ------- |
| <a name="provider_helm"></a> [helm](#provider_helm)                                           | 2.10.1  |
| <a name="provider_local"></a> [local](#provider_local)                                        | 2.4.0   |
| <a name="provider_rancher2.admin"></a> [rancher2.admin](#provider_rancher2.admin)             | 3.0.0   |
| <a name="provider_rancher2.bootstrap"></a> [rancher2.bootstrap](#provider_rancher2.bootstrap) | 3.0.0   |
| <a name="provider_ssh"></a> [ssh](#provider_ssh)                                              | 2.6.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                                | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/2.10.1/docs/resources/release)                   | resource |
| [helm_release.rancher_server](https://registry.terraform.io/providers/hashicorp/helm/2.10.1/docs/resources/release)                 | resource |
| [local_file.kube_config_server_yaml](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/resources/file)             | resource |
| [local_file.kube_config_workload_yaml](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/resources/file)           | resource |
| [rancher2_bootstrap.admin](https://registry.terraform.io/providers/rancher/rancher2/3.0.0/docs/resources/bootstrap)                 | resource |
| [rancher2_cluster_v2.quickstart_workload](https://registry.terraform.io/providers/rancher/rancher2/3.0.0/docs/resources/cluster_v2) | resource |
| [ssh_resource.install_k3s](https://registry.terraform.io/providers/loafoe/ssh/2.6.0/docs/resources/resource)                        | resource |
| [ssh_resource.retrieve_config](https://registry.terraform.io/providers/loafoe/ssh/2.6.0/docs/resources/resource)                    | resource |

## Inputs

| Name                                                                                                               | Description                                                            | Type     | Default                                               | Required |
| ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------- | -------- | ----------------------------------------------------- | :------: |
| <a name="input_admin_password"></a> [admin_password](#input_admin_password)                                        | Admin password to use for Rancher server bootstrap, min. 12 characters | `string` | n/a                                                   |   yes    |
| <a name="input_node_public_ip"></a> [node_public_ip](#input_node_public_ip)                                        | Public IP of compute node for Rancher cluster                          | `string` | n/a                                                   |   yes    |
| <a name="input_node_username"></a> [node_username](#input_node_username)                                           | Username used for SSH access to the Rancher server cluster node        | `string` | n/a                                                   |   yes    |
| <a name="input_rancher_server_dns"></a> [rancher_server_dns](#input_rancher_server_dns)                            | DNS host name of the Rancher server                                    | `string` | n/a                                                   |   yes    |
| <a name="input_ssh_private_key_pem"></a> [ssh_private_key_pem](#input_ssh_private_key_pem)                         | Private key used for SSH access to the Rancher server cluster node     | `string` | n/a                                                   |   yes    |
| <a name="input_workload_cluster_name"></a> [workload_cluster_name](#input_workload_cluster_name)                   | Name for created custom workload cluster                               | `string` | n/a                                                   |   yes    |
| <a name="input_cert_manager_version"></a> [cert_manager_version](#input_cert_manager_version)                      | Version of cert-manager to install alongside Rancher (format: 0.0.0)   | `string` | `"1.11.0"`                                            |    no    |
| <a name="input_node_internal_ip"></a> [node_internal_ip](#input_node_internal_ip)                                  | Internal IP of compute node for Rancher cluster                        | `string` | `""`                                                  |    no    |
| <a name="input_rancher_helm_repository"></a> [rancher_helm_repository](#input_rancher_helm_repository)             | The helm repository, where the Rancher helm chart is installed from    | `string` | `"https://releases.rancher.com/server-charts/latest"` |    no    |
| <a name="input_rancher_kubernetes_version"></a> [rancher_kubernetes_version](#input_rancher_kubernetes_version)    | Kubernetes version to use for Rancher server cluster                   | `string` | `"v1.24.14+k3s1"`                                     |    no    |
| <a name="input_rancher_version"></a> [rancher_version](#input_rancher_version)                                     | Rancher server version (format v0.0.0)                                 | `string` | `"2.7.9"`                                             |    no    |
| <a name="input_workload_kubernetes_version"></a> [workload_kubernetes_version](#input_workload_kubernetes_version) | Kubernetes version to use for managed workload cluster                 | `string` | `"v1.24.14+rke2r1"`                                   |    no    |

## Outputs

| Name                                                                                                  | Description                                                 |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| <a name="output_custom_cluster_command"></a> [custom_cluster_command](#output_custom_cluster_command) | Docker command used to add a node to the quickstart cluster |
| <a name="output_rancher_url"></a> [rancher_url](#output_rancher_url)                                  | n/a                                                         |

<!-- END_TF_DOCS -->
