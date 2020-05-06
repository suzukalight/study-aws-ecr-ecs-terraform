resource "aws_subnet" "private_0" {
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "private_1" {
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block        = "10.0.48.0/20"
  availability_zone = "ap-northeast-1c"
}
