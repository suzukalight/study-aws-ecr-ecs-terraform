resource "aws_ecr_repository" "sample" {
  name = "sample"
}

# resource "aws_ecr_lifecycle_policy" "sample" {
#   repository = aws_ecr_repository.sample.arn

#   policy = <<EOF
#   [
#     "rules": [
#       {
#         "rulePriority": 1,
#         "description": "Keep last 30 release tagged images",
#         "selection": {
#           "tagStatus": "tagged",
#           "tagPrefixList": ["release"],
#           "countType": "imageCountMoreThan",
#           "countNumber": 30
#         },
#         "action": {
#           "type": "expire"
#         }
#       }
#     ]
#   ]
# EOF
# }
