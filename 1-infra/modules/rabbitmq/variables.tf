variable "broker_name" {
  description = "The name of the RabbitMQ broker"
  type        = string
}

variable "engine_version" {
  description = "The version of the RabbitMQ engine"
  type        = string
}

variable "host_instance_type" {
  description = "The instance type for the RabbitMQ host"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "username" {
  description = "The username for the RabbitMQ broker"
  type        = string
}

variable "password" {
  description = "The password for the RabbitMQ broker"
  type        = string
}
