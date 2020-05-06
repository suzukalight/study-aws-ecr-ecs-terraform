data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "study-aws-ecr-ecs-terraform-suzukalight"
    key    = "sample/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
