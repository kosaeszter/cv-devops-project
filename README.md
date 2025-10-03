# DevOps IaC Project

This is a **work-in-progress DevOps project** where I am experimenting with cloud infrastructure and automation.  
The goal of this project is to build a **scalable, secure, and fully automated environment** using Terraform, including networking, databases, and other cloud resources.  

⚠️ **In Progress!** The project is under active development ⚠️

## Project Highlights
- Infrastructure as Code with Terraform
- AWS resources: VPC, subnets, security groups, RDS, and EKS
- Automated Docker build & push to Amazon ECR
- Kubernetes deployment on EKS with environment variable injection
- Automatic PostgreSQL database seeding
- Focus on modularity, scalability, and best practices

## Tech Stack (current status)
- IaC Tool: Terraform
- Cloud Provider: AWS
- Containerization: Docker
- Orchestration: Kubernetes (EKS)
- Database: PostgreSQL (Amazon RDS)

## Deployment Flow (current state)

The main automation is handled by a **bash script** (`deploy.sh`) which performs the following steps:

1. **Provision infrastructure**  
   - Runs Terraform (`terraform init/plan/apply`) to create all AWS resources (VPC, RDS, EKS, networking, etc.).

2. **Retrieve RDS connection info**  
   - Extracts the RDS endpoint and sets `PG_HOST` and `PG_PORT` for later use.

3. **Build & Push Docker Image**  
   - Builds the application Docker image.  
   - Logs into AWS ECR.  
   - Pushes the image to the designated repository.  

4. **Deploy to Kubernetes**  
   - Updates kubeconfig for the EKS cluster.  
   - Applies Kubernetes manifests (`kubectl apply -f k8s/`).  
   - Injects database connection environment variables into the `express-app` deployment.  

5. **Seed Database**  
   - Waits for the application pod to become ready.  
   - Copies `seed.sql` into the container.  
   - Runs the SQL seed script against the RDS PostgreSQL instance.  

## Required Environment Variables
Before running the deployment script, set the following:

```bash
export PG_USER=your_db_user
export PG_PASSWORD=your_db_password
export PG_DB=your_db_name
export ACCOUNT_ID=your_aws_account_id
export REGION=your_aws_region
export REPO_NAME=your_ecr_repo_name
export IMAGE_TAG=latest
```

## Note
This project is ongoing and continuously evolving.
