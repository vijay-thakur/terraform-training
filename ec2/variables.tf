variable "global_tags" {
  description = "Global tags to be passed to resources in submodule"
  type        = map(string)
  default     = {}
}

variable "public_subnet_id" {
  description = "ID of the public subnet 1"
}

variable "global_tag_prefix" {
  description = "Global tag prefix"
  default     = "vijay"
}

variable "ami" {
  description = "Amazon Linux Ami in ap-south-1"
  default     = "ami-0da59f1af71ea4ad2"
}

variable "instance_type" {
  description = "Instance type like t2.micro"
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "EBS volume size"
  default     = "8"

}

variable "root_volume_type" {
  description = "Volume type"
  default     = "gp3"
}

variable "ebs_volume_size" {
  description = "EBS volume size"
  default     = "8"

}

variable "ebs_volume_type" {
  description = "Volume type"
  default     = "gp3"
}

variable "availability_zone" {
  description = "Set availability zone for EC2 instance and EBS volume"
  default     = "ap-south-1a"
}