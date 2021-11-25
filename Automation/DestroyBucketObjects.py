import boto3
bucket_name="cloudtrail-bucket-439923486761"
s3 = boto3.resource('s3')
bucket = s3.Bucket(bucket_name)
bucket.object_versions.delete()