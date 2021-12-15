
# Lab
https://azuredevopsdemogenerator.azurewebsites.net/

# Sonar-qube integration
![image](https://user-images.githubusercontent.com/75510135/124922676-59c6c300-e017-11eb-8cdc-abc20e12e183.png)

- https://www.iwayq.com/tutorial/devops-automation/kubernetes/devops-project-jenkins-cicd-for-kubernetes-deployments/sonarqube-architecture-1
- git clone https://bitbucket.org/iwayqtech/devops-pipeline-project.git

- install n configure Postgress SQL
- install n configure SonarQube Scanner

![image](https://user-images.githubusercontent.com/75510135/124920438-f045b500-e014-11eb-8e11-cb57f1a4b15a.png)
- Install via Docker Image
![image](https://user-images.githubusercontent.com/75510135/124922892-9397c980-e017-11eb-8287-ae64cc5a39ef.png)

- steps to install n integrate SonarQube with Azure DevOps
![image](https://user-images.githubusercontent.com/75510135/124923047-b6c27900-e017-11eb-9104-f03d3ce31d5a.png)

- Azure DevOps Integration Config
![image](https://user-images.githubusercontent.com/75510135/124923792-6a2b6d80-e018-11eb-8033-59bbe926e719.png)

- Create Access Token in Azure DevOps
![image](https://user-images.githubusercontent.com/75510135/124924076-af4f9f80-e018-11eb-8bff-b539754e5cc7.png)

![image](https://user-images.githubusercontent.com/75510135/124924332-fc337600-e018-11eb-8e68-9147ca2a236d.png)

![image](https://user-images.githubusercontent.com/75510135/124924392-09506500-e019-11eb-88ee-f40ce976125f.png)

![image](https://user-images.githubusercontent.com/75510135/124924464-1c633500-e019-11eb-95cd-778c18a32a5a.png)

![image](https://user-images.githubusercontent.com/75510135/124924603-40bf1180-e019-11eb-888e-6f9555f36ff2.png)

![image](https://user-images.githubusercontent.com/75510135/124924675-50d6f100-e019-11eb-8e30-bf392659fb17.png)

![image](https://user-images.githubusercontent.com/75510135/124924758-62b89400-e019-11eb-9587-3a44d52b7d94.png)

- Configure Azure DevOps Repo in SonarQube Dashboard
![image](https://user-images.githubusercontent.com/75510135/124925123-c17e0d80-e019-11eb-913f-e5ab1e6a6b34.png)

- check and setup project
![image](https://user-images.githubusercontent.com/75510135/124925399-043fe580-e01a-11eb-974c-3bbb5215e03d.png)
- select Azure pipeline
![image](https://user-images.githubusercontent.com/75510135/124925491-1cb00000-e01a-11eb-8c9e-9ab68aea2b67.png)
![image](https://user-images.githubusercontent.com/75510135/124925540-2afe1c00-e01a-11eb-9049-bf012504ce7a.png)

- install SonarQube extension @ Azure Devops side
![image](https://user-images.githubusercontent.com/75510135/124926025-b2e42600-e01a-11eb-8301-ae0e418fe41e.png)

![image](https://user-images.githubusercontent.com/75510135/124926425-225a1580-e01b-11eb-98ea-1c148b588ec4.png)

- Add Service Connection between Azure DevOps and SonarQube  @Azure DevOps
![image](https://user-images.githubusercontent.com/75510135/124926524-40277a80-e01b-11eb-9dfa-da46583ba899.png)

![image](https://user-images.githubusercontent.com/75510135/124926689-72d17300-e01b-11eb-9933-89e114b09ffb.png)


- Get Service URL @ SQ
![image](https://user-images.githubusercontent.com/75510135/124926833-9a284000-e01b-11eb-814d-4d9e9b4d7b69.png)

- Generate Token @ SQ

![image](https://user-images.githubusercontent.com/75510135/124926931-b1672d80-e01b-11eb-9250-7266ecc8e2f2.png)

-  Submit the Service Connection config @ ADvops
![image](https://user-images.githubusercontent.com/75510135/124927149-eecbbb00-e01b-11eb-924c-14a0414b0e42.png)

- Configure Analysis @ SQ
![image](https://user-images.githubusercontent.com/75510135/124927411-423e0900-e01c-11eb-955c-873ef25d8fc9.png)

- @ ADvops , add below task to pipeline at the top - Prepare analysis on SQ
![image](https://user-images.githubusercontent.com/75510135/124927597-6f8ab700-e01c-11eb-8cbc-67f889dbd21c.png)

- @ SQ, bring in project and key (Sonarqube access token generated in previous step) to fill in above SQ pipeline step
![image](https://user-images.githubusercontent.com/75510135/124928227-13746280-e01d-11eb-9e36-ab799e30832e.png)

- @ ADvops , pipeline, check Code Analysis under Maven task
![image](https://user-images.githubusercontent.com/75510135/124928604-5b938500-e01d-11eb-9364-5cdb640b32e1.png)

- @ ADvops, pipeline, publish Quality gate Results
![image](https://user-images.githubusercontent.com/75510135/124928754-85e54280-e01d-11eb-882e-49ac3f30c5f9.png)

![image](https://user-images.githubusercontent.com/75510135/124928894-a44b3e00-e01d-11eb-9ef1-9d0a5f950b31.png)

- @ SQ, report of analysis
![image](https://user-images.githubusercontent.com/75510135/124929320-099f2f00-e01e-11eb-96c1-408c34250e3d.png)
















