#!/bin/bash

cat <<EOF > terraform.tfvars
rabbitmq_password = "$RABBITMQ_PASSWORD"
rabbitmq_username = "$RABBITMQ_USERNAME"
peer_security_group_id = "$PEER_SECURITY_GROUP_ID"
peer_vpc_id = "$PEER_VPC_ID"
EOF
