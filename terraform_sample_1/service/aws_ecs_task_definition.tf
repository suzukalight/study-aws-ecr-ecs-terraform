resource "aws_ecs_task_definition" "sample-task" {
  family                   = "webapp-service"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = file("./container_definitions/service.json")
  # task_role_arn         = data.terraform_remote_state.aws_iam.outputs.ecs_task_role_arn
  # execution_role_arn    = data.terraform_remote_state.aws_iam.outputs.ecs_task_role_arn
  task_role_arn      = module.ecs_task_execution_role.iam_role_arn
  execution_role_arn = module.ecs_task_execution_role.iam_role_arn
}
