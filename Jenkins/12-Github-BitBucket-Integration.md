# Github Integration
<img width="845" alt="image" src="https://user-images.githubusercontent.com/75510135/130326172-491b291e-fa44-4db8-97a0-7d40a383e916.png">
<img width="875" alt="image" src="https://user-images.githubusercontent.com/75510135/130326204-4898a304-9d10-414d-85bf-aab86b8a8d33.png">
- Github Integration
<img width="846" alt="image" src="https://user-images.githubusercontent.com/75510135/130326485-3ed94474-b0de-4ab8-8436-7fa5d4a32fec.png">
- create new item with github organization
<img width="1121" alt="image" src="https://user-images.githubusercontent.com/75510135/130326527-a6d0d2b0-b65b-4e6b-a479-b880c1abc579.png">
<img width="1217" alt="image" src="https://user-images.githubusercontent.com/75510135/130326650-ff319dd6-fb92-4a71-9bc3-f79267c00731.png">
- create personal token on github
<img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/130326744-85f8207a-29f1-4041-8bbf-07fe91205ca3.png">
<img width="1217" alt="image" src="https://user-images.githubusercontent.com/75510135/130326789-997abed4-6d82-4cdc-b065-b844f0d7f852.png">
- feed in @Jenkins 
<img width="1217" alt="image" src="https://user-images.githubusercontent.com/75510135/130326823-afed436f-8b34-4e22-a68d-67f4bd6f8f36.png">
<img width="1217" alt="image" src="https://user-images.githubusercontent.com/75510135/130337692-bc540fb2-dfd2-49f5-bc8c-57023237dc38.png">
- once click on Save
<img width="1217" alt="image" src="https://user-images.githubusercontent.com/75510135/130337719-52507cb2-69c3-46eb-818e-246b4df30694.png">
- take an example of gradle project
- @Jenkins server, mkdir -p /var/jenkins_home/.gradle
- chown 1000:1000 /var/jenkins_home/.gradle

                              node {
                                def myGradleContainer = docker.image('gradle:jdk8')
                                myGradleContainer.pull()
                                stage('prep') {
                                  checkout scm
                                }
                                stage('test') {
                                   myGradleContainer.inside("-v ${env.HOME}/.gradle:/home/gradle/.gradle") {
                                     sh 'cd complete && gradle test'
                                   }
                                }
                                stage('run') {
                                   myGradleContainer.inside("-v ${env.HOME}/.gradle:/home/gradle/.gradle") {
                                     sh 'cd complete && gradle run'
                                   }
                                }
                              }
                              
     - it pulls all the repos that got jenkins file
 <img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130337953-0a1909f4-0076-4c2d-972f-739b7f03e44f.png">
<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338106-285d76c6-c095-43c9-9200-b41289d8d7aa.png">

# Bitbucket integration

- install plugin
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130596471-860fa734-7b25-4611-8088-f46f476f997f.png">
- configure under system
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130600988-8cbda008-89c7-4790-9ec8-03fc86a2f211.png">

- create sample project 
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130596794-84b9ce4e-1cf7-4d58-9e6f-b06d7f5b3804.png">
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130596948-78f00a7c-efd7-4b41-97c3-65c03a20c127.png">
- pick repo from bitbucket 
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130597263-92cdcbda-73cf-4997-a2fb-479125297792.png">
- supply the bitbucket url and credentials created for bitbucket
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130597482-eb5477e7-273a-46bc-a93a-f6242b146b64.png">
- @Bitbucket , create a new webhook

<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130598142-9ae620e6-6f96-460e-be32-93b150105518.png">



- create another sample project for multi-repos, owner should be account name
<img width="1545" alt="image" src="https://user-images.githubusercontent.com/75510135/130603746-00e97ecf-8d89-4a97-bd77-3fa687f2539f.png">
- add credentials(App password) created above
<img width="948" alt="image" src="https://user-images.githubusercontent.com/75510135/130603857-42192fe2-b17e-4f3a-887f-52f5c41791a8.png">
- add credential for bitbucket(app pwd token)
<img width="948" alt="image" src="https://user-images.githubusercontent.com/75510135/130604239-d55ca5a9-3fda-4286-9a88-8612197af3a4.png">
- @jenkins,create webhook for bitbucket, under configure system
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130604424-588b0100-b6b6-4d47-be11-ba6df6f193c1.png">
- @bitbucket, there is no webhook under repo in bitbucket

<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130604742-5455ff50-035c-46d0-9ed2-82cd9e47b35d.png">
- @jenkin , create new item , with bitbucket team/project

<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130604998-6a6e4291-9294-4284-a1e6-68c403844a63.png">
- mention  bb creds n owner name
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130605204-64d339cd-f3c1-4481-9fd0-675cb524659a.png">

- include extra condition to identify repos, filter by name with wildcard, mention repo name* then click save

<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130605539-8e472874-1bea-45dd-9537-fd3e96077c26.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130605709-f359f9f6-9b72-46b2-8bb9-4f1d451f537b.png">






















===================================


<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338040-457941b8-a8e0-48a7-a23d-3eb1048237a2.png">
<img width="503" alt="image" src="https://user-images.githubusercontent.com/75510135/130338052-9d3147c2-a241-4f09-b6e1-960a65c67f34.png">
<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338093-dd80852b-c1cd-46ce-8966-5971f3abdbb3.png">

<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338151-5aa6a6dc-3879-497e-833e-807b3f679af8.png">

- add credential
<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338157-c525e659-38e4-4ea1-af00-a695ec2ab082.png">

- settings  @ Bitbucket
<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338168-f9ff9d74-205f-477d-bb23-0c00afd0222a.png">
<img width="1205" alt="image" src="https://user-images.githubusercontent.com/75510135/130338179-adf5ee82-319a-4fe6-abcf-f2284da953d1.png">
<img width="1265" alt="image" src="https://user-images.githubusercontent.com/75510135/130338186-38d5e979-2378-4433-a568-447cd3d41d88.png">
<img width="1265" alt="image" src="https://user-images.githubusercontent.com/75510135/130338216-4261531a-0e87-4b7d-ab94-1311371d1c24.png">



- just create or pull one repo in bitucket to test
<img width="1265" alt="image" src="https://user-images.githubusercontent.com/75510135/130338289-cb992cdb-3128-476d-9ca8-1abe7ec2b6a4.png">
<img width="1265" alt="image" src="https://user-images.githubusercontent.com/75510135/130338294-aa7899ae-830c-460f-8290-9745a0d4bf62.png">
<img width="1265" alt="image" src="https://user-images.githubusercontent.com/75510135/130338299-1273ff8e-40ae-48e2-8c7d-a4b00d6f5dbb.png">

**Git path 
- find git installation path
- $ which git 
- under global tool configuration
<img width="1214" alt="image" src="https://user-images.githubusercontent.com/75510135/130442373-cf2be68b-8964-474b-99f5-a441e403d8b7.png">
