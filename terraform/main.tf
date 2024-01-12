
module "nginx" {
  source = "./modules/nginx"

  region       = var.region
  project_name = var.project_name

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]

  instance_type         = var.nginx_config.instance_type
  instance_architecture = var.nginx_config.instance_architecture

  nginx_config_path = var.nginx_config.nginx_config_path
  key_file          = var.nginx_config.key_file
  ssl_cert_path     = var.nginx_config.ssl_cert_path

  tags = local.tags
}
