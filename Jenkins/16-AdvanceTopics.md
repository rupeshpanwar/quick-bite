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
