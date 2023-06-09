<details>
<summary>what & Why</summary>
<br>
  
  <img width="802" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/48a28f0f-018f-4029-907d-3242ee960ed3">
  <img width="868" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/3bdc537f-d693-4dbd-acec-8dee7264d0b2">

  <img width="971" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/92829cb8-a75e-486e-a62f-7c00253c6201">
  
  <img width="975" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/69d4564f-dccb-477c-885a-949dd7e8a083">

  
</details>


<details>
<summary>git-lab.ci - SAST-SCA-DAST</summary>
<br>
  
  ```
    stages:
    - runSASTScanUsingSonarCloud
    - runSCAScanUsingSnyk
    - runDASTScanUsingZAP

run-sast-job:
    stage: runSASTScanUsingSonarCloud
    image: maven:3.8.5-openjdk-11-slim
    script: |
      mvn verify package sonar:sonar -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.organization=gitlabdevsecopsintegration -Dsonar.projectKey=gitlabdevsecopsintegration -Dsonar.login=2fda8f4a1af600afbede42c54c868083d8e34c01  

run-sca-job:
    stage: runSCAScanUsingSnyk
    image: maven:3.8.5-openjdk-11-slim
    script: |
      SNYK_TOKEN='2f4afa39-c493-4c6d-b34e-080c1a8f9014'
      export SNYK_TOKEN
      mvn snyk:test -fn 

run-dast-job:
    stage: runDASTScanUsingZAP
    image: maven:3.8.5-openjdk-11-slim
    script: |
      apt-get update
      apt-get -y install wget
      wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2.11.1_Linux.tar.gz
      mkdir zap
      tar -xvf ZAP_2.11.1_Linux.tar.gz
      cd ZAP_2.11.1
      ./zap.sh -cmd -quickurl https://www.example.com -quickprogress -quickout ../zap_report.html 
    artifacts:
      paths:
        - zap_report.html
  ```
</details>

<details>
<summary>Gitlab-Ultimate-SAST-SCA-DAST</summary>
<br>
  
  ```
include:
  - template: Security/SAST.gitlab-ci.yml
  - template: DAST.gitlab-ci.yml

variables:
  SAST_EXPERIMENTAL_FEATURES: "true"
  DAST_WEBSITE: http://www.example.com
  DAST_FULL_SCAN_ENABLED: "true" 
  DAST_BROWSER_SCAN: "true"

stages:
  - test
  - runSASTScanUsingSonarCloud
  - runSCAScanUsingSnyk
  - runDASTScanUsingZAP
  - dast

run-sast-job:
    stage: runSASTScanUsingSonarCloud
    image: maven:3.8.5-openjdk-11-slim
    script: |
      mvn verify package sonar:sonar -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.organization=gitlabdevsecopsintegrationkey -Dsonar.projectKey=gitlabdevsecopsintegrationkey -Dsonar.login=9ff892826b54980437f4fb0fbc72f4049ec97585 

run-sca-job:
    stage: runSCAScanUsingSnyk
    image: maven:3.8.5-openjdk-11-slim
    script: |
      SNYK_TOKEN='2f4afa39-c493-4c6d-b34e-080c1a8f9014'
      export SNYK_TOKEN
      mvn snyk:test -fn 
      
run-dast-job:
    stage: runDASTScanUsingZAP
    image: maven:3.8.5-openjdk-11-slim
    script: |
      apt-get update
      apt-get -y install wget
      wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2.11.1_Linux.tar.gz
      mkdir zap
      tar -xvf ZAP_2.11.1_Linux.tar.gz
      cd ZAP_2.11.1
      ./zap.sh -cmd -quickurl https://www.example.com -quickprogress -quickout ../zap_report.html 
    artifacts:
      paths:
        - zap_report.html 

  ```
 
</details>

<details>
<summary>Install-Jenkins-Owasp-</summary>
<br>
  
  ```
  #!/bin/bash

# Install Updated packages on linux machine
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
#sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo amazon-linux-extras install java-openjdk11
sudo yum install git -y
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
sudo yum install jenkins -y
sudo sed -i -e 's/Environment="JENKINS_PORT=[0-9]\+"/Environment="JENKINS_PORT=8081"/' /usr/lib/systemd/system/jenkins.service
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
sudo yum install unzip
sudo unzip awscliv2.zip  
sudo ./aws/install
#ZAP is isntalled at /home/ec2-user/ZAP_2.11.1/zap.sh
sudo wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2_11_1_unix.sh
sudo chmod +x ZAP_2_11_1_unix.sh 
sudo ./ZAP_2_11_1_unix.sh -q
sudo tar -xvf ZAP_2.11.1_Linux.tar.gz
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
sudo cp kubectl /usr/local/bin/
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
sudo yum install docker -y
sudo usermod -aG docker $USER
sudo newgrp docker
sudo usermod -aG docker jenkins
sudo newgrp docker
sudo service jenkins restart
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo yum install jq -y
  ```
