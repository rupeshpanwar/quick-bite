# Agenda
- Setting up Self-Hosted build host 

- Create your Personal Access Token [PAT]

- Enable System Assigned Managed Identity on Linux VM

- Create Role Assignment on your Azure Machine Learning Workspace

- Add Linux VM as Self-Hosted to Azure DevOps Agent

- Create Service Connection based on Managed Identity

- Configure your YML based Pipeline

# Setting up Self-Hosted build host 
Provision Windows [ Windows Server 2016 ] or Linux VM (Ubuntu 18.04 or 16.04 preferable) on Azure and install DevOps build Agent on this Linux VM.

While installing build agent , it will ask you for PAT [ Personal Access Token ] – refer next slide or below link on setting up build agent

Install all necessary software like Python 3+ [version > 3.6] libraries like Pandas, Numpy,  AzureML etc and restart your build agent in the Linux VM.

Select ‘Default’ as agent pool, while creating Build Agent. It will ask to place your build agent in which  Pool. 

Validate all necessary installations and configurations.

Installing Build Agent on Linux VM:   https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops


Check Python version on your Self-Hosted VM:
Go to Linux terminal and type 
Python -V

# Create your Personal Access Token [PAT]
Note: while installing build agent on self-hosted Linux VM, it will ask your Personal Access Token. Follow above steps.

Link to validate: https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops

![image](https://user-images.githubusercontent.com/75510135/126032239-0bdb82a7-99b6-472d-b2e4-884b0d5b36ae.png)

![image](https://user-images.githubusercontent.com/75510135/126032247-5c36f10e-f008-4656-bc23-dc5e373d3f48.png)

# Enable System Assigned Managed Identity on Linux VM
Contact your Azure Infra Admin to create System Assigned Managed Identity on your Self-Hosted VM.


# Create Role Assignment on your Azure Machine Learning Workspace
Contact your Azure Infra Admin to Create Role Assignment on your Azure Machine Learning Workspace.  He/she will create Role Assignment on your Azure Machine Learning Workspace to add Linux VM [ MI ] with Contributor Role on the AML workspace.

Navigate to :
AML workspace -> IAM -> Role Assignments -> Create Role Assignments  -> select Virtual Machine from the drop down and enter your Self-Hosted VM name. It will ask you role. Select Contributor here and save.

# Add Linux VM as Self-Hosted to Azure DevOps Agent

![image](https://user-images.githubusercontent.com/75510135/126032351-0b247610-288e-41d6-8c92-90c3fb2c97b5.png)

# Create Service Connection based on Managed Identity

Navigate to Project Settings -> Service Connections -> New Service Connections

![image](https://user-images.githubusercontent.com/75510135/126032387-24b13cd7-e919-4a9d-a20d-89827c29038a.png)

# Configure your YML based Pipeline [ NOT applicable to classic DevOps Azure pipeline editor ]
Use created MI [Managed Identity] based service connection in your YML based DevOps pipeline

![image](https://user-images.githubusercontent.com/75510135/126032419-2a263638-66f5-4d79-985a-a36de229024b.png)

# Setup your Azure DevOps pipeline to point to Self-Hosted Linux VM [ Applicable only to classic DevOps Azure pipeline editor ]
In case if you are using old Classic DevOps editor [ Interactive Steps ], then your pipeline and build agent should point to Self-Hosted VM.

Navigate to:
Pipelines -> Pipelines -> select your pipeline -> Edit

Select Default in Agent Pool, if your Agent Pool name is selected as ‘Default’ while creating DevOps build agent.
![image](https://user-images.githubusercontent.com/75510135/126032450-f46cd31d-f3d9-4f55-91fe-b95828a0face.png)


