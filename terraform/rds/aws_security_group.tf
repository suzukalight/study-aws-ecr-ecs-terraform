resource "aws_security_group" "db" {
  name        = "sample-db"
  description = "DB"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.cidr_block]
  }
}
