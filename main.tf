provider "aws" {
  region = "ap-northeast-1"
}

module "ecr" {
  source     = "./iac"
  profile    = "suzukalight"
  region     = "ap-northeast-1"
  image_name = "study-ecr-terraform"
  docker_dir = "."
}
