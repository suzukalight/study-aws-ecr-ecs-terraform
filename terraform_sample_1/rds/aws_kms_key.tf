resource "aws_kms_key" "sample" {
  description             = "Example custom master key"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "sample" {
  name          = "alias/sample"
  target_key_id = aws_kms_key.sample.id
}
