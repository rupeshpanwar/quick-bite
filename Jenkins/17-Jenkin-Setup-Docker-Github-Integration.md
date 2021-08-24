# setup Jenkin
- refer terraform code to spin the VPC and a medium size vm
https://github.com/rupeshpanwar/terraform-vpc.git 

- though installation is done via installJenkins.sh, if installation doesn't take place then run below code under, sudo su
                    #!/bin/bash

                    # install dependencies
                    apt-get install -y \
                        apt-transport-https \
                        ca-certificates \
                        curl \
                        gnupg-agent \
                        software-properties-common

                    # get gpg key
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

                    # add docker repo
                    add-apt-repository \
                       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                       $(lsb_release -cs) \
                       stable"

                    # update repository
                    apt-get update
                    apt-get install -y docker-ce docker-ce-cli containerd.io
                    systemctl enable docker

                    # jenkins setup
                    mkdir -p /var/jenkins_home/.ssh
- generate key
                    ssh-keygen
                    cp /root/.ssh/authorized_keys /var/jenkins_home/.ssh/authorized_keys
                    chmod 700 /var/jenkins_home/.ssh
                    chmod 600 /var/jenkins_home/.ssh/authorized_keys
                    chown -R 1000:1000 /var/jenkins_home

                    docker run -u 0 --privileged --name jenkins -it -d -p 8080:8080 -p 50000:50000 \
                                -v /var/run/docker.sock:/var/run/docker.sock \
                                -v $(which docker):/usr/bin/docker \
                                -v /home/jenkins_home:/var/jenkins_home \
                                jenkins/jenkins:latest
- once installation is done , ssh the remote EC2 machine then print the password
- docker exec -it jenkin cat /var/jenkins_home/secrets/initialAdminPassword
- launch ec2-machine-public-ip:8080 then follow the installation wizard of Jenkins
# Plugin
- once jenkins dashboard is launched, configure below plugin for docker
<img width="1413" alt="image" src="https://user-images.githubusercontent.com/75510135/130591654-50da1256-ebdc-4ec4-a075-4cf2d4263dae.png">

- switich to global tool now to install Docker
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130591852-382cf20b-d4fa-44b3-adb6-c298f34187fd.png">

- configure docker credential for your own repo(dockerhub login), under manage credential
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592009-19cbc861-4b3c-4d28-a1b7-956ac2ede9f7.png">

# Create pipeline
- refer github repo for Jenkins file
- https://github.com/rupeshpanwar/docker-demo.git
- here is jenkinsfile used in the pipeline
                  pipeline {
                    environment {
                      registry = "rupeshpanwar/docker-test"
                      registryCredential = 'dockerhub'
                      dockerImage = ''
                    }
                    agent any
                    stages {
                      stage('Cloning Git') {
                        steps {
                          git 'https://github.com/rupeshpanwar/docker-demo.git'
                        }
                      }
                      stage('Building image') {
                        steps{
                          script {
                            dockerImage = docker.build registry + ":$BUILD_NUMBER"
                          }
                        }
                      }
                      stage('Deploy Image') {
                        steps{
                          script {
                            docker.withRegistry( '', registryCredential ) {
                              dockerImage.push()
                            }
                          }
                        }
                      }
                      stage('Remove Unused docker image') {
                        steps{
                          sh "docker rmi $registry:$BUILD_NUMBER"
                        }
                      }
                    }
                  }
                  
  - click New Item
  <img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592340-5ecda3b4-ab20-47bb-b19a-a1c6bbb5fec5.png">
- enter name , select pipeline then click OK
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592440-a78c946b-f56d-4c24-aa6e-94924439f63f.png">
- click on Pipeline tab, here either we can directly paste Jenkinsfile code or we can select Github repo
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592533-bd1d907b-cca5-44c7-9f31-a9784b5697c2.png">
- let us provide github repo, as this is public repo hence credential is not required
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592721-bc896011-04a8-4694-9adf-aec6f8192440.png">
- select the branch name and path of Jenkinsfile in the branch then click save
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592830-df4e2745-3503-44d2-ba46-6f318adbc6f5.png">

- now click on BUild now,
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592909-27efad49-da39-4577-bd9b-3f94f61cc64d.png">
- job starts running
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130592969-f886083b-1fae-497c-bb81-a696050d7736.png">
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130593023-a363ba31-2440-43a3-a6f1-87513052fa6d.png">
- check the log by clicking on Job# then console output
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130593134-191c3d89-c121-4e07-a5b4-b0828a9ef243.png">
<img width="1551" alt="image" src="https://user-images.githubusercontent.com/75510135/130593167-e9091230-ae68-42d3-99fb-901a5f73ebc2.png">

