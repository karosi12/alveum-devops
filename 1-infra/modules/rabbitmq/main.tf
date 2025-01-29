resource "aws_mq_broker" "rabbitmq_broker" {
  broker_name         = var.broker_name
  engine_type         = "RabbitMQ"
  engine_version      = var.engine_version
  deployment_mode     = "CLUSTER_MULTI_AZ"
  host_instance_type  = var.host_instance_type
  publicly_accessible = false
  subnet_ids          = var.subnet_ids
  security_groups     = var.security_groups
  auto_minor_version_upgrade = true
  logs {
    general = true
    # audit   = true
  }

  user {
    username = var.username
    password = var.password
  }

  tags = {
    Name = var.broker_name
  }
}

output "rabbitmq_broker_endpoint" {
  description = "The endpoint URL of the RabbitMQ broker"
  value       = aws_mq_broker.rabbitmq_broker.instances[0].endpoints[0]
}
