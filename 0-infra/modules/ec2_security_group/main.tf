resource "aws_security_group" "ec2" {
  vpc_id = var.vpc_id
  name   = var.sg_name
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "sg" {
  value = aws_security_group.ec2.id
}