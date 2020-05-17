variable "name" {}

data "template_file" "policy" {
  template = file("${path.module}/policy.json")
}

resource "aws_ecr_repository" "nginx" {
  name = "${var.name}-nginx"
}

resource "aws_ecr_lifecycle_policy" "nginx" {
  repository = aws_ecr_repository.nginx.name
  policy     = data.template_file.policy.rendered
}

resource "aws_ecr_repository" "backend" {
  name = "${var.name}-backend"
}

resource "aws_ecr_lifecycle_policy" "backend" {
  repository = aws_ecr_repository.backend.name
  policy     = data.template_file.policy.rendered
}
