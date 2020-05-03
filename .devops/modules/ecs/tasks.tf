data "template_file" "api_task" {
  template = "${file("${path.module}/task-definitions/api-task.json")}"

  vars = {
    image               = aws_ecr_repository.web-app.repository_url
    aws_region          = var.aws_region
    container_name      = var.container_name
    host_port           = var.alb_port
    container_port      = var.container_port
    log_group           = aws_cloudwatch_log_group.web-app.name
    desired_task_cpu    = var.desired_task_cpu
    desired_task_memory = var.desired_task_memory
  }
}

resource "aws_ecs_task_definition" "web-api" {
  family                   = "${var.cluster_name}_app"
  container_definitions    = data.template_file.api_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_memory

  volume {
    name      = "logs"
  }

  volume {
    name      = "conf"
  }

  volume {
    name      = "apps"
  }

  volume {
    name      = "domains"
  }

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}
