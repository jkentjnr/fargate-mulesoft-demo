module "vpc" {
  source                = "./modules/vpc"
  cluster_name          = local.workspace-name
  availability_zone_A   = var.availability_zone_A
  availability_zone_B   = var.availability_zone_B
  alb_port              = var.alb_port
  container_port        = var.container_port
}

module "ecs" {
  source              = "./modules/ecs"
  aws_region          = var.aws_region
  vpc_id              = module.vpc.vpc_id
  cluster_name        = var.cluster_name
  container_name      = var.container_name
  public_subnet_A     = module.vpc.public_subnet_A
  public_subnet_B     = module.vpc.public_subnet_B
  app_sg_id           = module.vpc.app_sg_id
  alb_sg_id           = module.vpc.alb_sg_id
  ecs_sg_id           = module.vpc.ecs_sg_id
  app_repository_name = var.app_repository_name
  alb_port            = var.alb_port
  container_port      = var.container_port
  min_tasks           = var.min_tasks
  max_tasks           = var.max_tasks
  cpu_to_scale_up     = var.cpu_to_scale_up
  cpu_to_scale_down   = var.cpu_to_scale_down
  desired_tasks       = var.desired_tasks
  desired_task_cpu    = var.desired_task_cpu
  desired_task_memory = var.desired_task_memory

  security_groups_ids = [
    module.vpc.app_sg_id,
    module.vpc.alb_sg_id,
    module.vpc.ecs_sg_id,
  ]

  availability_zones = flatten([
    module.vpc.public_subnet_A,
    module.vpc.public_subnet_B,
  ])
}