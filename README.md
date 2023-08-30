# terraform-training
Terrafrom Training

- You must define a Backend for your Terraform project.
- That means you will have to create an S3 bucket and a DynamoDB table first
- Use any CIDR for your network components.
- The EC2 must have the following properties:
- Instance size: t2.micro.
- One EBS volume of 8GB size.
- The latest Amazon Linux AMI available.
- It has to be deployed in one of the public subnets.
- Create an attach an EIP to it.
- The RDS must have the following properties:
- Instance size: db.t3.small
- One EBS volume of 20GB size.
- The subnet group must be using all the private subnets.
- The RDS instance doesnt have to be internet available.
- Go with either PostgreSQL or MySQL engine for your RDS.
- Use tags to name your resources
- Create a Github repository and push your code in there. Then DM me the url of your
