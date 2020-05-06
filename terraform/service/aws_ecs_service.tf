resource "aws_ecs_service" "webapp-service" {
  name             = "webapp-service"
  cluster          = aws_ecs_cluster.sample-ecs-cluster.arn
  task_definition  = aws_ecs_task_definition.sample-task.arn
  launch_type      = "FARGATE"
  platform_version = "1.3.0"

  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.instance.id]

    subnets = [
      data.terraform_remote_state.vpc.outputs.subnet_private_0_id,
      data.terraform_remote_state.vpc.outputs.subnet_private_1_id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.http.arn
    container_name   = "sample-webapp"
    container_port   = 23456
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
