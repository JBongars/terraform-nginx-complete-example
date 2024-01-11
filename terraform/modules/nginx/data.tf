
# get nginx ami from aws
data "aws_ami" "nginx_ami" {
  most_recent = true
  owners      = ["amazon", "aws-marketplace"]

  filter {
    name   = "name"
    values = ["nginx-plus-app-protect-ubuntu-18.04-*-${var.instance_architecture}-developer-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
