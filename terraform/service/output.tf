
output "instance_id" {
  value = aws_security_group.instance.id
}

output "alb_dns_name" {
  value = aws_lb.sample.dns_name
}

output "domain_name" {
  value = aws_route53_record.mokmok.name
}
