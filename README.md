# Multi-Cloud Infrastructure Deployment using Terraform (AWS ALB + GCP Load Balancer)

This project demonstrates **Multi-Cloud Infrastructure as Code (IaC)** deployment using **Terraform**. It provisions infrastructure across **AWS and GCP**, fully automated using **GitHub Actions**.

---

##  Project Overview

### AWS Setup
-  **VPC** with **two public subnets** in different Availability Zones.
-  **EC2 Instance** running a basic Apache web server.
-  **Application Load Balancer (ALB)** distributing traffic across the EC2 instances.
-  **Security Group** allowing HTTP (Port 80) traffic.
-  Managed using **Terraform**, triggered via **GitHub Actions**.

### GCP Setup
-  **Managed Instance Group (MIG)** running web servers across zones.
-  **Global HTTP Load Balancer** to distribute traffic across the MIG.
-  Managed using **Terraform**, triggered via **GitHub Actions**.

---

## Tools & Technologies Used

| Technology  | Purpose |
|-------------|---------|
| Terraform   | Infrastructure as Code |
| GitHub Actions | CI/CD for automation |
| AWS EC2     | Compute for frontend web server |
| AWS ALB     | Application Load Balancer |
| AWS VPC     | Networking (subnets, internet gateway) |
| GCP Compute Engine | Backend web servers |
| GCP Managed Instance Group | Auto-scaling backend |
| GCP Global Load Balancer | Traffic distribution across backend |

---

##  How It Works

### 1. Code Commit
Push to the **main** branch triggers the GitHub Actions pipeline.

### 2. GitHub Actions Workflow
- Configures AWS & GCP credentials from **GitHub Secrets**.
- Deploys AWS resources (`aws/main.tf`).
- Deploys GCP resources (`gcp/main.tf`).

### 3. Infrastructure
- AWS ALB URL serves traffic to the Apache web server.
- GCP Global Load Balancer serves traffic to the GCP MIG.

---

## GitHub Secrets

| Secret Name               | Description |
|--------------------|-----------------|
| AWS_ACCESS_KEY_ID  | AWS Access Key ID |
| AWS_SECRET_ACCESS_KEY | AWS Secret Key |
| GOOGLE_CREDENTIALS | Full GCP Service Account JSON |

---
