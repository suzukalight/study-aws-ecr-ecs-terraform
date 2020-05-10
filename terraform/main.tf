# --------------------
# terraform settings
# --------------------

terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket = "study-aws-ecr-ecs-terraform-suzukalight"
    key    = "sample2/terraform.tfstate"
    region = "ap-northeast-1"
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
  default = "sample2"
}

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "domain" {
  default = "mokmok.cloud"
}

# --------------------
# modules
# --------------------

module "network" {
  source = "./network"

  name = var.name
  azs  = var.azs
}

module "acm" {
  source = "./acm"

  name   = var.name
  domain = var.domain
}

module "lb" {
  source = "./lb"

  name              = var.name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  domain            = var.domain
  acm_id            = module.acm.acm_id
}

module "ecs_cluster" {
  source = "./ecs_cluster"

  name = var.name
}

module "nginx" {
  source = "./nginx"

  name = var.name

  cluster_name       = module.ecs_cluster.cluster_name
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.private_subnet_ids
  https_listener_arn = module.lb.https_listener_arn
}
