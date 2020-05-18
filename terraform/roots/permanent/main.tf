# --------------------
# terraform settings
# --------------------

terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket  = "study-aws-ecr-ecs-terraform-suzukalight"
    key     = "sample/roots/permanent/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}

# --------------------
# aws provider settings
# --------------------

provider "aws" {
  version = "2.60.0"
  region  = "ap-northeast-1"
}

provider "template" {
  version = "2.1"
}

# --------------------
# variables
# --------------------

variable "name" {
  default = "sample"
}

# --------------------
# modules
# --------------------

module "ecr" {
  source = "../../modules/ecr"

  name = var.name
}

# --------------------
# SSM secret keys
# --------------------

resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/${var.name}/JWT_SECRET"
  value       = "jwt_secret_temp"
  type        = "SecureString"
  description = "JWT Secret"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.name}/DB_PASSWORD"
  value       = "db_password_temp"
  type        = "SecureString"
  description = "DB PASSWORD"

  lifecycle {
    ignore_changes = [value]
  }
}
