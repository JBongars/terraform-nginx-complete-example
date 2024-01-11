output "ami_id" {
  description = "AMI"
  value       = data.aws_ami.nginx_ami.arn
}

output "arn" {
  description = "ec2 instance arn"
  value       = module.ec2_instance.arn
}

output "public_ip" {
  description = "Public IP"
  value       = module.ec2_instance.public_ip
}

output "public_dns" {
  description = "Public DNS"
  value       = module.ec2_instance.public_dns
}

output "key" {
  description = "Key info"
  value       = aws_key_pair.key_pair.public_key
}
