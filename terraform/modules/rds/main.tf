# variables and locals

variable "name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "database_name" {}
variable "master_username" {}
variable "master_password" {}

locals {
  name = "${var.name}-mysql"
}

# rds nerwork

resource "aws_security_group" "this" {
  name        = local.name
  description = local.name

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.name
  }
}

resource "aws_security_group_rule" "mysql" {
  security_group_id = aws_security_group.this.id

  type = "ingress"

  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"]
}

resource "aws_db_subnet_group" "this" {
  name        = local.name
  description = local.name
  subnet_ids  = var.subnet_ids
}

# rds cluster

resource "aws_rds_cluster" "this" {
  cluster_identifier = local.name

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  engine = "aurora-mysql"
  port   = "3306"

  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password

  final_snapshot_identifier = local.name
  skip_final_snapshot       = true
}

resource "aws_rds_cluster_instance" "this" {
  identifier         = local.name
  cluster_identifier = aws_rds_cluster.this.id

  engine         = "aurora-mysql"
  instance_class = "db.t3.small"
}

# outputs

output "endpoint" {
  value = aws_rds_cluster.this.endpoint
}
