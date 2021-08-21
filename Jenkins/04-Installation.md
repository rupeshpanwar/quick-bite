
<img width="593" alt="image" src="https://user-images.githubusercontent.com/75510135/130084486-cc0111d7-b3f5-4ed8-b027-d6ec1cba19fd.png">
<img width="759" alt="image" src="https://user-images.githubusercontent.com/75510135/130084928-3fba5006-e038-45e3-ae68-9e7af635b0d7.png">

# DigitalOcean Installation Procedure
This is just a summary

Summary
        Create DigitalOcean account

        Create Droplet

        Jenkins install

        Configuration until you hit main screen

 

Full list of installation parameters: see https://hub.docker.com/_/jenkins/

Create DigitalOcean Account
Sign-up using https://m.do.co/c/007f99ffb902 to get $10 in credit to use on a droplet

Create droplet
with the $10 credits you can run a 1 GB memory droplet for 1 month, a 2 GB for at least 2 weeks and a 4 GB droplet for at least 1 week. The 4 GB memory droplet is recommended

Choose for ubuntu 16.04.x (xenial)

You can choose another system, but the instructions provided to install docker will only work on ubuntu xenial

Install Docker
        $ sudo apt-get update

        $ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D



        $ sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'

        $ sudo apt-get update

        $ sudo apt-get install -y docker-engine

        $ sudo systemctl enable docker

 

Install Jenkins
        $ sudo mkdir -p /var/jenkins_home

        $ sudo chown -R 1000:1000 /var/jenkins_home/

        $ docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home --name jenkins -d jenkins/jenkins:lts

 

Open browser and go to: http://IP:8080/ (change IP to your droplet IP)

You will be asked for initial password for the Jenkins, you can get this password by entering following command on your server.

 

        $ cat /var/jenkins_home/secrets/initialAdminPassword


A screen with “Create First admin User prompt” will appear. You will need to enter a username, password, full name and email address.

Alternative Installation methods
Using a Vagrant box: https://github.com/wardviaene/devops-box

        Works on Mac / Linux / Windows

        Download virtualbox at www.virtualbox.org

        Download vagrant at www.vagrantup.com

        Download the repository, open a cmd/shell/terminal

        cd into the project directory

        Type “vagrant up”

Without tools, just a plain install on your Linux / Mac / Windows machine:

Download the package from https://jenkins.io/download/ and follow the instructions for your operating system


<img width="993" alt="image" src="https://user-images.githubusercontent.com/75510135/130087812-96dc3102-540c-4dcc-97ec-9b185a811765.png">
<img width="963" alt="image" src="https://user-images.githubusercontent.com/75510135/130087928-e57c2c9c-e503-43c2-af7a-c67ca90de12a.png">
<img width="968" alt="image" src="https://user-images.githubusercontent.com/75510135/130088018-e8ed27df-fd93-4ce8-9b44-ede1bfb54b00.png">
<img width="982" alt="image" src="https://user-images.githubusercontent.com/75510135/130088191-4b365b3d-4a9f-4c88-b82e-729132ae3ef4.png">
- connect to VM
```

              key $ ls
              connect-jerkins.pem
              key $ chmod 400 connect-jerkins.pem
              key $  ssh -i "connect-jerkins.pem" ec2-user@ec2.us-east-2.compute.amazonaws.com
              The authenticity of host 'ec2.us-east-2.compute.amazonaws.com ()' can't be established.
              ECDSA key fingerprint is SHA256:iPTiLa7Szsd0u2WpRAeYw7ZW5W38fw/RMEkLxOMpksc.
              Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
              Warning: Permanently added 'ec2.us-east-2.compute.amazonaws.com,' (ECDSA) to the list of known hosts.

                     __|  __|_  )
                     _|  (     /   Amazon Linux 2 AMI
                    ___|\___|___|

              https://aws.amazon.com/amazon-linux-2/
              4 package(s) needed for security, out of 16 available
              Run "sudo yum update" to apply all updates.
              -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory


[ec2-user$ wget https://github.com/rupeshpanwar/jenkins-course/tree/master/scripts/install_jenkins.sh

- install jenkins n docker on ubuntu machine


          #!/bin/bash

          # this script is only tested on ubuntu xenial

          # install docker
          curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
          sudo add-apt-repository \
             "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
             $(lsb_release -cs) \
             stable"
          apt-get update
          apt-get install docker-ce docker-ce-cli containerd.io
          systemctl enable docker
          systemctl start docker
          usermod -aG docker ubuntu

          # run jenkins
          mkdir -p /var/jenkins_home
          chown -R 1000:1000 /var/jenkins_home/
          docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins/jenkins:lts

          # show endpoint
          echo 'Jenkins installed'
          echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'


<img width="638" alt="image" src="https://user-images.githubusercontent.com/75510135/130094324-5559693f-8512-4913-a50a-22f27d645d44.png">
<img width="733" alt="image" src="https://user-images.githubusercontent.com/75510135/130095791-e8188661-836e-4712-ad4f-08f846b9611a.png">
- password for admin is saved at > cat path given in above screenshot
<img width="689" alt="image" src="https://user-images.githubusercontent.com/75510135/130096244-f14fc8c2-a14c-4a62-b619-ddaff6ae2ce3.png">
- password for admin is saved at > cat  /var/jenkins_home/secrets/initialAdminPassword
```
          root@ip-:/home/ubuntu# docker container ls
          CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                                                                                      NAMES
          b660734   jenkins/jenkins:lts   "/sbin/tini -- /usr/…"   15 minutes ago   Up 15 minutes   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   jenkins
          root@ip-:/home/ubuntu# docker restart b660734
```
<img width="746" alt="image" src="https://user-images.githubusercontent.com/75510135/130096966-ac0798be-aa1c-4f49-8b54-ca620e8f3d10.png">
<img width="754" alt="image" src="https://user-images.githubusercontent.com/75510135/130097204-32256c7a-259f-4cae-9e43-36e903b8aec2.png">
<img width="741" alt="image" src="https://user-images.githubusercontent.com/75510135/130097346-e62e1f7c-2adc-46b4-88c9-ae6f869ec7d0.png">


<img width="733" alt="image" src="https://user-images.githubusercontent.com/75510135/130095791-e8188661-836e-4712-ad4f-08f846b9611a.png">
<img width="874" alt="image" src="https://user-images.githubusercontent.com/75510135/130101868-f65fc2e7-8fee-4e43-97a4-44a853b32188.png">
<img width="1438" alt="image" src="https://user-images.githubusercontent.com/75510135/130102011-f69c1c6f-dcaf-40d9-b6ad-bc151062894a.png">
<img width="891" alt="image" src="https://user-images.githubusercontent.com/75510135/130104088-7f50c7b3-7164-4888-a89e-f4e02e729dae.png">

# common plugins
<img width="1279" alt="image" src="https://user-images.githubusercontent.com/75510135/130312253-5456fcd5-d902-4043-922f-b2cf173e7e98.png">
