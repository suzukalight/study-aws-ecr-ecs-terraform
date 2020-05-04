resource "aws_acm_certificate" "mokmok" {
  domain_name               = data.aws_route53_zone.mokmok.name
  subject_alternative_names = []
  validation_method         = "DNS"
}
