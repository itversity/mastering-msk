Here are the steps to setup Kafka Client for AWS MSK using AWS EC2 Instance.
* Go to EC2 Console and initiate the process to setup EC2 Instance.
* Make sure to enter appropriate name for the Kafka client. In my case, I will use **retail-kafka-client**.
* Choose appropriate EC2 Instance Type. In my case, I have used **t2.medium**.
* Make sure to choose the VPC and Subnet used for Serverless Kafka which is setup earlier.
* Make sure to choose the Security Group used for Severless Kafka.
* Make sure to choose 16 GB for Root Volume.
* Choose appropriate Key Pair and also ensure that port 22 is opened to connect to this client machine via SSH.
* Also, we need to make sure the IAM Role created for Serverless Kafka Client is associated with this EC2 Instance.

Once the client is setup make sure to validate connectivity between client and Serverless Kafka using telnet.
* The EC2 instance might not have telnet installed. In case if telnet is missing, make sure to install telnet using `sudo yum -y install telnet`.

Once telnet is installed we can use telnet with the Serverless Kafka endpoint to confirm if the connectivity is working between client EC2 Instance and Serverless Kafka.