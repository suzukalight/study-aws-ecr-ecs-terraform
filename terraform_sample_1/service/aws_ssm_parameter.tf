resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/sample/JWT_SECRET"
  value       = "your_jwt_secret_phrase"
  type        = "SecureString"
  description = "JWT Secret"
}

resource "aws_ssm_parameter" "jwt_expires_in" {
  name        = "/sample/JWT_EXPIRES_IN"
  value       = "30m"
  type        = "String"
  description = "jwt expires in"
}

resource "aws_ssm_parameter" "server_port" {
  name        = "/sample/SERVER_PORT"
  value       = "23456"
  type        = "String"
  description = "server port"
}
