output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id_1" {
  value = aws_subnet.public_subnet_cidrs_1.id
}

output "public_subnet_id_2" {
  value = aws_subnet.public_subnet_cidrs_2.id
}

output "private_subnet_id_1" {
  value = aws_subnet.private_subnet_cidrs_1.id
}

output "private_subnet_id_2" {
  value = aws_subnet.private_subnet_cidrs_2.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat[*].id
}

output "nat_gateway_eip_ids" {
  value = aws_eip.nat[*].id
}