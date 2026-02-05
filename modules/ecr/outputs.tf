
output "repository_urls" {
  description = "Mapa com URLs dos repositórios ECR"
  value = {
    for name, repo in aws_ecr_repository.this :
    name => repo.repository_url
  }
}

output "repository_arns" {
  description = "Mapa com ARNs dos repositórios ECR"
  value = {
    for name, repo in aws_ecr_repository.this :
    name => repo.arn
  }
}
