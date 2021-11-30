#!/bin/bash
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
KeyPair="AWS_KeyPair"
SNSEndpointMail="ah.zahran@outlook.com"
StacksBucketName="new-stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="new-cloudtrail-bucket-$ACCOUNT_ID"
ArtifactsBucketName="new-artifacts-bucket-$ACCOUNT_ID"
CodeCommitRepoName="new-codecommit-repo-$ACCOUNT_ID"
ECRRepoName="new-ecr-repo-$ACCOUNT_ID"
AWS_REGION="us-east-2"

#If Stacks Bucket not exists create one
IS_BUCKET_EXISTS=`aws s3 ls | awk '{print $3}' | grep -c $StacksBucketName`
if [ $IS_BUCKET_EXISTS -lt 1 ]; then `aws s3 mb s3://$StacksBucketName --region $AWS_REGION`; fi

rm -f code.zip

#Uplaod Stacks to S3 Stacks Bucket
cd ../Stacks
aws --region $AWS_REGION s3 sync --delete . s3://$StacksBucketName

#upload the Application zipped to S3 Stacks Bucket
cd ../Application
zip -r code.zip *
aws --region $AWS_REGION s3 cp code.zip s3://$StacksBucketName
rm -rf code.zip

#Create the Master Stack
aws --region $AWS_REGION cloudformation create-stack --disable-rollback \
    --stack-name Master \
    --template-url "https://$StacksBucketName.s3.$AWS_REGION.amazonaws.com/00_Master.yml" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --parameters ParameterKey=KeyPair,ParameterValue=$KeyPair \
    ParameterKey=SNSEndpointMail,ParameterValue=$SNSEndpointMail \
    ParameterKey=StacksBucketName,ParameterValue=$StacksBucketName \
    ParameterKey=CloudTrailBucketName,ParameterValue=$CloudTrailBucketName \
    ParameterKey=ArtifactsBucketName,ParameterValue=$ArtifactsBucketName \
    ParameterKey=CodeCommitRepoName,ParameterValue=$CodeCommitRepoName \
    ParameterKey=ECRRepoName,ParameterValue=$ECRRepoName
    