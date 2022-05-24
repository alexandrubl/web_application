output "repo_uri" {
  description = "Repo URI"
  value       = aws_ecrpublic_repository.ecr_repo.repository_uri
}