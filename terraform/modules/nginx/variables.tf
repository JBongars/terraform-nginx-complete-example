variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "nginx"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-12345678"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_architecture" {
  description = "instance architecture"
  type        = string
  default     = "x86_64"
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
}

variable "nginx_config_path" {
  description = "nginx config path"
  type        = string
}

variable "ssl_cert_path" {
  description = "ssl cert path"
  type        = string
}

variable "key_file" {
  description = "key file"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}
