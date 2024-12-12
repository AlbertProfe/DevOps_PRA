# AWS CLI

## Install

To install the AWS CLI on Linux Mint, follow these steps:

1. **Install via APT:**
   
   - Update your package list:bash
     
     `sudo apt-get update`
   
   - Install AWS CLI:bash
     
     `sudo apt-get install awscli`
   
   - Verify installation:
     
     `aws --version`

## AWS Credentials

To log in to your AWS account using the AWS CLI on Linux Mint, follow these steps:

1. **Retrieve AWS Credentials:**
   
   - Log in to your AWS Management Console.
   - Navigate to the IAM service to create or retrieve your AWS Access Key ID and Secret Access Key.

2. **Configure AWS CLI:**
   
   - Open a terminal and run the following command:
     
     ```bash
     aws configure
     ```
   
   - Enter your **AWS Access Key ID**, **AWS Secret Access Key**, **Default region name** (e.g., `us-west-2`), and **Default output format** (e.g., `json`) when prompted.

3. **Verify Configuration:**
   
   - Check if the configuration is successful by listing S3 buckets or describing VPCs:
     
     ```bash
     aws s3 ls
     aws ec2 describe-vpcs
     ```
   
   - If these commands return data, your AWS CLI is configured correctly.
