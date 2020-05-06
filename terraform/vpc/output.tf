output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_public_0_id" {
  value = aws_subnet.public_0.id
}
output "subnet_public_1_id" {
  value = aws_subnet.public_1.id
}
output "subnet_private_0_id" {
  value = aws_subnet.private_0.id
}
output "subnet_private_1_id" {
  value = aws_subnet.private_1.id
}
