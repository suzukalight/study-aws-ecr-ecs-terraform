data "aws_route53_zone" "mokmok" {
  name = "mokmok.cloud"
}

resource "aws_route53_record" "mokmok" {
  zone_id = data.aws_route53_zone.mokmok.zone_id
  name    = data.aws_route53_zone.mokmok.name
  type    = "A"
  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}
