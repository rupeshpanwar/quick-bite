- quick ref
- https://github.com/DevOpsPlayground/Hands-on-with-Jenkins-Terraform-and-AWS
- https://gitlab.com/LondonAppDev/recipe-app-api-devops-starting-code
- https://gitlab.com/LondonAppDev/recipe-app-api-devops-course-material
# Steps
1. AWS
    * Create IAM user/policy
    * Configure MFA
    * Setup AWS Vault
    * Create S3 Bucket
3. Terraform
4. Docker


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
