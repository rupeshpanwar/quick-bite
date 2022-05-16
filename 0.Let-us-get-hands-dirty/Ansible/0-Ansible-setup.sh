docker --version

# Configuring a Dockerfile
# Base Image
FROM ubuntu:latest

RUN apt-get update; \
    apt install -y openssh-client; \
    apt install -y python3-pip

RUN pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"

# build the ansible image n run container

# Build an image from the Dockerfile with the tag -> ansible:latest
docker build -t ansible:latest .

# Display the images
docker images

# Run the Container
docker run ansible

# Display the running containers
docker ps

#Display all the containers
docker ps --all

# Run the Container in an Interactive terminal
docker run -it ansible

# Within the container, check if ansible is installed
ansible --version

# Exit the container's interactive terminal
exit

# Start a container that is currently in the exited state 
# Replace the <container-id> with the actual one
docker start --attach <container-id>

# Destroy the container after it exits
docker run -it --rm ansible

# Verify that the image exists
docker images

# Build the "ansible" image, in case it does not exist
docker build -t ansible:latest .

# mount a volume by running this command
docker run -it --rm --volume "$(pwd)":/ansible ansible

# exit the container
exit

# Start a container in the specified work directory -- ansible
docker run -it --rm --volume "$(pwd)":/ansible --workdir /ansible rupeshpanwar/ansible

# exit the container
exit

# Environment Variables for AWS
# replace the <AWS_Access_Key_ID> and <AWS_Secret_Access_Key> 
# with the actual keys
docker run -it --rm --volume "$(pwd)":/ansible --workdir /ansible \ 
--env "AWS_ACCESS_KEY_ID='<AWS_Access_Key_ID>'" \
--env "AWS_SECRET_ACCESS_KEY='<AWS_Secret_Access_Key>'" \
ansible

# exit the container
exit

#Environment Variable for Azure
# replace the <Azure_Subscription_ID>, <Service_Principal_Application_ID>,
# <Service_Principal_Password>, and <Azure_Tenant>
# with the actual keys
docker run -it --rm --volume "$(pwd)":/ansible --workdir /ansible \ 
--env "AZURE_SUBSCRIPTION_ID=<Azure_Subscription_ID>" \
--env "AZURE_CLIENT_ID=<Service_Principal_Application_ID>" \
--env "AZURE_SECRET=<Service_Principal_Password>" \
--env "AZURE_TENANT=<Azure_Tenant>" \ 
ansible

# exit the container
exit

# Upload the Image to DockerHub
# replace <DockerHub-UserName> with your actual username.
docker login --username <DockerHub-UserName>

# Add a repository name to the tag
docker build -t <DockerHub-UserName>/ansible:latest .

# push the image
docker push <DockerHub-UserName>/ansible:latest


# Connect to AWS
# replace <Access Key> with your access key Id
export AWS_ACCESS_KEY_ID='<Access Key>'

# replace <Secret Access Key> with your secret access key
export AWS_SECRET_ACCESS_KEY='<Secret Access Key>'

# Verify that the connection to AWS is established
ansible localhost -m aws_caller_info

# In case of error, 
# "_Failed to import the required Python library (botocore or boto3)"
pip3 install boto3
pip3 install boto

# re-execute
ansible localhost -m aws_caller_info

# Dockerfile for AWS 
FROM ubuntu:latest

RUN apt-get update; \
    apt install -y openssh-client; \
    apt install -y python3-pip

RUN pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"; \
    pip3 install boto; \
    pip3 install boto3

# Azure connection settings
# Launch PowerShell
az --version

# Sign in to the Azure Account
# Replace <username> and <password> with your actual username and password
az login -u <username> -p <password>
# Or to sign in interactively
az login

# Create a service principal
# Replace the <ServicePrincipalName> with a name of your own choice
az ad sp create-for-rbac --name ServicePrincipalName

## Assign the 'Contributor' role
# Replace the APP_ID with the output appId of the create-for-rbac command. 
az role assignment create --assignee APP_ID --role Contributor

## Verify Role Assignment
# Replace the APP_ID with the output appId of the create-for-rbac command. 
az role assignment list --assignee APP_ID

## Create Environment Variables
# Azure Subscription Id
 subscriptionid=$(az account show --query id --output tsv)

# Azure Client Id
# Replace <appId> with the actual App Id
clientid=<appId>

# Azure Secret. 
# Replace <Password> with the auto-generated password for service principal.
secret=<password>

# Azure Tenant Id
# Replace <tenant> with the actual tenant Id
tenantid=<tenant>

# Environment Variables
export AZURE_SUBSCRIPTION_ID=$subscriptionid; 
export AZURE_CLIENT_ID=$clientid;
export AZURE_SECRET=$secret;
export AZURE_TENANT=$tenantid;

# echo variables and save them for later use.
echo $AZURE_SUBSCRIPTION_ID
echo $AZURE_CLIENT_ID
echo $AZURE_SECRET
echo $AZURE_TENANT

# Create a resource
ansible localhost -m azure_rm_resourcegroup -a "name=ansible location=eastus"

## In case of error,
# Failed to import the required Python library (packaging)
pip3 install ansible[azure]

# re-run - Create a resource
ansible localhost -m azure_rm_resourcegroup -a "name=ansible location=eastus"
## End - Error

# Verify the creation
az group list

# dockerfile for azure
FROM ubuntu:latest

RUN apt-get update; \
    apt install openssh-client; \
    apt-get install -y wget curl apt-transport-https; \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash; \
    apt install -y python3-pip
   
RUN pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"; \
    pip3 install ansible[azure]

    