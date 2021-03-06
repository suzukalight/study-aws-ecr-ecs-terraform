resource "aws_ssm_parameter" "db_hostname" {
  name        = "/sample/DB_HOST"
  value       = aws_db_instance.sample.address
  type        = "String"
  description = "DB host name"
}

resource "aws_ssm_parameter" "db_database" {
  name        = "/sample/DB_DATABASE"
  value       = "terraform"
  type        = "String"
  description = "DB name"
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/sample/DB_USERNAME"
  value       = "admin"
  type        = "String"
  description = "DB user"
}

resource "aws_ssm_parameter" "db_raw_password" {
  name        = "/sample/DB_PASSWORD"
  value       = "uninitialized"
  type        = "SecureString"
  description = "DB password"

  lifecycle {
    ignore_changes = [value]
  }
}

# Please overwrite the password manually with the following command;
# ---
# $ aws ssm put-parameter --name '/sample/DB_PASSWORD' --type SecureString --overwrite --value 'ModifiedStrongPassword!'
# ---
