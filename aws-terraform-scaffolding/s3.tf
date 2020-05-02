resource "aws_s3_bucket" "codebuild" {
  bucket = "${local.workspace-name}-codebuild"
  acl    = "private"
}

resource "aws_s3_bucket" "codepipeline" {
  bucket = "${local.workspace-name}-codepipeline"
  acl    = "private"
}
