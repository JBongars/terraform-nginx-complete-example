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

variable "max_azs" {
  description = "Max number of AZs to use"
  type        = number
  default     = 2
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "nginx_config" {
  description = "config for nginx server"
  type = object({
    instance_type         = optional(string, "t2.micro")
    instance_architecture = optional(string, "x86_64")
    instance_count        = optional(number, 1)
    instance_name_prefix  = optional(string, "nginx")
    instance_ami          = optional(string, null)
    nginx_config_path     = string
    key_file              = optional(string, null)
  })
}
