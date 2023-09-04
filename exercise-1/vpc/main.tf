#variable "global_tag_prefix" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-vpc"
  })
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet_cidrs_1" {
#   count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs_1
#  availability_zone       = element(data.aws_availability_zones.available.names, count.index) # Change as needed
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-PublicSubnet-1"
  })
}

resource "aws_subnet" "public_subnet_cidrs_2" {
#   count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs_2
#  availability_zone       = element(data.aws_availability_zones.available.names, count.index) # Change as needed
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-PublicSubnet-2"
  })
}

resource "aws_subnet" "private_subnet_cidrs_1" {
# count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs_1
#  availability_zone = element(data.aws_availability_zones.available.names, count.index) # Change as needed
  availability_zone       = "ap-south-1a"
  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-PrivateSubnet-1"
  })
}

resource "aws_subnet" "private_subnet_cidrs_2" {
# count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs_2
#  availability_zone = element(data.aws_availability_zones.available.names, count.index) # Change as needed
  availability_zone       = "ap-south-1b"
  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-PrivateSubnet-2"
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-igw"
  })
}

resource "aws_eip" "nat" {
  #   count = length(aws_subnet.public)
  domain = "vpc"

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-eip-natgw"
  })
}

resource "aws_nat_gateway" "nat" {
#  count = 1

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_cidrs_2.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-natgw"
  })
}


resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-rtb-public-1"
  })
}

resource "aws_route_table" "public_route_table_2" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-rtb-public-2"
  })
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-rtb-private-1"
  })
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-rtb-private-2"
  })
}

resource "aws_route_table_association" "public_1" {
#  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public_subnet_cidrs_1.id
  route_table_id = aws_route_table.public_route_table_1.id
}

resource "aws_route_table_association" "public_2" {
#  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public_subnet_cidrs_2.id
  route_table_id = aws_route_table.public_route_table_2.id
}

resource "aws_route_table_association" "private_1" {
#  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private_subnet_cidrs_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_2" {
#  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private_subnet_cidrs_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}

resource "aws_route" "private_route_to_nat_1" {
  count = 1

  route_table_id         = aws_route_table.private_route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route" "private_route_to_nat_2" {
  count = 1

  route_table_id         = aws_route_table.private_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route" "public_route_to_internet_1" {
  route_table_id         = aws_route_table.public_route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route" "public_route_to_internet_2" {
  route_table_id         = aws_route_table.public_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}