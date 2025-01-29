output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnets" {
  value = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}