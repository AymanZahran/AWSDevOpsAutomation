import boto3
from botocore.client import ClientError

AccountId = boto3.client('sts').get_caller_identity().get('Account')
s3_Resource = boto3.resource('s3')
s3_Client = boto3.client('s3')

BucketsList = [
    "stacks-bucket-" + str(AccountId), 
    "cloudtrail-bucket-" + str(AccountId), 
    "artifacts-bucket-" + str(AccountId),
    "varlogmessages-bucket-" + str(AccountId)
    ]

for i in BucketsList:
    try: 
        bucket = s3_Resource.Bucket(i)
        bucket.objects.all().delete()
        #s3_Client.delete_bucket(Bucket=i)
    except ClientError:
        print("Bucket", i, "not exists")