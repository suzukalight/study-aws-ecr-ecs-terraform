#!/bin/bash

AWS_ACCOUNT_ID=$1
PROJECT_NAME=$2
if [ -n "$3" ] 
then
  PROFILE="--profile $3"
else
  PROFILE=''
fi

echo "AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "PROFILE=$PROFILE"

echo ""
echo "Building and pushing new docker images..."

aws ecr get-login-password --region ap-northeast-1 $PROFILE | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com

ECR_URI_NGINX=$(aws ecr describe-repositories --repository-names ${PROJECT_NAME}-nginx --query 'repositories[0].repositoryUri' --output text)
docker build -t $ECR_URI_NGINX -f docker/nginx/Dockerfile .
docker push $ECR_URI_NGINX

ECR_URI_BACKEND=$(aws ecr describe-repositories --repository-names ${PROJECT_NAME}-backend --query 'repositories[0].repositoryUri' --output text)
docker build -t $ECR_URI_BACKEND -f docker/backend/Dockerfile .
docker push $ECR_URI_BACKEND

echo ""
echo "Succeessfully pushed docker images."
