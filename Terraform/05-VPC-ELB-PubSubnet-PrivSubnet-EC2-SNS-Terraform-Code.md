# Step1 - Infrastructure layer
- Create S3 bucket
<img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/130730256-ab28bf06-80d6-4f28-97bd-15f8dcef1d1d.png">
<img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/130730403-1cde234f-590a-461f-84a0-307bcf1f9d2d.png">
<img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/130730495-6d2a12f9-2ab1-4287-8e24-b7e1c586ef0f.png">
-bucket name#  terraform-remote-state-dev-25-09-2021
- create project and open in Intellij idea , create 2 files main.tf and variables.tf
- reference git https://github.com/rupeshpanwar/VPC-EC2-Terraform
<img width="1105" alt="image" src="https://user-images.githubusercontent.com/75510135/130731032-0b5278e4-8753-42a0-8b2d-036f3a61717b.png">
- define remote state

          region="us-east-2"
          key="layer1/infrastructure.tfstate"
          bucket="terraform-remote-state-dev-25-09-2021"
- create VPC
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130734775-4c460b0b-7d41-4eac-ab17-d9ec3c425893.png">
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130734793-235b6454-a632-4802-84e0-6d3178b3dd18.png">

<img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/130734717-5feda89c-3b25-4cec-8fa2-4d4fe9db5f30.png">
         
- create public subnets
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130736917-98a27abd-c376-4404-8dbf-3da775f90dd6.png">
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130736941-91976e7f-e455-443e-876c-5661e3f4f14f.png">

- create private subnets
<img width="974" alt="image" src="https://user-images.githubusercontent.com/75510135/130737694-2971604c-ec45-45c1-addd-bb9892405776.png">
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130737720-df2e3bcc-a3a8-400f-b891-d360f30729ce.png">

- create route table and its association with public n private subnets
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130745852-1e4dee37-3802-412b-b011-57fd0a767083.png">

- create EIP for NAT GW
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130747060-e72cde4c-edc2-4d76-9552-109009ca742e.png">

- NAT GW n its route to access public net from private subnet
<img width="974" alt="image" src="https://user-images.githubusercontent.com/75510135/130748265-e38bf4d2-df8f-41ab-8dc5-5ff1cab37ea7.png">

- IGW n its route to access net from public sunets
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130749376-8dc733fe-266f-48bb-8894-a2c5ddabcf06.png">


- execute terraform n output vars

- vars for production
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130750357-10329e26-ff55-4481-af08-e278caa5a2d5.png">

- execution
                          terraform init -backend-config="infrastructure-prod.config"

<img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/130750762-34650b1e-3f39-489c-ae7d-a1d1f3d94437.png">
- to print the value of created resources, define output vars
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130751572-274e5224-de5a-4bb1-8146-a2763bc9fd13.png">

- prepare plan using var file for production
                          terraform plan -var-file="02.1-production.tfvars"
<img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/130752012-e5ce1b5a-974d-481c-b2e9-ecf1ae013412.png">


- to create the resources  using var file for production
                          terraform apply -var-file="02.1-production.tfvars" --auto-approve
 <img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/130752689-4be2c07f-4b1b-40df-9399-9701225976a0.png">
<img width="910" alt="image" src="https://user-images.githubusercontent.com/75510135/130752794-89d26bda-9bc5-4d28-b896-26b1aaff4bec.png">
<img width="910" alt="image" src="https://user-images.githubusercontent.com/75510135/130753157-de1dcba1-4fde-4b58-83b5-fcaeae799a6a.png">
- tfstate file is now published into S3 bucket
<img width="1237" alt="image" src="https://user-images.githubusercontent.com/75510135/130753575-f4599e49-451b-4cb8-8ec9-3cd2bef9d899.png">

# Step2 - backend layer
- config file for backend platform
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130754959-c1e51846-8fcd-4f5a-8ed6-09aa6c72757b.png">
- to fetch the data from above created section
 <img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130759162-ad64ad8d-c18a-4bce-9be1-e1927ec27b3f.png">
- variables
<img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/130759236-617d0c00-02df-4b06-9aac-31d12d2b4351.png">
- SG - for public access and remote for EC2 instance

<img width="909" alt="image" src="https://user-images.githubusercontent.com/75510135/130760945-2a5b0047-485d-4afe-b2ba-169ff32bbfce.png">

- SG - internal - to be accessed by Pub SG machines
<img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/130761925-5c32bde1-67c9-4703-bce7-35f52d1abfd0.png">

- SG - ELB
<img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/130762539-a5b16cdf-8be7-4d6e-914e-4f1dc94ee5af.png">

- IAM role n policy for EC2 instance
<img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/130763533-291383de-119d-4317-9417-2d7adf60091d.png">

- IAM instance profile
<img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/130764358-44051ff8-e85b-4f6f-8b5e-4c1e0eadd1ae.png">

