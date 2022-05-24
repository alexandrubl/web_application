resource "aws_ecrpublic_repository" "ecr_repo" {
  repository_name                 = "${var.ecr_name}-repo"
}
