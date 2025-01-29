output "elasticache_endpoint" {
  value = module.elasticache.elasticache_endpoint
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_reader_endpoint" {
  value = module.rds.rds_reader_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "security_group_id" {
  value = module.ec2_security_group.sg
}

output "rds_db_name" {
  description = "The name of the RDS database"
  value       = module.rds.db_name
}