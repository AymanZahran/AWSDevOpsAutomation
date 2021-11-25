#!/bin/bash
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
StacksBucketName="stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="cloudtrail-bucket-$ACCOUNT_ID"
CodeCommitBackupBucketName="codecommitbackup-bucket-$ACCOUNT_ID-"
ArtifactsBucketName="artifacts-bucket-$ACCOUNT_ID"
CodeCommitRepoName="codecommit-repo-$ACCOUNT_ID"
ECRRepoName="ecr-repo-$ACCOUNT_ID"

aws ecr delete-repository --repository-name $ECRRepoName --force
# python3 DestroyBucketObjects.py
# python3 DestroyBucketObjects.py
# python3 DestroyBucketObjects.py
aws s3 rb s3://$StacksBucketName --force
aws s3 rb s3://$CloudTrailBucketName --force
aws s3 rb s3://$ArtifactsBucketName --force
aws cloudformation delete-stack --stack-name Master
