
# managed nginx server from marketplace

# data "aws_ami" "nginx_ami" {
#   most_recent = true
#   owners      = ["amazon", "aws-marketplace"]

#   filter {
#     name   = "name"
#     values = ["nginx-plus-app-protect-ubuntu-18.04-*-${var.instance_architecture}-developer-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# our ami server created using packer

data "aws_ami" "nginx_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["nginx-base-${var.environment}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
