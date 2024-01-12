variable "vpc_id" {
  description = "VPC ID"
  type    = string
}

variable "environment" {
  description = "Environment"
  type    = string
  default = "dev"
}

variable "region" {
  description = "AWS Region"
  type    = string
  default = "ap-southeast-1"
}

variable "instance_type" {
  description = "Instance Type"
  type    = string
  default = "t2.micro"
}