</details>

<details>
<summary>Jenkins-SAST-SCA-DockerPush-DAST</summary>
<br>
  
   ```
     dockerfile
  FROM maven:3.8-jdk-8 as builder
COPY . /usr/src/easybuggy/
WORKDIR /usr/src/easybuggy/
RUN mvn -B package

FROM openjdk:8-slim
COPY --from=builder /usr/src/easybuggy/target/easybuggy.jar /
CMD ["java", "-XX:MaxMetaspaceSize=128m", "-Xloggc:logs/gc_%p_%t.log", "-Xmx256m", "-XX:MaxDirectMemorySize=90m", "-XX:+UseSerialGC", "-XX:+PrintHeapAtGC", "-XX:+PrintGCDetails", "-XX:+PrintGCDateStamps", "-XX:+UseGCLogFileRotation", "-XX:NumberOfGCLogFiles=5", "-XX:GCLogFileSize=10M", "-XX:GCTimeLimit=15", "-XX:GCHeapFreeLimit=50", "-XX:+HeapDumpOnOutOfMemoryError", "-XX:HeapDumpPath=logs/", "-XX:ErrorFile=logs/hs_err_pid%p.log", "-agentlib:jdwp=transport=dt_socket,server=y,address=9009,suspend=n", "-Dderby.stream.error.file=logs/derby.log", "-Dderby.infolog.append=true", "-Dderby.language.logStatementText=true", "-Dderby.locks.deadlockTrace=true", "-Dderby.locks.monitor=true", "-Dderby.storage.rowLocking=true", "-Dcom.sun.management.jmxremote", "-Dcom.sun.management.jmxremote.port=7900", "-Dcom.sun.management.jmxremote.ssl=false", "-Dcom.sun.management.jmxremote.authenticate=false", "-ea", "-jar", "easybuggy.jar"]
  
  Jenkinsfile
  
  pipeline {
  agent any
  tools { 
        maven 'Maven_3_5_2'  
    }
   stages{
    stage('CompileandRunSonarAnalysis') {
            steps {	
		sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=asgbuggywebapp -Dsonar.organization=asgbuggywebapp -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=932558e169d66a8f1d1adf470b908a46156f5844'
			}
    }

	stage('RunSCAAnalysisUsingSnyk') {
            steps {		
				withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
					sh 'mvn snyk:test -fn'
				}
			}
    }

	stage('Build') { 
            steps { 
               withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
                 script{
                 app =  docker.build("asg")
                 }
               }
            }
    }

	stage('Push') {
            steps {
                script{
                    docker.withRegistry('https://145988340565.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:aws-credentials') {
                    app.push("latest")
                    }
                }
            }
    	}
	    
  }
}
   ```
</details>

<details>
<summary>Jenkins-EKS-Deployment</summary>
<br>
  
```
	deployment.yml
	
	apiVersion: apps/v1
kind: Deployment
metadata:
  name: asgbuggy-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: asgbuggy
  template:
    metadata:
      labels:
        app: asgbuggy
    spec:
      containers:
      - name: asgbuggy
        image: 145988340565.dkr.ecr.us-west-2.amazonaws.com/asg
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
# service type loadbalancer       
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: asgbuggy
    k8s-app: asgbuggy
  name: asgbuggy
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 8080
  type: LoadBalancer
  selector:
    app: asgbuggy
	
	Jenkinnsfile
	
	pipeline {
  agent any
  tools { 
        maven 'Maven_3_5_2'  
    }
   stages{
    stage('CompileandRunSonarAnalysis') {
            steps {	
		sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=asgbuggywebapp -Dsonar.organization=asgbuggywebapp -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=932558e169d66a8f1d1adf470b908a46156f5844'
			}
    }

	stage('RunSCAAnalysisUsingSnyk') {
            steps {		
				withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
					sh 'mvn snyk:test -fn'
				}
			}
    }

	stage('Build') { 
            steps { 
               withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
                 script{
                 app =  docker.build("asg")
                 }
               }
            }
    }

	stage('Push') {
            steps {
                script{
                    docker.withRegistry('https://145988340565.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:aws-credentials') {
                    app.push("latest")
                    }
                }
            }
    	}
	   
	stage('Kubernetes Deployment of ASG Bugg Web Application') {
	   steps {
	      withKubeConfig([credentialsId: 'kubelogin']) {
		  sh('kubectl delete all --all -n devsecops')
		  sh ('kubectl apply -f deployment.yaml --namespace=devsecops')
		}
	      }
   	}

  }
}
```
 
</details>

<details>
<summary>Introduction</summary>
<br>
  
 
</details>


<details>
<summary>Introduction</summary>
<br>
  
 
</details>

