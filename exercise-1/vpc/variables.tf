variable "global_tags" {
  description = "Global tags to be passed to resources in submodule"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  #default     = "11.0.0.0/16"
}

variable "public_subnet_cidrs_1" {
  description = "CIDR blocks for the public subnets"
  default     = "11.0.1.0/24"
}

variable "public_subnet_cidrs_2" {
  description = "CIDR blocks for the public subnets"
  default     = "11.0.2.0/24"
}

variable "private_subnet_cidrs_1" {
  description = "CIDR blocks for the private subnets"
  default     = "11.0.3.0/24"
}

variable "private_subnet_cidrs_2" {
  description = "CIDR blocks for the private subnets"
  default     = "11.0.4.0/24"
}

variable "global_tag_prefix" {
  description = "Global tag prefix"
}