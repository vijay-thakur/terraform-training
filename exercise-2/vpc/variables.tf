variable "global_tags" {
  description = "Global tags to be passed to resources in submodule"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "11.0.0.0/16"
}

variable "global_tag_prefix" {
  description = "Global tag prefix"
}

variable "total_subnets" {
  default = 0
}