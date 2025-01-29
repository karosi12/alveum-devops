variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet1_cidr" {
  description = "The CIDR block for subnet 1"
  type        = string
}

variable "subnet2_cidr" {
  description = "The CIDR block for subnet 2"
  type        = string
}

variable "availability_zone1" {
  description = "The availability zone for subnet 1"
  type        = string
}

variable "availability_zone2" {
  description = "The availability zone for subnet 2"
  type        = string
}
