- quick ref
- https://github.com/DevOpsPlayground/Hands-on-with-Jenkins-Terraform-and-AWS
- https://gitlab.com/LondonAppDev/recipe-app-api-devops-starting-code
- https://gitlab.com/LondonAppDev/recipe-app-api-devops-course-material
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





