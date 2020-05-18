#!/bin/bash

PROJECT_NAME=$1
if [ -n "$2" ] 
then
  PROFILE="--profile $2"
else
  PROFILE=''
fi

echo "PROJECT_NAME=$PROJECT_NAME"
echo "PROFILE=$PROFILE"
echo ""

read -sp "Enter your DB_PASSWORD: " DB_PASSWORD
echo "****${DB_PASSWORD: -4}"

read -sp "Enter your JWT_SECRET: " JWT_SECRET
echo "****${JWT_SECRET: -4}"

echo ""
echo "Creating SSM paramters..."

aws ssm put-parameter $PROFILE --name /$PROJECT_NAME/DB_PASSWORD --type SecureString --value $DB_PASSWORD --overwrite
aws ssm put-parameter $PROFILE --name /$PROJECT_NAME/JWT_SECRET --type SecureString --value $JWT_SECRET --overwrite

echo ""
echo "Succeessfully set your secrets."
