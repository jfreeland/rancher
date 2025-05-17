resource "aws_route53_record" "poor" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "poor.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "30"
  records = [for ip in aws_instance.worker[*].public_ip : ip]
}
