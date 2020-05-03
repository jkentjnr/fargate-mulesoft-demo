output "codecommit_repo" {
  value = aws_codecommit_repository.repo.clone_url_http
}