#variable "global_tag_prefix" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-vpc-exercise-2"
  })
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  count = var.total_subnets == 0 ? length(data.aws_availability_zones.available.names) : var.total_subnets
  cidr_block        = "12.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-PublicSubnet-${element(data.aws_availability_zones.available.names, count.index)}"
  })
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  count = var.total_subnets == 0 ? length(data.aws_availability_zones.available.names) : var.total_subnets
  cidr_block        = "12.0.${count.index + 100}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-PrivateSubnet-${element(data.aws_availability_zones.available.names, count.index)}"
  })
}