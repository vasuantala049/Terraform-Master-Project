Multi-Environment AWS Infrastructure with Terraform

This project demonstrates a modular AWS infrastructure built using Terraform. It supports three isolated environments: dev, staging, and prod. Each environment can be deployed independently and maintains its own remote state.

The infrastructure includes:

Custom VPC with public and private subnets across multiple Availability Zones

Internet Gateway and NAT Gateway

Private EC2 instances

Amazon RDS (MySQL) deployed in private subnets

AWS Secrets Manager for database credentials

AWS KMS for encryption

Amazon S3 with versioning and encryption

AWS CloudTrail for auditing

IAM roles and security groups

Each environment:

Has its own Terraform state file stored in S3

Uses environment-specific variables

Is fully isolated from other environments

Can be deployed or destroyed independently

Project structure:

terraform-multi-env-infra
modules/
 vpc/
 security/
 compute/
 database/
 storage/
environments/
 dev/
 staging/
 prod/

To deploy an environment:

1. Navigate to the environment folder
   cd environments/dev

2. Initialize Terraform
   terraform init

3. Review the plan
   terraform plan

4. Apply the configuration
   terraform apply

To destroy the environment:

terraform destroy

This project focuses on clean module design, secure secret handling, remote state management, and multi-environment architecture using Infrastructure as Code principles.