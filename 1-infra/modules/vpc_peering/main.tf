resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true

  tags = {
    Name = var.peering_name
  }
}

output "vpc_peering_connection_id" {
  value = aws_vpc_peering_connection.peer.id
}
