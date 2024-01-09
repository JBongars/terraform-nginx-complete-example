output "nginx-ami" {
  value = data.aws_ami.nginx_ami.id
}
