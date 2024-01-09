variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
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
  })
}
