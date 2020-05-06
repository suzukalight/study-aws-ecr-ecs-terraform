resource "aws_cloudwatch_log_group" "sample-service" {
  name              = "sample-service"
  retention_in_days = 180
}
