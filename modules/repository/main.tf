resource "aws_ecrpublic_repository" "dev_ecr_repo" {
  repository_name                 = "${var.ecr_name}-repo"
#  image_tag_mutability = "MUTABLE"

#  image_scanning_configuration {
#    scan_on_push = true
#  }
}
