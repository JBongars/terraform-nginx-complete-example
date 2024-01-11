module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.4"

  name = "${local.project}-vpc"
  cidr = local.vpc_cidr
  azs  = local.azs

  # no need for private subnets
  #   private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k + 4)]

  # disable nat gateway as there is no private subnet
  enable_nat_gateway = false
  single_nat_gateway = false

  public_inbound_acl_rules = [
    {
      protocol   = "-1"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]

  public_outbound_acl_rules = [
    {
      protocol   = "-1"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]

  # enable flow log
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = local.tags
}
