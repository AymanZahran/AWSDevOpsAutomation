#!/bin/bash
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
StacksBucketName="new-stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="new-cloudtrail-bucket-$ACCOUNT_ID"
CodeCommitBackupBucketName="new-codecommitbackup-bucket-$ACCOUNT_ID"
ArtifactsBucketName="new-artifacts-bucket-$ACCOUNT_ID"
CodeCommitRepoName="new-codecommit-repo-$ACCOUNT_ID"
ECRRepoName="new-ecr-repo-$ACCOUNT_ID"
AWS_REGION="us-east-2"

#Uplaod Stack to S3 Stacks Bucket
cd ../Stacks
aws --region $AWS_REGION s3 sync --delete . s3://$StacksBucketName

#Update the Master Stack
aws --region $AWS_REGION cloudformation update-stack \
    --stack-name Master \
    --template-url "https://$StacksBucketName.s3.$AWS_REGION.amazonaws.com/00_Master.yml" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --parameters ParameterKey=KeyPair,ParameterValue=$KeyPair \
    ParameterKey=StacksBucketName,ParameterValue=$StacksBucketName \
    ParameterKey=CloudTrailBucketName,ParameterValue=$CloudTrailBucketName \
    ParameterKey=ArtifactsBucketName,ParameterValue=$ArtifactsBucketName \
    ParameterKey=CodeCommitRepoName,ParameterValue=$CodeCommitRepoName \
    ParameterKey=ECRRepoName,ParameterValue=$ECRRepoName