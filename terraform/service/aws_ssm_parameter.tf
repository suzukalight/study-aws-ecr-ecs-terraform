resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/sample/JWT_SECRET"
  value       = "your_jwt_secret_phrase"
  type        = "SecureString"
  description = "JWT Secret"
}
