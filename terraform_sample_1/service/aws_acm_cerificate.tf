resource "aws_acm_certificate" "mokmok" {
  domain_name               = data.aws_route53_zone.mokmok.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "mokmok" {
  certificate_arn         = aws_acm_certificate.mokmok.arn
  validation_record_fqdns = [aws_route53_record.mokmok_certificate.fqdn]
}
