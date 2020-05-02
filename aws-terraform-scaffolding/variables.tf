variable "name" {
  description = "Name"
  default     = "fargate-mulesoft-hello-world"
}

variable "aws_profile" {
  description = "The AWS profile to use in the AWS credentials file."
  default     = "mlc-dev"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-southeast-2"
}
