variable "sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "peer_security_group_id" {
  description = "The ID of the peer VPC security group"
  type        = string
}
