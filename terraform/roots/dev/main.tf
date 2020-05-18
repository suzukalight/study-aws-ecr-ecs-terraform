# --------------------
# terraform settings
# --------------------

terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket  = "study-aws-ecr-ecs-terraform-suzukalight"
    key     = "sample/roots/dev/terraform.tfstate"
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

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "domain" {
  default = "mokmok.cloud"
}

locals {
  db_database    = "terraform"
  db_username    = "terraform"
  server_port    = 23456
  jwt_expires_in = "30m"
}

data "aws_ssm_parameter" "db_password" {
  name = "/${var.name}/DB_PASSWORD"
}

data "aws_ssm_parameter" "jwt_secret" {
  name = "/${var.name}/JWT_SECRET"
}

# --------------------
# modules
# --------------------

module "network" {
  source = "../../modules/network"

  name = var.name
  azs  = var.azs
}

# module "acm" {
#   source = "../../modules/acm"

#   name   = var.name
#   domain = var.domain
# }

module "lb" {
  source = "../../modules/lb"

  name              = var.name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  domain            = var.domain
  # acm_id            = module.acm.acm_id
}

module "ecs_cluster" {
  source = "../../modules/ecs_cluster"

  name = var.name
}

module "rds" {
  source = "../../modules/rds"

  name       = var.name
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  database_name   = local.db_database
  master_username = local.db_username
  master_password = data.aws_ssm_parameter.db_password.value
}

module "ecs_app" {
  source = "../../modules/ecs_app"

  name         = var.name
  cluster_name = module.ecs_cluster.cluster_name
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.private_subnet_ids
  # https_listener_arn = module.lb.https_listener_arn
  http_listener_arn = module.lb.http_listener_arn

  db_host        = module.rds.endpoint
  db_database    = local.db_database
  db_username    = local.db_username
  db_password    = data.aws_ssm_parameter.db_password.value
  server_port    = local.server_port
  jwt_secret     = data.aws_ssm_parameter.jwt_secret.value
  jwt_expires_in = local.jwt_expires_in
}
