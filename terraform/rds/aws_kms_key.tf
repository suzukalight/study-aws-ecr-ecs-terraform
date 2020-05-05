resource "aws_kms_key" "sample" {
  description             = "Example custom master key"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30
}
