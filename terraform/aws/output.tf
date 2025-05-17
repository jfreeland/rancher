output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}

output "rancher_node_ip" {
  value = aws_instance.rancher_server.public_ip
}

output "workload_node1_ip" {
  value = aws_instance.workload_node1.public_ip
}

output "workload_node2_ip" {
  value = aws_instance.workload_node2.public_ip
}
