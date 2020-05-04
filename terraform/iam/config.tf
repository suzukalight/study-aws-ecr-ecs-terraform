terraform {
  backend "s3" {
    bucket = "study-aws-ecr-ecs-terraform-suzukalight"
    key    = "sample/iam/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}