#!/bin/bash
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
StacksBucketName="new-stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="new-cloudtrail-bucket-$ACCOUNT_ID"
CodeCommitBackupBucketName="new-codecommitbackup-bucket-$ACCOUNT_ID-"
ArtifactsBucketName="new-artifacts-bucket-$ACCOUNT_ID"
CodeCommitRepoName="new-codecommit-repo-$ACCOUNT_ID"
ECRRepoName="new-ecr-repo-$ACCOUNT_ID"

python3 DestroyBuckets.py
aws ecr delete-repository --repository-name $ECRRepoName --force
aws cloudformation delete-stack --stack-name Master
