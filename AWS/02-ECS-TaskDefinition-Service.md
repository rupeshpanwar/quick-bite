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
<img width="855" alt="image" src="https://user-images.githubusercontent.com/75510135/131067012-022e6b88-06ed-451f-9dc2-fdcb69ee6164.png">
<img width="1284" alt="image" src="https://user-images.githubusercontent.com/75510135/131067070-ba13da91-2849-40d6-a2ac-cd66efd69034.png">
<img width="970" alt="image" src="https://user-images.githubusercontent.com/75510135/131067089-dca33508-e611-4df3-8e05-c11a4205e13a.png">
<img width="1300" alt="image" src="https://user-images.githubusercontent.com/75510135/131067547-ad40f98e-f4f9-423e-92a1-be5473c1d81e.png">

<img width="925" alt="image" src="https://user-images.githubusercontent.com/75510135/131067392-89e3f879-aaf9-4d75-87bf-2cab08d42e3d.png">
<img width="946" alt="image" src="https://user-images.githubusercontent.com/75510135/131067445-11663656-736e-493a-95f2-07996b014919.png">
<img width="1194" alt="image" src="https://user-images.githubusercontent.com/75510135/131067600-17ba6850-c5db-4811-a723-518d4b8ba822.png">








- list the task definition
aws ecs list-task-definitions

- create service using public subnet
aws ecs create-service --cluster MyCluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-0215f39a482fbcfb0],securityGroups=[sg-0697d29d8295cb8d3],assignPublicIp=ENABLED}"

- create service using private subnet
aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-abcd1234],securityGroups=[sg-abcd1234]}"


- list service
aws ecs list-services --cluster fargate-cluster

<img width="403" alt="image" src="https://user-images.githubusercontent.com/75510135/131068493-bedd0dae-16f1-4d01-b736-f673e101394a.png">
<img width="1051" alt="image" src="https://user-images.githubusercontent.com/75510135/131068589-f594ffde-5017-4730-9511-44285e5e5802.png">

<img width="395" alt="image" src="https://user-images.githubusercontent.com/75510135/131068691-63e98ab6-1c31-4d00-b04c-208d783a9345.png">
<img width="862" alt="image" src="https://user-images.githubusercontent.com/75510135/131068721-14852fa8-06c8-46a6-a0b6-6454921310ba.png">
<img width="586" alt="image" src="https://user-images.githubusercontent.com/75510135/131068848-8b7a384e-3976-4d48-b38d-5246341f583a.png">
<img width="574" alt="image" src="https://user-images.githubusercontent.com/75510135/131068989-5670678c-1d06-4c19-a6b2-4d712dc592c7.png">
<img width="320" alt="image" src="https://user-images.githubusercontent.com/75510135/131069046-b90c3650-6a35-4f5d-8b0a-4e3b0951029a.png">

<img width="317" alt="image" src="https://user-images.githubusercontent.com/75510135/131069096-eb8099bb-29d5-4802-a489-69e69b871f42.png">

<img width="429" alt="image" src="https://user-images.githubusercontent.com/75510135/131069326-0f5b6365-bc28-4782-8861-19e5dd1cb041.png">

<img width="1172" alt="image" src="https://user-images.githubusercontent.com/75510135/131069563-2734c858-3a6b-4892-9b44-7a5350ab9231.png">
<img width="438" alt="image" src="https://user-images.githubusercontent.com/75510135/131069595-d37f5d9f-8ef5-4b17-b329-69d550640faf.png">




# create target groups
<img width="1047" alt="image" src="https://user-images.githubusercontent.com/75510135/131069724-21c19b5d-8741-41a1-941c-e2c276047d9a.png">
<img width="323" alt="image" src="https://user-images.githubusercontent.com/75510135/131069810-856c7648-a16d-446a-bbcf-831fc74c50b7.png">
<img width="824" alt="image" src="https://user-images.githubusercontent.com/75510135/131069828-68974e9e-f39f-474d-8d0a-4909e72e377c.png">
<img width="742" alt="image" src="https://user-images.githubusercontent.com/75510135/131069845-4c7faf91-a1ae-4e51-8650-edc42795add6.png">
<img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/131069938-5d98b43d-3586-4a78-b188-30cf4bb21b5a.png">
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/131069965-258e37cf-538b-43b1-898e-1879eb95f721.png">

# Attach with LB listener
<img width="915" alt="image" src="https://user-images.githubusercontent.com/75510135/131070549-aadc7b5b-14a4-484e-93b9-b89d08eed297.png">



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
