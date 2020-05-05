resource "aws_db_instance" "sample" {
  identifier     = "sample"
  engine         = "mysql"
  engine_version = "5.7.25"

  instance_class        = "db.t3.small"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = true

  kms_key_id = aws_kms_key.sample.arn

  username = "admin"
  password = "VerifyStrongPassword!"

  multi_az            = true
  publicly_accessible = false

  backup_window              = "09:10-09:40"
  backup_retention_period    = 30
  maintenance_window         = "mon:10:10-mon:10:40"
  auto_minor_version_upgrade = false

  port              = 3306
  apply_immediately = false

  vpc_security_group_ids = [aws_security_group.db.id]
  parameter_group_name   = aws_db_parameter_group.sample.name
  option_group_name      = aws_db_option_group.sample.name
  db_subnet_group_name   = aws_db_subnet_group.sample.name

  deletion_protection = false
  skip_final_snapshot = true

  lifecycle {
    ignore_changes = [password]
  }
}
