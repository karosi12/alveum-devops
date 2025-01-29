provider "aws" {
  region = var.region # Change this to your desired region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-demo-10"
    key     = "infra-0/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  cidr_block           = "10.0.0.0/16"
  private_subnet1_cidr = "10.0.1.0/24"
  private_subnet2_cidr = "10.0.2.0/24"
  availability_zone1   = "us-west-2a"
  availability_zone2   = "us-west-2b"
}

module "ec2_security_group" {
  source  = "./modules/ec2_security_group"
  vpc_id  = module.vpc.vpc_id
  sg_name = var.sg_name
}

module "rds" {
  source                = "./modules/rds"
  vpc_id                = module.vpc.vpc_id
  vpc_cidr              = "10.0.0.0/16"
  private_subnets       = module.vpc.private_subnets
  cluster_identifier    = var.cluster_identifier
  master_username       = var.master_username
  master_password       = var.master_password
  database_name         = var.database_name
  proxy_name            = var.proxy_name
  rds_proxy_secret_name = var.rds_proxy_secret_name
}

module "elasticache" {
  source          = "./modules/elasticache"
  vpc_id          = module.vpc.vpc_id
  vpc_cidr        = "10.0.0.0/16"
  private_subnets = module.vpc.private_subnets
  cluster_id      = var.cluster_id
}

