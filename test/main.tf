provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket = "study-aws-ecr-ecs-terraform"
    key    = "test/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
