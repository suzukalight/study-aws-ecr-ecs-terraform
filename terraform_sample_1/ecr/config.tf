terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket = "study-aws-ecr-ecs-terraform-suzukalight"
    key    = "sample/ecr/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
provider "aws" {
  version = "2.60.0"
  region  = "ap-northeast-1"
}
