resource "aws_route53_record" "mokmok" {
  zone_id = data.aws_route53_zone.mokmok.zone_id
  name    = data.aws_route53_zone.mokmok.name
  type    = "A"
  alias {
    name                   = aws_lb.sample.dns_name
    zone_id                = aws_lb.sample.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "mokmok_certificate" {
  zone_id = data.aws_route53_zone.mokmok.id
  name    = aws_acm_certificate.mokmok.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.mokmok.domain_validation_options[0].resource_record_type
  records = [
    aws_acm_certificate.mokmok.domain_validation_options[0].resource_record_value
  ]
  ttl = 60
}
