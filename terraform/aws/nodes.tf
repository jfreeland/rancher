# AWS EC2 instance for creating a single node workload cluster
# tfsec:ignore:AVD-AWS-0028
# tfsec:ignore:AVD-AWS-0131
resource "aws_instance" "worker" {
  count = 3

  depends_on = [
    aws_route_table_association.rancher_route_table_association
  ]

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name                    = aws_key_pair.quickstart_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.rancher_sg_allowall.id]
  subnet_id                   = aws_subnet.rancher_subnet.id
  associate_public_ip_address = true

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }
  }

  root_block_device {
    volume_size = 40
    volume_type = "gp3"
    #encrypted   = true
  }

  user_data = templatefile(
    "${path.module}/files/userdata_quickstart_node.template",
    {
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }

  tags = {
    Name = "${var.prefix}-worker-node"
  }
}
