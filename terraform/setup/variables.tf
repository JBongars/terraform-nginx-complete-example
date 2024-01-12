variable "region" {
  description = "AWS region to deploy to"
  default     = "ap-southeast-1"
}

variable "backend_name" {
  description = "the name to give the bucket"
  type        = string
}

variable "principals" {
  type        = list(string)
  description = "list of user/role ARNs to get full access to the bucket"
  default     = []
}

variable "elect_self_as_principal" {
  type        = bool
  description = "elect self as principal"
  default     = true
}

variable "versioning" {
  type        = bool
  description = "enables versioning for objects in the S3 bucket"
  default     = true
}
