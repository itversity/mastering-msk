Here are the highlevel steps to setup Kafka Client on newly created AWS EC2 Instance for Serverless Kafka.
* Make sure to setup Kafka Client following the instructions provided by official documentation.
* Here are the commands for the reference.
```shell
sudo yum -y install java-11
wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.12-2.8.1.tgz
sudo mkdir /opt
sudo tar xzf kafka_2.12-2.8.1.tgz -O /opt
wget https://github.com/aws/aws-msk-iam-auth/releases/download/v1.1.1/aws-msk-iam-auth-1.1.1-all.jar

```