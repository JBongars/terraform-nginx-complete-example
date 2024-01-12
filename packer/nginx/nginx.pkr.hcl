source "amazon-ebs" "nginx-base" {
  region        = var.region
  instance_type = var.instance_type
  ssh_username  = "ec2-user"
  ami_name      = "nginx-base-${var.environment}-${formatdate("YYYYMMDDHHmmss", timestamp())}"

  vpc_id = var.vpc_id

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      "virtualization-type" = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  tags = {
    Name = "nginx-base-${var.environment}-${formatdate("YYYYMMDDHHmmss", timestamp())}"
    Environment = var.environment
    Owner = "Packer"
    BaseAMI = "Amazon Linux 2"
    Instance = var.instance_type
  }
}

build {
  sources = [
    "source.amazon-ebs.nginx-base"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1.12",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
