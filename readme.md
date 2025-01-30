## Alveum DevOps 


## Instruction
Design a system that includes at least two services deployed within the same VPC and one service outside the VPC

## Technologies Used
- Terraform (Iac) to provision the infrastructure
- Programming (Nodejs): Create lambda functions that intreact with RDS, Cache, and Rabbitmq for message broker

## Important 
- We have two infrastructure folder (0-infra and 1-infra)
- 0-infra is used to provisioned VPC1(my-vpc) for RDS, and ElasticCache(Redis)
- 1-infra is used to provisioned VP2(rabbitmq-vpc) for RabbitMQ
Note: There is VPC peering connection for secure connection between the VPCs.

## Requirements
-   Inside 0-infra, create a variable file terraform.tfvars with below sample data
```
cluster_identifier    = "alveum-cluster"
master_username       = "admin"
master_password       = "password"
database_name         = "alveumdb"
proxy_name            = "alveum-proxy"
cluster_id            = "alveum"
sg_name               = "ec2-security-group"
vpc_name              = "my-vpc"
rds_proxy_secret_name = "rds_proxy_secret"
access_key            = "<AWS_ACCESS_KEY>"
secret_key            = "<AWS_SECRET_ACCESS_KEY>"
region                = "<AWS_REGION>"
```
- 2. Inside 1-infra, create a variable file `terraform.tfvars` with below sample data

```
rabbitmq_password      = "securepassword123"
rabbitmq_username      = "admin"
peer_security_group_id = "<SECURITY_GROUP_ID_USED_0-INFRA>"
peer_vpc_id            = "<VPC_ID_USED_0-INFRA>"
access_key            = "<AWS_ACCESS_KEY>"
secret_key            = "<AWS_SECRET_ACCESS_KEY>"
region                = "<AWS_REGION>"
```
## Terraform command
- To Provision the instance using terraform command afer changing directory to each folders (0-infra and 1-infra)
```
terraform init
terraform plan
terraform apply # An instruction will be given to enter y for yes
terraform apply -auto-approve # This command is use to provision without typing the yes/y key word
```
## To run or deploy Lambda function
```
npm install -g serverless # To install serverless framework on your system
npm install # To install nodejs dependencies/packages
serverless deploy -v # To deploy with logs
serverless deploy

curl -X POST https://<serverless-url>/dev/save \
  -H "Content-Type: application/json" \
  -d '{"fullName":"john doe", "username":"john"}'

```
## Contact info
- You can reach me via email for more clarification <adekayor@gmail.com>