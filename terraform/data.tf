# get nginx ami from aws
data "aws_ami" "nginx_ami" {
  most_recent = true
  owners      = ["amazon", "aws-marketplace"]

  filter {
    name   = "name"
    values = ["nginx-plus-app-protect-ubuntu-18.04-v3.0-${local.nginx_config.instance_architecture}-developer-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
