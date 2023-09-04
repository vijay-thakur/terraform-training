module "vpc" {
  source            = "./vpc"
  global_tags       = var.global_tags
  global_tag_prefix = var.global_tag_prefix
  vpc_cidr          = var.vpc_cidr
  total_subnets     = var.total_subnets
}

# module "ec2" {
#   source            = "./ec2"
#   public_subnet_id  = module.vpc.public_subnet_id_1
#   global_tags       = var.global_tags
#   global_tag_prefix = var.global_tag_prefix
# }

# module "rds" {
#   source              = "./rds"
#   vpc_id              = module.vpc.vpc_id
#   private_subnet_id_1 = module.vpc.private_subnet_id_1
#   private_subnet_id_2 = module.vpc.private_subnet_id_2
#   global_tags         = var.global_tags
#   global_tag_prefix   = var.global_tag_prefix
#   vpc_cidr            = var.vpc_cidr
# }