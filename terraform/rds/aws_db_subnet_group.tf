resource "aws_db_subnet_group" "sample" {
  name = "dbsubnet"
  subnet_ids = [
    aws_subnet.private_0.id,
    aws_subnet.private_1.id
  ]
}
