# Multi-Environment AWS Infrastructure with Terraform

## 📌 Overview

This project demonstrates a production-style, modular AWS infrastructure built using **Terraform (Infrastructure as Code)**.

It supports three isolated environments:

- Dev
- Staging
- Prod

Each environment has its own remote state, networking, security, compute, database, and storage layers.

---

## 🏗 Architecture

### Core Components

- Custom VPC (Multi-AZ)
- Public & Private Subnets
- Internet Gateway + NAT Gateway
- EC2 Instances (Private)
- Amazon RDS (MySQL) – Private
- AWS KMS (Encryption)
- AWS Secrets Manager (DB Credentials)
- Amazon S3 (Encrypted & Versioned Storage)
- AWS CloudTrail (Audit Logging)
- IAM Roles & Security Groups
- Remote Terraform State (S3 with native locking)

---

## 📂 Project Structure

terraform-multi-env-infra/
│
├── backend/ # Backend S3 bucket setup
│
├── modules/
│ ├── vpc/
│ ├── security/
│ ├── compute/
│ ├── database/
│ └── storage/
│
└── environments/
├── dev/
├── staging/
└── prod/

yaml
Copy code

---

## 🔐 Security Features

- Private EC2 instances (no public IP)
- RDS deployed in private subnets
- Least-privilege Security Groups
- Secrets stored in AWS Secrets Manager
- Encryption at rest using AWS KMS
- S3 versioning + encryption enabled
- CloudTrail logging enabled

---

## 🌎 Multi-Environment Strategy

Each environment:

- Has its own Terraform state file
- Uses environment-specific variables
- Is completely isolated from other environments
- Can be deployed independently

---

## 🚀 How to Deploy

### 1️⃣ Navigate to environment

```bash
cd environments/dev
2️⃣ Initialize Terraform
bash
Copy code
terraform init
3️⃣ Plan
bash
Copy code
terraform plan
4️⃣ Apply
bash
Copy code
terraform apply
🧹 Destroy Environment
bash
Copy code
terraform destroy
📦 Terraform Backend
Remote state is stored in:

Amazon S3

Native S3 state locking enabled

Separate state file per environment

🛠 Technologies Used
Terraform

AWS VPC

Amazon EC2

Amazon RDS (MySQL)

Amazon S3

AWS KMS

AWS Secrets Manager

AWS CloudTrail

IAM

📈 Learning Objectives
This project demonstrates:

Terraform module design

Dependency graph management

Multi-environment infrastructure patterns

Secure secret handling

Remote state best practices

Production-style AWS architecture