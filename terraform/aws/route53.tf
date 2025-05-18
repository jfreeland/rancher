locals {
  dns_hosts = ["poor", "elastic", "kibana"]
}
resource "aws_route53_record" "rancher" {
  for_each = toset(local.dns_hosts)

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${each.key}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "30"
  records = [for ip in aws_instance.worker[*].public_ip : ip]
}
