# Jenkins Slave
<img width="831" alt="image" src="https://user-images.githubusercontent.com/75510135/130536815-a52372f5-88f1-48e0-b14b-b1d153b0eaa1.png">
<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/130536855-2483d368-eac3-4ad5-8efa-85207ac89853.png">
<img width="801" alt="image" src="https://user-images.githubusercontent.com/75510135/130536945-23fc5bb9-8e5c-47a9-b32a-1397d0c5d84c.png">
<img width="837" alt="image" src="https://user-images.githubusercontent.com/75510135/130537004-679017c9-c1e4-4294-9e19-ef4c8aae5422.png">
<img width="829" alt="image" src="https://user-images.githubusercontent.com/75510135/130537122-43195c32-5f98-4679-90d9-00ea786c2a41.png">
<img width="839" alt="image" src="https://user-images.githubusercontent.com/75510135/130537214-4af7bd21-59cd-4af0-956f-b7f4f9d17db9.png">
<img width="787" alt="image" src="https://user-images.githubusercontent.com/75510135/130537274-805ba98c-4b2b-4836-bf3f-27312afff39a.png">
- demo
<img width="775" alt="image" src="https://user-images.githubusercontent.com/75510135/130537428-bdef63df-e853-4c03-83e9-db695a0d9bba.png">
- user_data script while spining up jenkins slave
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
                      cp /root/.ssh/authorized_keys /var/jenkins_home/.ssh/authorized_keys
                      chmod 700 /var/jenkins_home/.ssh
                      chmod 600 /var/jenkins_home/.ssh/authorized_keys
                      chown -R 1000:1000 /var/jenkins_home
                      docker run -p 2222:22 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart always -d wardviaene/jenkins-slave
                      
                      
 <img width="589" alt="image" src="https://user-images.githubusercontent.com/75510135/130537766-b92751e1-919d-4821-b0dc-3136e9d7e93c.png">
 - to generate ssh key
 - ssh-keygen -f mykey
 - cat mykey.pub

- run the container via dockerfile
                                  FROM openjdk:14-jdk-buster

                                  # install git, curl, openssh server, and remove host keys
                                  RUN apt-get update && apt-get install -y --no-install-recommends git curl openssh-server && mkdir /var/run/sshd && rm -rf /var/lib/apt/lists/* && rm -rf /etc/ssh/ssh_host_*

                                  # prepare home, user for jenkins
                                  ENV JENKINS_HOME /var/jenkins_home

                                  ARG user=jenkins
                                  ARG group=jenkins
                                  ARG uid=1000
                                  ARG gid=1000

                                  RUN groupadd -g ${gid} ${group} \
                                      && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

                                  VOLUME /var/jenkins_home

                                  # get docker client
                                  RUN mkdir -p /tmp/download && \
                                      curl -L https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz | tar -xz -C /tmp/download && \
                                      rm -rf /tmp/download/docker/dockerd && \
                                      mv /tmp/download/docker/docker* /usr/local/bin/ && \
                                      rm -rf /tmp/download && \
                                      groupadd -g 999 docker && \
                                      usermod -aG docker jenkins

                                  # expose ssh port
                                  EXPOSE 22

                                  # make sure host keys are regenerated before sshd starts
                                  COPY entrypoint.sh /entrypoint.sh

                                  ENTRYPOINT ["/entrypoint.sh"]
   
  - enterypoint.sh
                                  #!/bin/bash
                                dpkg-reconfigure openssh-server
                                /usr/sbin/sshd -D
  
  - @jenkins
  <img width="818" alt="image" src="https://user-images.githubusercontent.com/75510135/130538441-4c0ea28a-7a39-4e95-889e-7caf87bf31f5.png">
<img width="755" alt="image" src="https://user-images.githubusercontent.com/75510135/130538456-8fd1c566-2a09-4059-a68a-a82a8a6416c8.png">


# Spin up Slave via JNLP
<img width="407" alt="image" src="https://user-images.githubusercontent.com/75510135/130538911-2279c5a2-a019-4660-a6f4-c70b7d1acbbd.png">
<img width="376" alt="image" src="https://user-images.githubusercontent.com/75510135/130538964-b58ca6b2-2a91-4552-ac5e-227e2c98e769.png">
<img width="786" alt="image" src="https://user-images.githubusercontent.com/75510135/130539014-21e4b82c-ccf8-4d22-83b3-0ddea1514b88.png">


# BlueOcean
<img width="820" alt="image" src="https://user-images.githubusercontent.com/75510135/130616977-1c0a257c-8a86-461f-86ec-34ba04cf8a4a.png">
<img width="785" alt="image" src="https://user-images.githubusercontent.com/75510135/130617075-9f7b9549-0bc1-4ed9-b2ad-a66826fdafc1.png">
<img width="575" alt="image" src="https://user-images.githubusercontent.com/75510135/130617202-bbeac1e7-6349-4afb-87ca-55b899510c11.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130617298-abe04573-add4-45b6-bd4a-8eb04ec91b57.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130617346-385b6697-527a-4b2b-a1a1-becc57bbd4cd.png">
- create new pipeline
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130617799-7765be19-3bfe-4c60-a23c-880c274f2894.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130617838-4012cc81-d460-412b-a844-80e2aefa026c.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130617914-5631f654-2d7d-47fe-8399-56733c487ede.png">
- if no jenkinsfile is available then create the pipeline using wizard
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130618122-c96eb8be-9d63-4948-81d6-b62f190ae8cc.png">


# SSH-Agent
<img width="808" alt="image" src="https://user-images.githubusercontent.com/75510135/130618977-036dab91-c52a-4198-832b-bd61202c9f26.png">
<img width="785" alt="image" src="https://user-images.githubusercontent.com/75510135/130619112-6147512b-40bb-42f4-bd64-b19f2e80dd0c.png">
- configuration
<img width="835" alt="image" src="https://user-images.githubusercontent.com/75510135/130619364-88ca9d35-15de-4c5f-b4ae-069973c5881b.png">
<img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/130619458-7a933466-a25a-4478-81ca-19b2404d10c1.png">
<img width="833" alt="image" src="https://user-images.githubusercontent.com/75510135/130619533-a9aaecfe-5889-425c-8c0c-6d1af255dc4b.png">
- install SSH plugin
<img width="799" alt="image" src="https://user-images.githubusercontent.com/75510135/130622192-e21f0000-27f2-4afb-8198-e89a5790145d.png">
<img width="777" alt="image" src="https://user-images.githubusercontent.com/75510135/130622292-e8f30715-5529-414d-844a-c0ce2dec9263.png">

                    node {
                      stage('do something with git') {  
                        sshagent (credentials: ['github-key']) {
                          // get the last commit id from a repository you own
                          sh 'git ls-remote -h --refs git@github.com:wardviaene/jenkins-course.git master |awk "{print $1}"'
                        }
                      }
                    }
<img width="534" alt="image" src="https://user-images.githubusercontent.com/75510135/130622707-c5e30472-8fe5-4631-b723-657279c17443.png">
- in case of issue regarding ssh key
<img width="545" alt="image" src="https://user-images.githubusercontent.com/75510135/130622894-72b533e6-6cd7-4e27-9451-8075837b6d18.png">
