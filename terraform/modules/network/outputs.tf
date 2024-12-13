output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_nat_gateway.nat[0].id : null
}

output "route_table_public_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "route_table_private_ids" {
  description = "The IDs of the private route tables"
  value       = var.enable_nat_gateway ? aws_route_table.private[*].id : null
}