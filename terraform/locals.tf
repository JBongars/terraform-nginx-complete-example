locals {
  region       = var.region
  nginx_config = var.nginx_config
  project      = var.project_name
  vpc_cidr     = var.cidr_block

  azs = slice(data.aws_availability_zones.available.names, 0, var.max_azs)

  tags = {
    Project              = var.project_name
    Environment          = var.environment
    GithubRepo           = ""
    TerraformStateBucket = ""
    ManagedBy            = "Terraform"
    Experimental         = "true"
  }
}
