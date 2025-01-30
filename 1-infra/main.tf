provider "aws" {
  region = var.region # Change to your desired region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-demo-10"
    key     = "infra-1/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "rabbitmq-vpc"
  cidr_block         = "172.0.0.0/16"
  subnet1_cidr       = "172.0.1.0/24"
  subnet2_cidr       = "172.0.2.0/24"
  availability_zone1 = "us-west-2a"
  availability_zone2 = "us-west-2b"
}

module "security_group" {
  source                 = "./modules/security_group"
  sg_name                = "rabbitmq-sg"
  vpc_id                 = module.vpc.vpc_id
  peer_security_group_id = var.peer_security_group_id # Replace with the peer VPC security group ID
}

module "iam" {
  source          = "./modules/iam"
  iam_role_name   = "rabbitmq-logging-role"
  iam_policy_name = "rabbitmq-logging-policy"
}

module "vpc_peering" {
  source       = "./modules/vpc_peering"
  vpc_id       = module.vpc.vpc_id
  peer_vpc_id  = var.peer_vpc_id # Replace with the ID of the peer VPC
  peering_name = "rabbitmq-vpc-peering"
}

module "rabbitmq" {
  source             = "./modules/rabbitmq"
  broker_name        = "rabbitmq-broker"
  engine_version     = "3.13" # Change to the desired version
  host_instance_type = "mq.m5.large"
  subnet_ids         = module.vpc.subnet_ids
  security_groups    = [module.security_group.security_group_id]
  username           = var.rabbitmq_username
  password           = var.rabbitmq_password # Replace with a secure password
}

output "rabbitmq_broker_endpoint" {
  description = "The endpoint URL of the RabbitMQ broker"
  value       = module.rabbitmq.rabbitmq_broker_endpoint
}
