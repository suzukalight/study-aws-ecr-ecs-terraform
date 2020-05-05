resource "aws_ssm_parameter" "db_username" {
  name        = "DB_USERNAME"
  value       = "terraform"
  type        = "String"
  description = "DB USERNAME"
}

resource "aws_ssm_parameter" "db_raw_password" {
  name        = "DB_PASSWORD"
  value       = "uninitialized"
  type        = "SecureString"
  description = "DB PASSWORD"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "db_hostname" {
  name        = "DB_HOSTNAME"
  value       = aws_db_instance.sample.address
  type        = "String"
  description = "DB HOSTNAME"
}

#
# Please overwrite the password manually with the following command;
#
# $ aws ssm put-parameter --name 'DB_PASSWORD' --type SecureString --value 'ModifiedStrongPassword!' --overwrite