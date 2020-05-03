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

variable "availability_zone_A" {
  description = "First availability zone"
  default     = "ap-southeast-2a"
}

variable "availability_zone_B" {
  description = "Second availability zone"
  default     = "ap-southeast-2b"
}

variable "alb_port" {
  description = "The application port"
  default     = "80"
}

variable "container_port" {
  description = "The container port"
  default     = "8081"
}

################################
###### QUICK EDIT'S HERE  ######
################################

###### CLUSTER OPTIONS  ######

# Customize the Cluster Name
variable "cluster_name" {
  description = "ECS Cluster Name"
  default     = "fargate-mulesoft-cluster"
}

# Customize your ECR Registry Name
variable "app_repository_name" {
  description = "ECR Repository Name"
  default     = "fargate-mulesoft-hello-world"
}

###### APPLICATION OPTIONS  ######
variable "container_name" {
  description = "Container app name"
  default     = "fargate-mulesoft-hello-world-app"
}

# Number of containers
variable "desired_tasks" {
  description = "Number of containers desired to run app task"
  default     = 1
}

variable "min_tasks" {
  description = "Minimum"
  default     = 1
}

variable "max_tasks" {
  description = "Maximum"
  default     = 2
}

variable "cpu_to_scale_up" {
  description = "CPU % to Scale Up the number of containers"
  default     = 80
}

variable "cpu_to_scale_down" {
  description = "CPU % to Scale Down the number of containers"
  default     = 30
}

# Desired CPU
variable "desired_task_cpu" {
  description = "Desired CPU to run your tasks"
  default     = "2048"
}

# Desired Memory
variable "desired_task_memory" {
  description = "Desired memory to run your tasks"
  default     = "4096"
}
