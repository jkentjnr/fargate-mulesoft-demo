resource "aws_codecommit_repository" "repo" {
  repository_name = local.repository-name
  description     = "Fargate/Mule Sample App Repository"
}