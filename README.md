# Multi-Cloud Terraform Deployment (AWS + GCP)

This project demonstrates a multi-cloud deployment using Terraform and GitHub Actions. It provisions:

- AWS EC2 instance with Apache web server behind an Elastic Load Balancer.
- GCP Compute Engine instances (MIG) with Apache web server behind a Global Load Balancer.

## Technologies Used

- Google Cloud Platform (GCP)
- Amazon Web Services (AWS)
- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD Pipeline)

## Workflow

- Push changes to `main` branch.
- GitHub Actions triggers Terraform deployment for AWS and GCP.
- Terraform deploys AWS EC2 + ELB and GCP Compute Engine + Global Load Balancer.

## Secrets Required

Add these secrets to your GitHub repository:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `GOOGLE_CREDENTIALS` (GCP service account key JSON)

## Author

Rajat Sood
 
