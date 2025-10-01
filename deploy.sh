#!/bin/bash

: ${ACCOUNT_ID:?"set ACCOUNT_ID environment variable"}
: ${REGION:?"set REGION environment variable"}
: ${REPO_NAME:?"set REPO_NAME environment variable"}
: ${IMAGE_TAG:?"set IMAGE_TAG environment variable"}

echo "Build docker img"
docker build -t ${REPO_NAME}:${IMAGE_TAG} .

echo "ECR authentication"
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

echo "Tag and push image"
docker tag ${REPO_NAME}:${IMAGE_TAG} ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}
docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}

echo "Configure kubectl"
aws eks update-kubeconfig --region ${REGION} --name kosaeszter-eks-cluster

echo "Apply Kubernetes manifests"
kubectl apply -f k8s/

echo "deployment is OK! Check => 'kubectl get pods'."