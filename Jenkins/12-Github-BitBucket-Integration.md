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
