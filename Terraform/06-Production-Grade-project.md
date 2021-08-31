
# Steps
1. AWS
      1. Create IAM user/policy
      2. Configure MFA
      3. Setup AWS Vault
      4. Create S3 Bucket
2. Terraform
      1. S3 bucket # to hold tfstate file
      2. Dynamo DB # to create lock for tfstate file
      3. Create ECR # to hold application docker images 
      4. Prepare gitignore
      5. Provider and backend initialization
      6. Setting up docker-compose
      7. Create Bastion EC2 instance
      8. Create Terraform Workspace
      9. Create resource prefix
      10. Common tagging
 
3. AWS
      1. Create a CI policy/user
4. CI (jenkins)
      1. Configure credentials for CI-Deployment



# AWS
- Create IAM user/policy
  <img width="881" alt="image" src="https://user-images.githubusercontent.com/75510135/131427071-3fe56fb4-7caa-4c41-9d07-1810d82b5596.png">
- Force MFA policy to attach with User/group
 * ref# https://github.com/rupeshpanwar/DevOps-Terraform-ECS.md
-  Setup AWS Vault
```
        $ aws-vault add userName
        $ vi ~/.aws/config
        [profile userName]
        region=ap-south-1
       $ aws-vault exec userName --duration=12h   # setting up the session cookie to work 
```

# Terraform
      1. S3 bucket # to hold tfstate file
      2. Dynamo DB # to create lock for tfstate file
      3. Create ECR # to hold application docker images 
      4. Prepare gitignore
      5. Provider and backend initialization
      6. Setting up docker-compose
      7. Create Bastion EC2 instance
      8. Create Terraform Workspace
      9. Create resource prefix
      10. Common tagging
 
- S3 bucket # to hold tfstate file
<img width="784" alt="image" src="https://user-images.githubusercontent.com/75510135/131430207-4e3ebfd8-96a7-4aae-b398-979f30febebc.png">
<img width="875" alt="image" src="https://user-images.githubusercontent.com/75510135/131430361-f1cbbfe5-034f-4756-b048-8f0984f884ad.png">
**note for S3 bucket
<img width="931" alt="image" src="https://user-images.githubusercontent.com/75510135/131430456-b492d3f2-6811-4983-9a68-a250b484ed79.png">
- Dynamo DB # to create lock for tfstate file 
<img width="1095" alt="image" src="https://user-images.githubusercontent.com/75510135/131440850-70c68086-bca5-4376-a55a-fdff13af9cdc.png">
<img width="841" alt="image" src="https://user-images.githubusercontent.com/75510135/131441002-fa063553-642a-4f8f-a443-dc030b7ffb41.png">
- Create ECR # to hold application docker images 
<img width="804" alt="image" src="https://user-images.githubusercontent.com/75510135/131441308-a7a95d86-1420-4b29-91d1-cf8dab20b333.png">
<img width="793" alt="image" src="https://user-images.githubusercontent.com/75510135/131441599-43a2bdeb-9e67-45f1-8d0f-fc65040e1dfd.png">
- Prepare gitignore
* https://github.com/rupeshpanwar/DevOps-Terraform-ECS.md/blob/main/.gitignore

- Provider and backend initialization
```
terraform {
  backend "s3" {
    bucket         = "devops-dev"
    key            = "devops.tfstate"
    region         = "<your region>"
    encrypt        = true
    dynamodb_table = "devops-dev-lock"
  }
}

provider "aws" {
  region = "<<Your region>>"
  version = "~> 3.0"
}

```
- Setting up docker-compose
- ref# https://github.com/rupeshpanwar/DevOps-Terraform-ECS.md/blob/main/docker-compose.yml
- run the cmd to initiate
```
$ docker-compose -f Infrastructure/docker-compose.yml run --rm terraform init
```

- create a bastion ec2 machine
```
https://github.com/rupeshpanwar/DevOps-Terraform-ECS.md/blob/main/02-bastion.tf
```
- format the terraform code by 
```
 $ docker-compose -f Infrastructure/docker-compose.yml run --rm terraform init
```

- Create Terraform Workspace
- to list the tf workspace
```
$ docker-compose -f Infrastructure/docker-compose.yml run --rm terraform workspace list
```

- create dev workspace
```
$ docker-compose -f Infrastructure/docker-compose.yml run --rm terraform workspace new dev
```
- create resource prefix
```
01- main.tf
terraform {
  backend "s3" {
    bucket         = "devops-dev-tfstate"
    key            = "devops-infra.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "devops-dev-tfstate-lock"
    profile        = "rupesh"
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
    prefix = "${var.prefix}-${terraform.workspace}"
}


02-variables.tf
variable "prefix" {
    default = "projectname"
}


03-bastion.tf
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "${local.prefix}-bastion"
  }

}

```

- Common tagging
```
01- main.tf
terraform {
  backend "s3" {
    bucket         = "devops-dev-tfstate"
    key            = "devops-infra.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "devops-dev-tfstate-lock"
    profile        = "rupesh"
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
    prefix = "${var.prefix}-${terraform.workspace}"
    common_tags = {
      Environment = terraform.workspace
      Project = var.project
      Owner = var.contact
      ManagedBy = "Terraform"
    }
}


02-variables.tf 
variable "prefix" {
    default = "project-short-name"
}

variable "project" {
    default = "projectname"
}

variable "contact" {
    default = "rpanwar@msystechnologies.com"
}


03-bastions.tf
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = merge(
    local.common_tags,
    map("Name","${local.prefix}-bastion")
  )

}
```
# AWS
- Create a CI policy/user
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "TerraformRequiredPermissions",
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ec2:*"
            ],
            "Resource": "*"
        },
        {
          "Sid": "AllowListS3StateBucket",
          "Effect": "Allow",
          "Action": "s3:ListBucket",
          "Resource": "arn:aws:s3:::devops-tfstate"
        },
        {
          "Sid": "AllowS3StateBucketAccess",
          "Effect": "Allow",
          "Action": ["s3:GetObject", "s3:PutObject"],
          "Resource": "arn:aws:s3:::devops-tfstate/*"
        },
        {
            "Sid": "LimitEC2Size",
            "Effect": "Deny",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "ForAnyValue:StringNotLike": {
                    "ec2:InstanceType": [
                        "t2.micro"
                    ]
                }
            }
        },
        {
            "Sid": "AllowECRAccess",
            "Effect": "Allow",
            "Action": [
                "ecr:*"
            ],
            "Resource": "arn:aws:ecr:us-east-1:*:repository/devops-ecr"
        },
        {
            "Sid": "AllowStateLockingAccess",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/devops-tfstate-lock"
            ]
        }
    ]
}

```
- create ci user to deploy n attach the newly created policy
<img width="977" alt="image" src="https://user-images.githubusercontent.com/75510135/131491895-8cc13a25-2754-4435-90ad-008b51024dee.png">
<img width="801" alt="image" src="https://user-images.githubusercontent.com/75510135/131491991-e192730e-8df3-4948-b637-7e8da4544233.png">

- Configure credentials in Jenkins
- Set the access keys as Variables in your CI tool
<img width="806" alt="image" src="https://user-images.githubusercontent.com/75510135/131493921-00681c73-533c-4822-b21c-9db87e0c7c6e.png">