- AMI infor
<img width="947" alt="image" src="https://user-images.githubusercontent.com/75510135/130771619-e7a1faf7-a461-483e-b22d-b5460edfd6ba.png">

- private EC2 instance
<img width="1437" alt="image" src="https://user-images.githubusercontent.com/75510135/130771890-391671cb-c94e-4f96-9026-f7d64bb02dd1.png">

- public EC2 instance
<img width="1471" alt="image" src="https://user-images.githubusercontent.com/75510135/130773160-accac223-f0e5-4606-a6bc-bcde37883e7d.png">

- public load balancer
<img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/130774291-4d301bb0-91f1-4362-813f-63a0f14c81ec.png">

- private Autoscaling group
<img width="1312" alt="image" src="https://user-images.githubusercontent.com/75510135/130775555-9c4cc8d2-1f9e-473a-9809-3979211ac66e.png">

- public auto scaling group
<img width="1312" alt="image" src="https://user-images.githubusercontent.com/75510135/130775513-864d3b3e-9f25-4164-ac45-5c728dc10ace.png">

- public auto-scaling policy
<img width="1312" alt="image" src="https://user-images.githubusercontent.com/75510135/130777237-a3dd830b-e844-405e-b149-e2a674ac91e0.png">

- private auto-scaling policy
<img width="1032" alt="image" src="https://user-images.githubusercontent.com/75510135/130777648-a39ad88e-cb0b-4d61-af19-c215f62da148.png">

- create SNS topic for scaling notification, sns subs , trigger on event
<img width="1075" alt="image" src="https://user-images.githubusercontent.com/75510135/130778759-c84edb51-daff-4273-a13a-f5bbbabe9f18.png">

- execution
- production.tfvars
<img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/130781789-6cab4bcf-9f82-4f85-8c52-a1bc40aa2f8d.png">

- initiate the backend
                terraform init -backend-config="backend-prod.config"
<img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/130782160-7cd3a875-5adc-42fd-8a7e-956930c2b408.png">
- prepare the plan using production var file
                terraform plan -var-file="02.1-production.tfvars"

<img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/130784885-22f93732-d19d-4377-8fc5-fc418b5c1331.png">

- apply the changes using production var file
                terraform apply -var-file="02.1-production.tfvars"


Why are we doing this? Do we even need this complication?

Again, this is an extra layer of security for accessing our EC2 Instances within the private subnets. 
We're literally adding a wall between our private resources for the outside world. If an attacker wants 
to gain access to our EC2 instances, they will have to pass through our management subnet first. 
To make this even more useful, we can launch jumper hosts and only allow them to connect to our private 
resources on private subnets.
This subnet will be sitting between public and private subnets and it'll only allow traffic from public subnet.
And for the private subnet, we'll only allow traffic from this management subnet so there'll be an extra layer of security.

Here are the steps:

1. Following our IP assignment principles, define 3 different IP blocks within the range of our VPC.

2. Use them to create 3 Management Subnets spreaded through 3 different availability zones: a, b and c.

3. Modify existing security groups for private EC2 instances to allow traffic only from these IP ranges for 
SSH or TCP port 22.


                    provider "aws" {
                      region = "eu-west-1"
                    }

                    resource "aws_subnet" "management-subnet-1" {
                      cidr_block        = "10.0.0.7"
                      vpc_id            = "${aws_vpc.production-vpc.id}"
                      availability_zone = "eu-west-1a"

                      tags {
                        Name = "Management-Subnet-1"
                      }
                    }

                    resource "aws_subnet" "management-subnet-2" {
                      cidr_block        = "10.0.0.8"
                      vpc_id            = "${aws_vpc.production-vpc.id}"
                      availability_zone = "eu-west-1b"

                      tags {
                        Name = "Management-Subnet-2"
                      }
                    }

                    resource "aws_subnet" "management-subnet-3" {
                      cidr_block        = "10.0.0.9"
                      vpc_id            = "${aws_vpc.production-vpc.id}"
                      availability_zone = "eu-west-1c"

                      tags {
                        Name = "Management-Subnet-3"
                      }
                    }

                    # Updated Security Group for Private EC2 Instances
                    resource "aws_security_group" "ec2_private_security_group" {
                      name              = "EC2-Private-SG"
                      description       = "Only allow public SG resources to access these instances"
                      vpc_id            = "${data.terraform_remote_state.network_configuration.vpc_id}"

                      ingress {
                        from_port       = 22
                        protocol        = "TCP"
                        to_port         = 22
                        cidr_blocks     = ["10.0.0.7", "10.0.0.8", "10.0.0.9"]
                      }

                      ingress {
                        from_port       = 80
                        protocol        = "TCP"
                        to_port         = 80
                        cidr_blocks     = ["0.0.0.0/0"]
                        description     = "Allow heatlh checking for instances using this SG"
                      }

                      egress {
                        from_port = 0
                        protocol = "-1"
                        to_port = 0
                        cidr_blocks = ["0.0.0.0/0"]
                      }
                    }
