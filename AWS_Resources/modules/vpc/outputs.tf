output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.my_vpc.id
}

output "subnet_1_id" {
  description = "The ID of subnet 1"
  value       = aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  description = "The ID of subnet 2"
  value       = aws_subnet.subnet_2.id
}

output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.nsg.id
}
