# Creates ecr repository to host docker images. 

resource "aws_ecr_repository" "app_ecr_repo" {
  name = var.ecr_repo
  image_scanning_configuration {
    scan_on_push = true
  }
}