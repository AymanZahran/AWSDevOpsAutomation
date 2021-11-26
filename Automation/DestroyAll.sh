#!/bin/bash
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
StacksBucketName="stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="cloudtrail-bucket-$ACCOUNT_ID"
CodeCommitBackupBucketName="codecommitbackup-bucket-$ACCOUNT_ID-"
ArtifactsBucketName="artifacts-bucket-$ACCOUNT_ID"
CodeCommitRepoName="codecommit-repo-$ACCOUNT_ID"
ECRRepoName="ecr-repo-$ACCOUNT_ID"

python3 DestroyBuckets.py
aws ecr delete-repository --repository-name $ECRRepoName --force
aws cloudformation delete-stack --stack-name Master
