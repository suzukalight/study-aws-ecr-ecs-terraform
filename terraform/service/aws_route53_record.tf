resource "aws_route53_record" "mokmok_certificate" {
  zone_id = data.aws_route53_zone.mokmok.id
  name    = aws_acm_certificate.mokmok.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.mokmok.domain_validation_options[0].resource_record_type
  records = [
    aws_acm_certificate.mokmok.domain_validation_options[0].resource_record_value
  ]
  ttl = 60
}
