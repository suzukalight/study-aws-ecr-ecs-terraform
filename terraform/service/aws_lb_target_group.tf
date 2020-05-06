resource "aws_lb_target_group" "http" {
  name                 = "sample-http"
  target_type          = "ip"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  port                 = 23456
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/health_check"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.sample]
}
