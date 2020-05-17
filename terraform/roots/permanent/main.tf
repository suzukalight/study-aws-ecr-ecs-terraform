# --------------------
# terraform settings
# --------------------

terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket = "study-aws-ecr-ecs-terraform-suzukalight"
    key    = "sample-ecs/permanent/terraform.tfstate"
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
  default = "sample"
}

# --------------------
# modules
# --------------------

module "ecr" {
  source = "../../modules/ecr"

  name = var.name
}
