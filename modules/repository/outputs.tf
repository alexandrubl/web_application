output "dev_repo_uri" {
  description = "Repo URI"
  value       = aws_ecrpublic_repository.dev_ecr_repo.repository_uri
}
