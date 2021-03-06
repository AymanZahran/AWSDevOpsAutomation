#!/bin/bash
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
KeyPair="AWS_KeyPair"
SNSEndpointMail="ah.zahran@outlook.com"
StacksBucketName="stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="cloudtrail-bucket-$ACCOUNT_ID"
ArtifactsBucketName="artifacts-bucket-$ACCOUNT_ID"
VarLogMessagesBucketName="varlogmessages-bucket-$ACCOUNT_ID"
CodeCommitRepoName="codecommit-repo-$ACCOUNT_ID"
ECRRepoName="ecr-repo-$ACCOUNT_ID"
AWS_REGION="us-east-1"

#Uplaod Stack to S3 Stacks Bucket
cd ../Stacks
aws --region $AWS_REGION s3 sync --delete . s3://$StacksBucketName

#Update the Master Stack
aws --region $AWS_REGION cloudformation update-stack \
    --stack-name Master \
    --template-url "https://$StacksBucketName.s3.$AWS_REGION.amazonaws.com/00_Master.yml" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --parameters ParameterKey=KeyPair,ParameterValue=$KeyPair \
    ParameterKey=SNSEndpointMail,ParameterValue=$SNSEndpointMail \
    ParameterKey=StacksBucketName,ParameterValue=$StacksBucketName \
    ParameterKey=CloudTrailBucketName,ParameterValue=$CloudTrailBucketName \
    ParameterKey=ArtifactsBucketName,ParameterValue=$ArtifactsBucketName \
    ParameterKey=VarLogMessagesBucketName,ParameterValue=$VarLogMessagesBucketName \
    ParameterKey=CodeCommitRepoName,ParameterValue=$CodeCommitRepoName \
    ParameterKey=ECRRepoName,ParameterValue=$ECRRepoName