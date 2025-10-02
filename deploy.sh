#!/bin/bash
set -e 

# REQUIRED ENV VARIABLES
: ${PG_USER:?"set PG_USER environment variable"}
: ${PG_PASSWORD:?"set PG_PASSWORD environment variable"}
: ${PG_DB:?"set PG_DB environment variable"}
: ${ACCOUNT_ID:?"set ACCOUNT_ID environment variable"}
: ${REGION:?"set REGION environment variable"}
: ${REPO_NAME:?"set REPO_NAME environment variable"}
: ${IMAGE_TAG:?"set IMAGE_TAG environment variable"}

echo "create tf resources"
cd terraform
terraform init
terraform plan 
terraform apply 
cd ..

# get rds host from tf output
RDS_ENDPOINT=$(terraform -chdir=terraform output -raw rds_endpoint)
PG_HOST=$(echo $RDS_ENDPOINT| cut -d':' -f1)
PG_PORT=$(echo $RDS_ENDPOINT| cut -d':' -f2)
echo "db host: $PG_HOST port: $PG_PORT"

# build docker img and push to ecr
echo "build docker img and push to ecr"
docker build -t ${REPO_NAME}:${IMAGE_TAG} .

# authenticate to ECR and push the img
echo "authenticate to ECR"
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
echo "tag and push to ECR"
docker tag ${REPO_NAME}:${IMAGE_TAG} ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}
docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}

# k8 deploy
echo "configuring kubectl"
aws eks update-kubeconfig --region ${REGION} --name kosaeszter-eks-cluster
echo "Apply K8 manifests"
kubectl apply -f k8s/

# Set DB env vars in Deployment
echo "Setting DB environment variables in deployment..."
kubectl set env deployment/express-app PG_HOST=$PG_HOST PG_PORT=$PG_PORT PG_USER=$PG_USER PG_PASSWORD=$PG_PASSWORD PG_DB=$PG_DB


# DB seed
POD_NAME=$(kubectl get pods -l app=express-app -o jsonpath="{.items[0].metadata.name}")
kubectl wait --for=condition=ready pod/$POD_NAME --timeout=120s
kubectl cp seed.sql $POD_NAME:/seed.sql
kubectl exec -i $POD_NAME -- sh -c "export PGPASSWORD=${PG_PASSWORD} && psql -h ${PG_HOST} -U ${PG_USER} -d ${PG_DB} -p ${PG_PORT} -f /seed.sql"


echo "run=> port-forward <pod> 9090:3000"

