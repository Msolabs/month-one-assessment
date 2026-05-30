No — **don’t paste the assessment question into the README**. Your `README.md` should explain **what you built and how to run it**, not repeat the assignment.

Use a proper project README showing:

* Project overview
* Architecture
* Features
* Prerequisites
* Deployment steps
* SSH access
* Verification
* Cleanup (`terraform destroy`)
* Evidence folder

Use this instead in your `README.md`:

# TechCorp AWS Infrastructure Deployment using Terraform

## Project Overview

This project provisions a secure and highly available AWS infrastructure for **TechCorp** using **Terraform**.

The infrastructure includes:

* A custom VPC
* Public and private subnets across multiple Availability Zones
* Internet Gateway and NAT Gateways
* Bastion host for secure administrative access
* Two private web servers
* One private database server
* Application Load Balancer (ALB)
* Security groups for controlled access
* Automated server setup using user data scripts

The deployment follows infrastructure-as-code (IaC) best practices using Terraform.

---

## Architecture

### Infrastructure Components

#### Networking

* **VPC CIDR:** `10.0.0.0/16`
* **Public Subnet 1:** `10.0.1.0/24`
* **Public Subnet 2:** `10.0.2.0/24`
* **Private Subnet 1:** `10.0.3.0/24`
* **Private Subnet 2:** `10.0.4.0/24`

#### Compute Resources

* **1 Bastion Host** (`t3.micro`) in public subnet
* **2 Web Servers** (`t3.micro`) in private subnets
* **1 Database Server** (`t3.small`) in private subnet

#### Load Balancing

* Application Load Balancer deployed in public subnets
* Target group configured for web servers
* Health checks enabled

#### Security

* Bastion host accessible only from my public IP
* Web servers accessible only through the Load Balancer
* Database server accessible only from web servers
* SSH access restricted through Bastion host

---

## Project Structure

```text
terraform-assessment/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── user_data/
│   ├── web_server_setup.sh
│   └── db_server_setup.sh
├── evidence/
└── README.md
```

---

## Prerequisites

Before deployment, ensure the following are installed:

* Terraform >= 1.0
* AWS CLI
* Git
* AWS account configured with credentials

Verify installation:

```bash
terraform version
aws --version
git --version
```

---

## Deployment Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd terraform-assessment
```

### 2. Configure Variables

Create a `terraform.tfvars` file:

```hcl
aws_region   = "eu-west-1"
project_name = "techcorp"

bastion_instance_type = "t3.micro"
web_instance_type     = "t3.micro"
db_instance_type      = "t3.small"

key_pair_name = "techcorp-key"

my_ip = "YOUR_PUBLIC_IP/32"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Validate Configuration

```bash
terraform validate
```

### 5. Preview Infrastructure

```bash
terraform plan
```

### 6. Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

---

## Accessing Infrastructure

### SSH to Bastion Host

```bash
ssh -i ~/.ssh/techcorp-key.pem ec2-user@<BASTION_PUBLIC_IP>
```

### SSH to Web Server

From the Bastion Host:

```bash
ssh ec2-user@<PRIVATE_IP>
```

### SSH to Database Server

From the Bastion Host:

```bash
ssh ec2-user@<DB_PRIVATE_IP>
```

---

## Load Balancer Verification

Open the ALB DNS name in a browser:

```text
http://<load-balancer-dns>
```

Refreshing the page should alternate between:

* Web Server 1
* Web Server 2

confirming load balancing is working correctly.

---

## Terraform Outputs

The deployment provides outputs for:

* VPC ID
* Bastion Public IP
* Load Balancer DNS Name

Check outputs using:

```bash
terraform output
```

---

## Deployment Evidence

Screenshots are included in the `evidence/` folder showing:

* Terraform plan
* Terraform apply
* AWS resources
* ALB functionality
* SSH access via Bastion
* Access to Web and DB servers

---

## Cleanup

To avoid AWS charges, destroy all infrastructure after testing:

```bash
terraform destroy
```

Type:

```text
yes
```

