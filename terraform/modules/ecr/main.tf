# ECR repository for Express app
resource "aws_ecr_repository" "app_repo" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
  tags                 = var.tags
}