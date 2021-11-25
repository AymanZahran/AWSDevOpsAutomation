import boto3
AccountId = boto3.client('sts').get_caller_identity().get('Account')
s3 = boto3.resource('s3')

StacksBucketName="stacks-bucket-$ACCOUNT_ID"
CloudTrailBucketName="cloudtrail-bucket-$ACCOUNT_ID"
CodeCommitBackupBucketName="codecommitbackup-bucket-$ACCOUNT_ID-"

bucket_name="stacks-bucket-" + str(439923486761)
bucket = s3.Bucket(bucket_name)
bucket.objects.all().delete()
bucket_name="cloudtrail-bucket-" + str(439923486761)
bucket = s3.Bucket(bucket_name)
bucket.object_versions.delete()
bucket_name="codecommitbackup-bucket-" + str(439923486761)
bucket = s3.Bucket(bucket_name)
bucket.objects.all().delete()