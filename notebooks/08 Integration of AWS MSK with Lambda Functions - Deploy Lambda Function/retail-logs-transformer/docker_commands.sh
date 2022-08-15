# Build custom docker image using lambda as base image
docker build -t retail-logs-transformer .

# Start docker container with custom image
docker run \
  --name retail-logs-transformer \
  -p 9000:8080 \
  -d \
  retail-logs-transformer

# Validate docker image for lambda function locally
curl -XPOST \
  "http://localhost:9000/2015-03-31/functions/function/invocations" \
  -d '{"Records": [{"eventVersion": "2.1", "eventSource": "aws:s3", "awsRegion": "us-east-1", "eventTime": "2022-08-11T00:33:14.202Z", "eventName": "ObjectCreated:Put", "userIdentity": {"principalId": "AWS:AROAT5JM5TVWOT5MFQ7BR:i-0df8a4df2ad8e9431"}, "requestParameters": {"sourceIPAddress": "172.31.70.113"}, "responseElements": {"x-amz-request-id": "7A2N3SVCY4R06CRN", "x-amz-id-2": "H9R6puA73y162SIC5/V9KQeotIO/uiFb3BDguGeubPXTz0TeI+Hr5m2G9i3kpGQNqoNNPuuGChrXjfLnkSSCmHlw1sLdnzi2"}, "s3": {"s3SchemaVersion": "1.0", "configurationId": "391bf491-efb4-4bda-9b59-ecd7994f06c2", "bucket": {"name": "airetail", "ownerIdentity": {"principalId": "A1X8UFY0XE0RRV"}, "arn": "arn:aws:s3:::airetail"}, "object": {"key": "topics/retail_logs/partition%3D0/retail_logs%2B0%2B0000011520.bin", "size": 29096, "eTag": "d7bc9a1bbbc7b5e3b2f6147714977163", "sequencer": "0062F44E4A217EEC37"}}}]}'

# Login to docker
aws ecr get-login-password \
  --region us-east-1 | \
  docker login \
  --username AWS \
  --password-stdin \
  269066542444.dkr.ecr.us-east-1.amazonaws.com

# Tag docker image to make it ready to push to AWS ECR
docker tag retail-logs-transformer:latest \
  269066542444.dkr.ecr.us-east-1.amazonaws.com/retail-logs-transformer:latest

# Push custom docker image to AWS ECR
docker push 269066542444.dkr.ecr.us-east-1.amazonaws.com/retail-logs-transformer:latest