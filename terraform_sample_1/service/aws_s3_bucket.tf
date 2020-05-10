resource "aws_s3_bucket" "alb_log" {
  bucket = "sample-alb-log-suzukalight"

  lifecycle_rule {
    enabled = true

    expiration {
      days = 180
    }
  }

  force_destroy = true # true can also delete bucket contents
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json

}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]
    principals {
      type        = "AWS"
      identifiers = ["582318560864"]
    }
  }
}
