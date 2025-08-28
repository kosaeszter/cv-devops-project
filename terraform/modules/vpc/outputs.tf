output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_id_a" {
  description = "private subnet-a ID"
  value       = aws_subnet.private_subnet_a.id
}

output "private_subnet_id_b" {
  description = "private subnet-b ID"
  value       =  aws_subnet.private_subnet_b.id
}

output "public_subnet_id_a" {
  description = "public subnet-a ID"
  value       = aws_subnet.public_subnet_a.id
}

output "public_subnet_id_b" {
  description = "public subnet-b ID"
  value       = aws_subnet.public_subnet_b.id
}