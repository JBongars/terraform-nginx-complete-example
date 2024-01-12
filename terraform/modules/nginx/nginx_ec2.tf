
resource "aws_security_group" "allow_nginx" {
  name        = "${var.project_name}-allow-nginx"
  description = "Allow NGINX traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow icmp (disable for production)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_key_pair" "key_pair" {
  key_name   = local.key_name
  public_key = file("${var.key_file}.pub")

  tags = var.tags
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-nginx-ec2"

  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_nginx.id]

  ami = data.aws_ami.nginx_ami.id

  monitoring                  = true
  associate_public_ip_address = true

  subnet_id = var.subnet_id

  tags = var.tags
}

resource "null_resource" "nginx_configuration" {
  triggers = {
    instance_id    = module.ec2_instance.arn
    nginx_conf_sha = filesha256(var.nginx_config_path)
    ssl_cert_sha   = filesha256("${var.ssl_cert_path}.crt")
  }

  provisioner "file" {
    source      = var.nginx_config_path
    destination = "/tmp/updated-nginx.conf"
  }

  provisioner "file" {
    source      = "${var.ssl_cert_path}.crt"
    destination = "/tmp/ssl.crt"
  }

  provisioner "file" {
    source      = "${var.ssl_cert_path}.key"
    destination = "/tmp/ssl.key"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/updated-nginx.conf /etc/nginx/nginx.conf",
      "sudo mv /tmp/ssl.crt /etc/nginx/ssl.crt",
      "sudo mv /tmp/ssl.key /etc/nginx/ssl.key",
      "sudo systemctl restart nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user" # or the appropriate username for your AMI
    private_key = file("${var.key_file}")
    host        = module.ec2_instance.public_ip
  }
}
