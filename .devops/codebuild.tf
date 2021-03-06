resource "aws_codebuild_project" "project" {
  name          = "${local.workspace-name}-codebuild"
  description   = "Fargate Mule Hello World project"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild.arn


  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.codebuild.bucket}/codebuild-cache"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "ECR_REPOSITORY"
      value = module.ecs.repository_url
    }

    environment_variable {
      name  = "SERVICE_NAME"
      value = var.container_name #module.ecs.service_name
    }
    
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codebuild.bucket}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  tags = {
    Terraform = "true"
  }
}