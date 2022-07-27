Here are the steps involved to create Serverless Kafka Environment using AWS Managed Service for Kafka (MSK).
* Go to the AWS Console and create Serverless Kafka using quick start. In my case, I am going to create the Serverless Kafka by name **retail-cluster**.
* Make sure to create IAM Policy and Role so that we can configure Kafka Client later on AWS EC2 Instance with IAM authentication. You need to use right region and account id. I have created Policy by name **AIMSKRetailClusterPolicy** and Role by name **AIMSKRetailClusterRole** using the policy. The policy can be inline policy as well for the role.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:Connect",
                "kafka-cluster:AlterCluster",
                "kafka-cluster:DescribeCluster"
            ],
            "Resource": [
                "arn:aws:kafka:us-east-1:269066542444:cluster/retail-cluster/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:*Topic*",
                "kafka-cluster:WriteData",
                "kafka-cluster:ReadData"
            ],
            "Resource": [
                "arn:aws:kafka:us-east-1:269066542444:topic/retail-cluster/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:AlterGroup",
                "kafka-cluster:DescribeGroup"
            ],
            "Resource": [
                "arn:aws:kafka:us-east-1:269066542444:group/retail-cluster/*"
            ]
        }
    ]
}
```