# variables

variable "name" {}
variable "domain" {}

# ACM

data "aws_route53_zone" "this" {
  name         = var.domain
  private_zone = false
}

resource "aws_acm_certificate" "this" {
  domain_name = var.domain

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "this" {
  depends_on = [aws_acm_certificate.this]

  zone_id = data.aws_route53_zone.this.id

  ttl = 60

  name    = aws_acm_certificate.this.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.this.domain_validation_options.0.resource_record_type
  records = [aws_acm_certificate.this.domain_validation_options.0.resource_record_value]
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = aws_route53_record.this.*.fqdn
}

# outputs

output "acm_id" {
  value = aws_acm_certificate.this.id
}
