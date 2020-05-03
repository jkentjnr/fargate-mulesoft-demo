variable "cluster_name" {
  description = "The cluster_name"
}

variable "availability_zone_A" {
  description = "First availability zone"
}

variable "availability_zone_B" {
  description = "Second availability zone"
}

variable "alb_port" {
  description = "Origin Application Load Balancer Port"
}

# Target Group Load Balancer Port
variable "container_port" {
  description = "Destination Application Load Balancer Port"
}
