- create ECS cluster
aws ecs create-cluster \
    --cluster-name MyCluster
"clusterArn": "arn:aws:ecs:us-east-2:075890588897:cluster/MyCluster",
- Create Taskdef from commandline

- create ecr
aws ecr create-repository \
    --repository-name hello-world
    
    

 
 Make sure that you have the latest version of the AWS CLI and Docker installed. For more information, see Getting Started with Amazon ECR .
Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods, including the Amazon ECR credential helper, see Registry Authentication 
.

    Retrieve an authentication token and authenticate your Docker client to your registry.
    Use the AWS CLI:

    aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 075890588897.dkr.ecr.us-east-2.amazonaws.com

Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here 
. You can skip this step if your image is already built:

docker build -t hello-world .

After the build completes, tag your image so you can push the image to this repository:

docker tag hello-world:latest 075890588897.dkr.ecr.us-east-2.amazonaws.com/hello-world:latest

Run the following command to push this image to your newly created AWS repository:

docker push 075890588897.dkr.ecr.us-east-2.amazonaws.com/hello-world:latest

   uri =>    075890588897.dkr.ecr.us-east-2.amazonaws.com/hello-world:latest

- register task
aws ecs register-task-definition --cli-input-json file://./fargate-task.json

- list the task definition
aws ecs list-task-definitions

- create service using public subnet
aws ecs create-service --cluster MyCluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-0215f39a482fbcfb0],securityGroups=[sg-0697d29d8295cb8d3],assignPublicIp=ENABLED}"

- create service using private subnet
aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-abcd1234],securityGroups=[sg-abcd1234]}"


- list service
aws ecs list-services --cluster fargate-cluster


- describe the running service
aws ecs describe-services --cluster fargate-cluster --services fargate-service
            
 - list subnet
 aws ec2 describe-subnet
 
 aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=vpc-3EXAMPLE"
    
 aws ec2 describe-subnets \
    --filters Name=tag:Name,Values=MySubnet \
 
- list security group
aws ec2 describe-security-groups

aws ec2 describe-security-groups \
    --filters Name=ip-permission.from-port,Values=22 Name=ip-permission.to-port,Values=22 Name=ip-permission.cidr,Values='0.0.0.0/0' \
    --query "SecurityGroups[*].[GroupName]" \
    --output text
    
 aws ec2 describe-security-groups \
    --filters Name=group-name,Values=*test* Name=tag:Test,Values=To-delete \
    --query "SecurityGroups[*].{Name:GroupName,ID:GroupId}"
    
 # Cleanup
 - delete service
 aws ecs delete-service --cluster MyCluster --service fargate-service --force
 
 - delete cluster
 aws ecs delete-cluster --cluster fargate-cluster
 
 
- Capture the TaskDefinition ARN from output.
- Commit taskdef.json in repository.
git add taskdef.json
git commit -m "Updated Taskdef"
