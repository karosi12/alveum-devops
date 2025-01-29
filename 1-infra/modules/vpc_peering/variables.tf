variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "peer_vpc_id" {
  description = "The ID of the peer VPC"
  type        = string
}

variable "peering_name" {
  description = "The name of the VPC peering connection"
  type        = string
}
