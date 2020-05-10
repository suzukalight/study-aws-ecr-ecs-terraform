resource "aws_lb" "sample" {
  name                       = "sample-lb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  security_groups = [
    aws_security_group.alb.id,
  ]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }

  subnets = [
    data.terraform_remote_state.vpc.outputs.subnet_public_0_id,
    data.terraform_remote_state.vpc.outputs.subnet_public_1_id,
  ]
}
