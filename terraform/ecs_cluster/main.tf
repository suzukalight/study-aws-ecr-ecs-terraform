# variables

variable "name" {}

# ECS Cluster

resource "aws_ecs_cluster" "this" {
  name = var.name
}

# outputs 

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}
