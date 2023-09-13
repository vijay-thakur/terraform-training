variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "bucket" {
  description = "S3 bucekt name to save Terraform state"
  default     = "nclouds-academy-vijay"
}

variable "dynamodb_table" {
  description = "DynamoDB table to manage state locking"
  default     = "terraform_train_locks"
}

variable "global_tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default = {
    Environment = "training",
    Project     = "nclouds-academy"
    Owner       = "vijay"
    // Add more tags as needed
  }
}

variable "global_tag_prefix" {
  description = "Global tag prefix"
  default     = "vijay"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "11.0.0.0/16"
}