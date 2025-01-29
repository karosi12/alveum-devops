resource "aws_security_group" "rabbitmq" {
  name        = var.sg_name
  description = "Allow access to RabbitMQ from peer VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5671
    to_port         = 5671
    protocol        = "tcp"
    security_groups = [var.peer_security_group_id]  # Replace with the peer VPC security group ID
  }

  ingress {
    from_port       = 5672
    to_port         = 5672
    protocol        = "tcp"
    security_groups = [var.peer_security_group_id]
  }

  ingress {
    from_port       = 15672
    to_port         = 15672
    protocol        = "tcp"
    security_groups = [var.peer_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}

output "security_group_id" {
  value = aws_security_group.rabbitmq.id
}
