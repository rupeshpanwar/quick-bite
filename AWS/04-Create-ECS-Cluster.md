Creating a cluster with a Fargate task using the AWS CLI

The following steps help you set up a cluster, register a task definition, run a task, and perform other common scenarios in Amazon ECS with the AWS CLI. Ensure that you are using the latest version of the AWS CLI. For more information on how to upgrade to the latest version, see Installing the AWS Command Line Interface.

Topics

    Prerequisites
    Step 1: Create a Cluster
    Step 2: Register a Task Definition
    Step 3: List Task Definitions
    Step 4: Create a Service
    Step 5: List Services
    Step 6: Describe the Running Service
    Step 7: Clean Up

Prerequisites

This tutorial assumes that the following prerequisites have been completed.

    The latest version of the AWS CLI is installed and configured. For more information about installing or upgrading your AWS CLI, see Installing the AWS Command Line Interface.

    The steps in Setting up with Amazon ECS have been completed.

    Your AWS user has the required permissions specified in the Amazon ECS first-run wizard permissions IAM policy example.

    You have a VPC and security group created to use. This tutorial uses a container image hosted on Docker Hub so your task must have internet access. To give your task a route to the internet, use one of the following options.
        Use a private subnet with a NAT gateway that has an elastic IP address.
        Use a public subnet and assign a public IP address to the task.

    For more information, see Tutorial: Creating a VPC with Public and Private Subnets for Your Clusters.

Step 1: Create a Cluster

By default, your account receives a default cluster.

Note
The benefit of using the default cluster that is provided for you is that you don't have to specify the --cluster cluster_name option in the subsequent commands. If you do create your own, non-default, cluster, you must specify --cluster cluster_name for each command that you intend to use with that cluster.

Create your own cluster with a unique name with the following command:

aws ecs create-cluster --cluster-name fargate-cluster

Output:

{
    "cluster": {
        "status": "ACTIVE", 
        "statistics": [], 
        "clusterName": "fargate-cluster", 
        "registeredContainerInstancesCount": 0, 
        "pendingTasksCount": 0, 
        "runningTasksCount": 0, 
        "activeServicesCount": 0, 
        "clusterArn": "arn:aws:ecs:region:aws_account_id:cluster/fargate-cluster"
    }
}

Step 2: Register a Task Definition

Before you can run a task on your ECS cluster, you must register a task definition. Task definitions are lists of containers grouped together. The following example is a simple task definition that creates a PHP web app using the httpd container image hosted on Docker Hub. For more information about the available task definition parameters, see Amazon ECS task definitions.

{
    "family": "sample-fargate", 
    "networkMode": "awsvpc", 
    "containerDefinitions": [
        {
            "name": "fargate-app", 
            "image": "httpd:2.4", 
            "portMappings": [
                {
                    "containerPort": 80, 
                    "hostPort": 80, 
                    "protocol": "tcp"
                }
            ], 
            "essential": true, 
            "entryPoint": [
                "sh",
		"-c"
            ], 
            "command": [
                "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
            ]
        }
    ], 
    "requiresCompatibilities": [
        "FARGATE"
    ], 
    "cpu": "256", 
    "memory": "512"
}

The above example JSON can be passed to the AWS CLI in two ways: You can save the task definition JSON as a file and pass it with the --cli-input-json file://path_to_file.json option. Or, you can escape the quotation marks in the JSON and pass the JSON container definitions on the command line as in the below example. If you choose to pass the container definitions on the command line, your command additionally requires a --family parameter that is used to keep multiple versions of your task definition associated with each other.

To use a JSON file for container definitions:

aws ecs register-task-definition --cli-input-json file://$HOME/tasks/fargate-task.json

The register-task-definition command returns a description of the task definition after it completes its registration.
Step 3: List Task Definitions

You can list the task definitions for your account at any time with the list-task-definitions command. The output of this command shows the family and revision values that you can use together when calling run-task or start-task.

aws ecs list-task-definitions

Output:

{
    "taskDefinitionArns": [
        "arn:aws:ecs:region:aws_account_id:task-definition/sample-fargate:1"
    ]
}

Step 4: Create a Service

After you have registered a task for your account, you can create a service for the registered task in your cluster. For this example, you create a service with one instance of the sample-fargate:1 task definition running in your cluster. The task requires a route to the internet, so there are two ways you can achieve this. One way is to use a private subnet configured with a NAT gateway with an elastic IP address in a public subnet. Another way is to use a public subnet and assign a public IP address to your task. We provide both examples below.

Example using a private subnet.

aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-abcd1234],securityGroups=[sg-abcd1234]}"

Example using a public subnet.

aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-abcd1234],securityGroups=[sg-abcd1234],assignPublicIp=ENABLED}"

The create-service command returns a description of the task definition after it completes its registration.
Step 5: List Services

List the services for your cluster. You should see the service that you created in the previous section. You can take the service name or the full ARN that is returned from this command and use it to describe the service later.

aws ecs list-services --cluster fargate-cluster

Output:

{
    "serviceArns": [
        "arn:aws:ecs:region:aws_account_id:service/fargate-service"
    ]
}

Step 6: Describe the Running Service

Describe the service using the service name retrieved earlier to get more information about the task.

aws ecs describe-services --cluster fargate-cluster --services fargate-service

If successful, this will return a description of the service failures and services. For example, in services section, you will find information on deployments, such as the status of the tasks as running or pending. You may also find information on the task definition, the network configuration and time-stamped events. In the failures section, you will find information on failures, if any, associated with the call. For troubleshooting, see Service Event Messages. For more information about the service description, see Describe Services. If your instance was launched in a public subnet, you can view the service task from the internet by using the AWS CLI command list-tasks to retrieve the task ID needed for the command describe-tasks to retrieve the public IP address of the website.

{
    "services": [
        {
            "status": "ACTIVE", 
            "taskDefinition": "arn:aws:ecs:region:aws_account_id:task-definition/sample-fargate:1", 
            "pendingCount": 2, 
            "launchType": "FARGATE", 
            "loadBalancers": [], 
            "roleArn": "arn:aws:iam::aws_account_id:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS", 
            "placementConstraints": [], 
            "createdAt": 1510811361.128, 
            "desiredCount": 2, 
            "networkConfiguration": {
                "awsvpcConfiguration": {
                    "subnets": [
                        "subnet-abcd1234"
                    ], 
                    "securityGroups": [
                        "sg-abcd1234"
                    ], 
                    "assignPublicIp": "DISABLED"
                }
            }, 
            "platformVersion": "LATEST", 
            "serviceName": "fargate-service", 
            "clusterArn": "arn:aws:ecs:region:aws_account_id:cluster/fargate-cluster", 
            "serviceArn": "arn:aws:ecs:region:aws_account_id:service/fargate-service", 
            "deploymentConfiguration": {
                "maximumPercent": 200, 
                "minimumHealthyPercent": 100
            }, 
            "deployments": [
                {
                    "status": "PRIMARY", 
                    "networkConfiguration": {
                        "awsvpcConfiguration": {
                            "subnets": [
                                "subnet-abcd1234"
                            ], 
                            "securityGroups": [
                                "sg-abcd1234"
                            ], 
                            "assignPublicIp": "DISABLED"
                        }
                    }, 
                    "pendingCount": 2, 
                    "launchType": "FARGATE", 
                    "createdAt": 1510811361.128, 
                    "desiredCount": 2, 
                    "taskDefinition": "arn:aws:ecs:region:aws_account_id:task-definition/sample-fargate:1", 
                    "updatedAt": 1510811361.128, 
                    "platformVersion": "0.0.1", 
                    "id": "ecs-svc/9223370526043414679", 
                    "runningCount": 0
                }
            ], 
            "events": [
                {
                    "message": "(service fargate-service) has started 2 tasks: (task 53c0de40-ea3b-489f-a352-623bf1235f08) (task d0aec985-901b-488f-9fb4-61b991b332a3).", 
                    "id": "92b8443e-67fb-4886-880c-07e73383ea83", 
                    "createdAt": 1510811841.408
                }, 
                {
                    "message": "(service fargate-service) has started 2 tasks: (task b4911bee-7203-4113-99d4-e89ba457c626) (task cc5853e3-6e2d-4678-8312-74f8a7d76474).", 
                    "id": "d85c6ec6-a693-43b3-904a-a997e1fc844d", 
                    "createdAt": 1510811601.938
                }, 
                {
                    "message": "(service fargate-service) has started 2 tasks: (task cba86182-52bf-42d7-9df8-b744699e6cfc) (task f4c1ad74-a5c6-4620-90cf-2aff118df5fc).", 
                    "id": "095703e1-0ca3-4379-a7c8-c0f1b8b95ace", 
                    "createdAt": 1510811364.691
                }
            ], 
            "runningCount": 0, 
            "placementStrategy": []
        }
    ], 
    "failures": []
}

Step 7: Clean Up

When you are finished with this tutorial, you should clean up the associated resources to avoid incurring charges for unused resources.

Delete the service.

aws ecs delete-service --cluster fargate-cluster --service fargate-service --force

Delete the cluster.

aws ecs delete-cluster --cluster fargate-cluster
