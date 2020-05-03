resource "aws_iam_role" "codebuild" {
  name = "${local.workspace-name}-codebuild"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role_attach_codebuild_ecr_read" {
  role = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "role_attach_codepipeline_ecs_full" {
  role = aws_iam_role.codepipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceFullAccess"
}



resource "aws_iam_role" "codepipeline" {
  name = "${local.workspace-name}-pipeline"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role_attach_codebuild" {
  role = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.devops.arn
}

resource "aws_iam_role_policy_attachment" "role_attach_codepipeline" {
  role = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.devops.arn
}

resource "aws_iam_policy" "devops" {
  name = "${local.workspace-name}-devops"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": "iam:PassRole",
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Resource": [
        "${module.ecs.repository_arn}"
      ],
      "Action": [
        "ecr:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "${aws_codecommit_repository.repo.arn}"
      ],
      "Action": [
        "codecommit:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "${aws_codebuild_project.project.arn}"
      ],
      "Action": [
        "codebuild:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.codebuild.arn}",
        "${aws_s3_bucket.codebuild.arn}/*",
        "${aws_s3_bucket.codepipeline.arn}",
        "${aws_s3_bucket.codepipeline.arn}/*"
      ]
    }
  ]
}
POLICY
}