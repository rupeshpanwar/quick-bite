
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
5. Terraform
      1. Create VPC
      2. Create Public Subnet
      3. Create Routing Table(for public subnet)
      4. Create Igw(for public subnet)
      5. Create EIP & Nat Gateway(for public subnet)
      6. Create Private Subnet
      7. Create Routing Table(for private subnet)
      8. Create Igw(for private subnet)
6. AWS 
      1. Update IAM Policy for RDS
      2. create database.tf for RDS
      3. set env vars for RDS
      4. Update Bastion server
      5. Modify CI user so TF has permission to update bastion
      6. modify ssh key to authenticate with bastion server from local host
      7. add user data script to install dependencies on bastion server for administration
      8. add instance profile to bastion server to access resources in AWS(ECR)
      9. add bastion server to public subnet
7. Terraform
      1. Create ECS Cluster
      2. Define a Task role to give ECS access to other AWS resources
      3. Add a cloud watch log group to keep log output for containers
      4. Add container definition(CPU,memory)
      5. Create task definition to assign to ECS Service

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

# Terraform
- Create VPC
 <img width="657" alt="image" src="https://user-images.githubusercontent.com/75510135/131958261-df79b59e-6feb-4861-9c1d-75186a2174ae.png">

- refer subnet cheatsheet https://www.aelius.com/njh/subnet_sheet.html
```
resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-vpc")
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-main")
  )
}

data "aws_region" "current" {}
```

- Create Public Subnet
```
resource "aws_subnet" "public_a" {
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${data.aws_region.current.name}a"

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-a")
  )
}

resource "aws_subnet" "public_b" {
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${data.aws_region.current.name}b"

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-b")
  )
}
```

- Create Routing Table
```
resource "aws_route_table" "public_b" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-b")
  )
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_b.id
}

```

- Create Igw
```

resource "aws_route" "public_internet_access_a" {
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}



resource "aws_route" "public_internet_access_b" {
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}
```

- Create EIP & Nat Gateway
```
resource "aws_eip" "public_a" {
  vpc = true

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-a")
  )
}

resource "aws_nat_gateway" "public_a" {
  allocation_id = aws_eip.public_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-a")
  )
}

resource "aws_eip" "public_b" {
  vpc = true

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-b")
  )
}


resource "aws_nat_gateway" "public_b" {
  allocation_id = aws_eip.public_b.id
  subnet_id     = aws_subnet.public_b.id

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-public-b")
  )
}
```

- Create Private Subnet
```
# Private Subnets - Outbound internt access only 
resource "aws_subnet" "private_a" {
  cidr_block        = "10.1.10.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-private-a")
  )
}

resource "aws_subnet" "private_b" {
  cidr_block        = "10.1.11.0/24"
  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-private-b")
  )
}


resource "aws_route" "private_b_internet_out" {
  route_table_id         = aws_route_table.private_b.id
  nat_gateway_id         = aws_nat_gateway.public_b.id
  destination_cidr_block = "0.0.0.0/0"
}

```


- Create Routing Table(for private subnet)
```

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-private-a")
  )
}



resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}



resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-private-b")
  )
}


resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

```
- Create Igw(for private subnet)
```

resource "aws_route" "private_a_internet_out" {
  route_table_id         = aws_route_table.private_a.id
  nat_gateway_id         = aws_nat_gateway.public_a.id
  destination_cidr_block = "0.0.0.0/0"
}



resource "aws_route" "public_internet_access_b" {
  route_table_id         = aws_route_table.public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

```

# AWS 
- Update IAM Policy for RDS
                        "rds:DeleteDBSubnetGroup",
                        "rds:CreateDBInstance",
                        "rds:CreateDBSubnetGroup",
                        "rds:DeleteDBInstance",
                        "rds:DescribeDBSubnetGroups",
                        "rds:DescribeDBInstances",
                        "rds:ListTagsForResource",
                        "rds:ModifyDBInstance",
                        "iam:CreateServiceLinkedRole",
                        "rds:AddTagsToResource"

- RDS database.tf file
```
resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-main")
  )
}

resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
  }

  tags = local.common_tags
}

resource "aws_db_instance" "main" {
  identifier              = "${local.prefix}-db"
  name                    = "recipe"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "11.4"
  instance_class          = "db.t2.micro"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]

  tags = merge(
    local.common_tags,
    map("Name", "${local.prefix}-main")
  )
}
```
- update vars for RDS
```
# vars for RDS instance
variable "db_username" {
  description = "Username for the RDS Postgres instance"
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
}
```

- output for RDS
```
output "db_host" {
  value = aws_db_instance.main.address
}

```

- for username / password for RDS
- create sample.tfvars
```
db_username = ''
db_password = ''
```

- update env vars in Jenkins for RDS
<img width="1081" alt="image" src="https://user-images.githubusercontent.com/75510135/132328196-66f17e67-5557-4715-999b-ce21f275e39b.png">

- Update Bastion server
<img width="738" alt="image" src="https://user-images.githubusercontent.com/75510135/132332034-02b8758e-d23a-473a-ba75-b30b1abf196d.png">

- Modify CI user so TF has permission to update bastion
```
"iam:CreateRole",
"iam:GetInstanceProfile",
"iam:DeletePolicy",
"iam:DetachRolePolicy",
"iam:GetRole",
"iam:AddRoleToInstanceProfile",
"iam:ListInstanceProfilesForRole",
"iam:ListAttachedRolePolicies",
"iam:DeleteRole",
"iam:TagRole",
"iam:PassRole",
"iam:GetPolicyVersion",
"iam:GetPolicy",
"iam:CreatePolicyVersion",
"iam:DeletePolicyVersion",
"iam:CreateInstanceProfile",
"iam:DeleteInstanceProfile",
"iam:ListPolicyVersions",
"iam:AttachRolePolicy",
"iam:CreatePolicy",
"iam:RemoveRoleFromInstanceProfile"

```

- modify ssh key to authenticate with bastion server from local host
```
$ cat ~/.ssh/id_rsa.pub
```
- import the public key into EC2 
<img width="1112" alt="image" src="https://user-images.githubusercontent.com/75510135/132336680-a2f2447e-1e2a-4b7a-a316-8e923714723b.png">


- add user data script to install dependencies on bastion server for administration(templates/bastion/user-data.sh)
<img width="376" alt="image" src="https://user-images.githubusercontent.com/75510135/132339304-58b16448-2750-40b8-a90b-604dbb9c0dea.png">

```
#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker ec2-user

```
- update bastion.tf
```
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  user_data =  file("./templates/bastion/user-data.sh")
  
  tags = merge(
    local.common_tags,
    map("Name","${local.prefix}-bastion")
  )

}
```

- add instance profile to bastion server to access resources in AWS(ECR)
**instance profile is something we can assign to our bastion instance to give it IAM role**
- add instance-profile-policy.json
```
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  
 ```
 - update bastion.tf
 ```
 data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_iam_role" "bastion" {
  name               = "${local.prefix}-bastion"
  assume_role_policy = file("./templates/bastion/instance-profile-policy.json")

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "bastion_attach_policy" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${local.prefix}-bastion-instance-profile"
  role = aws_iam_role.bastion.name
}


resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  user_data =  file("./templates/bastion/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  tags = merge(
    local.common_tags,
    map("Name","${local.prefix}-bastion")
  )

}
```
- add bastion server to public subnet
- add var for bastion key 
```
variable "bastion_key_name" {
    default = "devops-bastion"
}
```
- update bastion.tf for ssh key and public subnet
```
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  user_data =  file("./templates/bastion/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  
  subnet_id = aws_subnet.public_a.id
  key_name  = var.bastion_key_name
  
  tags = merge(
    local.common_tags,
    map("Name","${local.prefix}-bastion")
  )

}
```
- Add Security group to allow inbound access port 22(ssh), outbound access 443/80, outbound access 5432(postgres)
```
resource "aws_security_group" "bastion" {
  description = "Control bastion inbound and outbound access"
  name        = "${local.prefix}-bastion"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [
      aws_subnet.private_a.cidr_block,
      aws_subnet.private_b.cidr_block,
    ]
  }

  tags = local.common_tags
}

```
- update bastion.tf to include security group
```
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  user_data =  file("./templates/bastion/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  
  subnet_id = aws_subnet.public_a.id
  key_name  = var.bastion_key_name
  
 ** vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]
**
  tags = merge(
    local.common_tags,
    map("Name","${local.prefix}-bastion")
  )

}

```
- update database.tf to include access only from securitygroup of bastion
```

resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  security_groups = [
      aws_security_group.bastion.id
    ]

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
  }

  tags = local.common_tags
}

```
- add TF output to determine bastion hostname

# Terraform 
- Create ECS cluster to group components
<img width="576" alt="image" src="https://user-images.githubusercontent.com/75510135/132460032-4c352e8e-65b5-402e-8676-998cedc9e205.png">
- update CI for ECS 
```
"logs:CreateLogGroup",
"logs:DeleteLogGroup",
"logs:DescribeLogGroups",
"logs:ListTagsLogGroup",
"logs:TagLogGroup",
"ecs:DeleteCluster",
"ecs:CreateService",
"ecs:UpdateService",
"ecs:DeregisterTaskDefinition",
"ecs:DescribeClusters",
"ecs:RegisterTaskDefinition",
"ecs:DeleteService",
"ecs:DescribeTaskDefinition",
"ecs:DescribeServices",
"ecs:CreateCluster"

```
<img width="1007" alt="image" src="https://user-images.githubusercontent.com/75510135/132461536-f6d99e4f-c99f-4265-a6b8-250de8e37a91.png">
- create cluster, ecs.tf
```
resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-cluster"

  tags = local.common_tags
}
```
- Define a Task role(assume-role-policy.json) to give ECS access to other AWS resources(like to fetch image from ECR, put logs into log stream, to start a service)
<img width="282" alt="image" src="https://user-images.githubusercontent.com/75510135/132471378-8e153423-aa2d-4d81-98ab-a116c41de0e5.png">

```
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  ```
  - task-exec-role.json
  ```
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
```
- update ecs.tf for IMA role_policy
# ... existing code ...

resource "aws_iam_policy" "task_execution_role_policy" {
  name        = "${local.prefix}-task-exec-role-policy"
  path        = "/"
  description = "Allow retrieving images and adding to logs"
  policy      = file("./templates/ecs/task-exec-role.json")
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${local.prefix}-task-exec-role"
  assume_role_policy = file("./templates/ecs/assume-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role_policy.arn
}

resource "aws_iam_role" "app_iam_role" {
  name               = "${local.prefix}-api-task"
  assume_role_policy = file("./templates/ecs/assume-role-policy.json")

  tags = local.common_tags
}


  
- Add a cloud watch log group to keep log output for containers
- Add container definition(CPU,memory)
- Create task definition to assign to ECS Service 
