- https://www.cisecurity.org/
- https://github.com/aquasecurity/kube-bench
- https://github.com/aquasecurity/kube-bench/blob/main/docs/installation.md
- https://istio.io/latest/docs/setup/install/helm/

<details>
<summary>Introduction</summary>
<br>

  <img width="416" alt="image" src="https://user-images.githubusercontent.com/75510135/168101208-20d80eb7-5d5b-4800-955f-e7b8de48ae8d.png">

  <img width="870" alt="image" src="https://user-images.githubusercontent.com/75510135/168101313-a4178bc5-410b-4cd5-99c3-0e31ff0063a5.png">

  <img width="836" alt="image" src="https://user-images.githubusercontent.com/75510135/168101409-08445a1e-8333-414d-b32b-530e1c57df7c.png">

  <img width="684" alt="image" src="https://user-images.githubusercontent.com/75510135/168107311-0e6d4e8e-c682-41a7-aca7-56fe7873fe51.png">

  <img width="1055" alt="image" src="https://user-images.githubusercontent.com/75510135/168108201-af938b12-f2e3-4d17-b1f9-b43f783a6f94.png">

  
</details>

<details>
<summary>Install kube-bench & test few commands</summary>
<br>

  ```
   542  curl -L https://github.com/aquasecurity/kube-bench/releases/download/v0.6.2/kube-bench_0.6.2_linux_amd64.deb -o kube-bench_0.6.2_linux_amd64.deb
  543  sudo apt install ./kube-bench_0.6.2_linux_amd64.deb -f
  544  apt install ./kube-bench_0.6.2_linux_amd64.deb -f
  545  k get pods
  546  k delete pods kube-bench-wfbn7
  547  gcloud container clusters describe $CLUSTER_NAME --zone $ZONE --format json | jq '.databaseEncryption'
  548  kube-bench run --targets etcd  --version 1.15 --check 2.2 --json | jq .[].total_fail
  549  kube-bench node --check 4.2.1,4.2.2 --json | jq .[].total_fail
  ```
  
  <img width="524" alt="image" src="https://user-images.githubusercontent.com/75510135/168458973-257521f8-c673-40c8-9f10-8f58b2b2eaab.png">

  ```
  ############  Add cis-etcd.sh ############ 

#!/bin/bash
#cis-etcd.sh

total_fail=$(kube-bench run --targets etcd  --version 1.15 --check 2.2 --json | jq .[].total_fail)

if [[ "$total_fail" -ne 0 ]];
        then
                echo "CIS Benchmark Failed ETCD while testing for 2.2"
                exit 1;
        else
                echo "CIS Benchmark Passed for ETCD - 2.2"
fi;

############  Add cis-etcd.sh ############ 





############  Add cis-kubelet.sh ############ 

#!/bin/bash
#cis-kubelet.sh

total_fail=$(kube-bench run --targets node  --version 1.15 --check 4.2.1,4.2.2 --json | jq .[].total_fail)

if [[ "$total_fail" -ne 0 ]];
        then
                echo "CIS Benchmark Failed Kubelet while testing for 4.2.1, 4.2.2"
                exit 1;
        else
                echo "CIS Benchmark Passed Kubelet for 4.2.1, 4.2.2"
fi;

############  Add cis-kubelet.sh ############ 







############  Add cis-master.sh ############ 


#!/bin/bash
#cis-master.sh

total_fail=$(kube-bench master  --version 1.15 --check 1.2.7,1.2.8,1.2.9 --json | jq .[].total_fail)

if [[ "$total_fail" -ne 0 ]];
        then
                echo "CIS Benchmark Failed MASTER while testing for 1.2.7, 1.2.8, 1.2.9"
                exit 1;
        else
                echo "CIS Benchmark Passed for MASTER - 1.2.7, 1.2.8, 1.2.9"
fi;

############  Add cis-master.sh ############ 

  ```
  
  ```
  
  ```
</details>


<details>
<summary>Jenkinsfile for Kube-bench</summary>
<br>

  ```
  ############ Jenkinsfile - Add K8S CIS Benchmark Stage ############ 

@Library('slack') _

pipeline {
  agent any

  environment {
    deploymentName = "devsecops"
    containerName = "devsecops-container"
    serviceName = "devsecops-svc"
    imageName = "siddharth67/numeric-app:${GIT_COMMIT}"
    applicationURL = "http://devsecops-demo.eastus.cloudapp.azure.com"
    applicationURI = "/increment/99"
  }

  stages {

    stage('Build Artifact - Maven') {
      steps {
        sh "mvn clean package -DskipTests=true"
        archive 'target/*.jar'
      }
    }

    stage('Unit Tests - JUnit and JaCoCo') {
      steps {
        sh "mvn test"
      }
    }

    stage('Mutation Tests - PIT') {
      steps {
        sh "mvn org.pitest:pitest-maven:mutationCoverage"
      }
    }

    stage('SonarQube - SAST') {
      steps {
        withSonarQubeEnv('SonarQube') {
          sh "mvn sonar:sonar \
		              -Dsonar.projectKey=numeric-application \
		              -Dsonar.host.url=http://devsecops-demo.eastus.cloudapp.azure.com:9000"
        }
        timeout(time: 2, unit: 'MINUTES') {
          script {
            waitForQualityGate abortPipeline: true
          }
        }
      }
    }

    stage('Vulnerability Scan - Docker') {
      steps {
        parallel(
          "Dependency Scan": {
            sh "mvn dependency-check:check"
          },
          "Trivy Scan": {
            sh "bash trivy-docker-image-scan.sh"
          },
          "OPA Conftest": {
            sh 'docker run --rm -v $(pwd):/project openpolicyagent/conftest test --policy opa-docker-security.rego Dockerfile'
          }
        )
      }
    }

    stage('Docker Build and Push') {
      steps {
        withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
          sh 'printenv'
          sh 'sudo docker build -t siddharth67/numeric-app:""$GIT_COMMIT"" .'
          sh 'docker push siddharth67/numeric-app:""$GIT_COMMIT""'
        }
      }
    }

    stage('Vulnerability Scan - Kubernetes') {
      steps {
        parallel(
          "OPA Scan": {
            sh 'docker run --rm -v $(pwd):/project openpolicyagent/conftest test --policy opa-k8s-security.rego k8s_deployment_service.yaml'
          },
          "Kubesec Scan": {
            sh "bash kubesec-scan.sh"
          },
          "Trivy Scan": {
            sh "bash trivy-k8s-scan.sh"
          }
        )
      }
    }

    stage('K8S Deployment - DEV') {
      steps {
        parallel(
          "Deployment": {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "bash k8s-deployment.sh"
            }
          },
          "Rollout Status": {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "bash k8s-deployment-rollout-status.sh"
            }
          }
        )
      }
    }

    stage('Integration Tests - DEV') {
      steps {
        script {
          try {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "bash integration-test.sh"
            }
          } catch (e) {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "kubectl -n default rollout undo deploy ${deploymentName}"
            }
            throw e
          }
        }
      }
    }

    stage('OWASP ZAP - DAST') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig']) {
          sh 'bash zap.sh'
        }
      }
    }

    stage('Prompte to PROD?') {
      steps {
        timeout(time: 2, unit: 'DAYS') {
          input 'Do you want to Approve the Deployment to Production Environment/Namespace?'
        }
      }
    }

    stage('K8S CIS Benchmark') {
      steps {
        script {

          parallel(
            "Master": {
              sh "bash cis-master.sh"
            },
            "Etcd": {
              sh "bash cis-etcd.sh"
            },
            "Kubelet": {
              sh "bash cis-kubelet.sh"
            }
          )

        }
      }
    }

    // stage('Testing Slack') {
    //    steps {
    //        sh 'exit 1'
    //    }
    //  }

  }

  post {
    always {
      junit 'target/surefire-reports/*.xml'
      jacoco execPattern: 'target/jacoco.exec'
      pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
      dependencyCheckPublisher pattern: 'target/dependency-check-report.xml'
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'owasp-zap-report', reportFiles: 'zap_report.html', reportName: 'OWASP ZAP HTML Report', reportTitles: 'OWASP ZAP HTML Report'])

      //Use sendNotifications.groovy from shared library and provide current build result as parameter 
      sendNotification currentBuild.result
    }

    // success {

    // }

    // failure {

    // }
  }

}


############ Jenkinsfile - Add K8S CIS Benchmark Stage ############ 
  ```
</details>


<details>
<summary>Pod-2-Pod Communication</summary>
<br>

  <img width="536" alt="image" src="https://user-images.githubusercontent.com/75510135/168459262-6216e728-95fc-46ae-ac4d-5f00bd43ca63.png">

  <img width="543" alt="image" src="https://user-images.githubusercontent.com/75510135/168459255-50ae473e-39b3-4a93-b2e6-f300d5d9ff88.png">

  - to Encrypt/decrypt the data  via Istio(side car containers)
  <img width="598" alt="image" src="https://user-images.githubusercontent.com/75510135/168459237-e3edd60e-756f-40a7-a567-c14463fb9845.png">

</details>

<details>
<summary>Istio - basics</summary>
<br>

<img width="381" alt="image" src="https://user-images.githubusercontent.com/75510135/168459511-f5c52bc2-55da-4564-8291-21042b68943e.png">

 -  Istio features
 <img width="976" alt="image" src="https://user-images.githubusercontent.com/75510135/168459490-3326161c-c69e-448a-a34b-a4164e46d771.png">

  - Istio  Architecture
    <img width="879" alt="image" src="https://user-images.githubusercontent.com/75510135/168459470-37b7e38f-a9f6-4a03-ba66-c28f6c793f1a.png">

  - Istio capabilities

	<img width="1022" alt="image" src="https://user-images.githubusercontent.com/75510135/168459438-7b99fe3b-3756-48a6-9c8e-18261a71c467.png">

</details>

<details>
<summary>Installation</summary>
<br>

	<img width="909" alt="image" src="https://user-images.githubusercontent.com/75510135/168459751-f3fcc44b-5399-40c9-8b7e-96c80c8e73e5.png">

	```
	curl -Ls https://istio.io/downloadIstio | ISTIO_VERSION=1.9.0 sh -
	cd istio-1.9.0
	export PATH=$PWD/bin:$PATH
	istioctl install --set profile=demo -y && kubectl apply -f samples/addons
	```
	
	- below components get created
	<img width="851" alt="image" src="https://user-images.githubusercontent.com/75510135/168459781-0d010cb4-8f6a-4999-b744-009ad1e98157.png">

	<img width="618" alt="image" src="https://user-images.githubusercontent.com/75510135/168459810-e4b29678-f0be-4c93-830d-e5c6c209b4df.png">

	<img width="410" alt="image" src="https://user-images.githubusercontent.com/75510135/168459828-12bf9f4a-fc71-4af7-b2f1-a77a983cc837.png">

	<img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/168460165-8021414b-04a5-4134-b62d-0e9916ff4e37.png">

	<img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/168460201-9a8a6fdd-67d8-4bfb-8c0e-2115676a2af0.png">

	- edit Kaili service from ClusterIP to NodePort
	<img width="929" alt="image" src="https://user-images.githubusercontent.com/75510135/168460338-d00f1dda-73ac-47df-bbaf-0c9aa3a2fddc.png">

	- access Kaili dashboard
	<img width="1238" alt="image" src="https://user-images.githubusercontent.com/75510135/168460355-39415f44-4dea-4e35-8477-bbb2a5ae422b.png">

	
	
</details>

<details>
<summary>Injecting sidecar container for - Istio</summary>
<br>

	- side car injection
 <img width="1012" alt="image" src="https://user-images.githubusercontent.com/75510135/168460929-5945fe21-c540-4e4f-acb0-6da06560e669.png">

	<img width="927" alt="image" src="https://user-images.githubusercontent.com/75510135/168460942-b126dc6c-7ca3-4f18-880c-194528f77cd1.png">

	- Istio demo architecture
<img width="1007" alt="image" src="https://user-images.githubusercontent.com/75510135/168460967-9541dd9e-d734-46d4-8f9b-0598b22cb302.png">

	<img width="968" alt="image" src="https://user-images.githubusercontent.com/75510135/168460985-50f83b35-227e-4856-9497-78ea4ba28d31.png">

	```
	  569  k -n prod create deploy node-app --image nginx
	  571  k -n prod expose deploy node-app --name node-service --port 5000
	  572  k get ns --show-labels
	  573  k label ns prod istio-injection=enabled
	  574  k get ns --show-labels
	  575  k -n prod rollout -h
	  576  k -n prod rollout restart deploy node-app
	  577  k -n prod get po
	  578  k describe po node-app-78895c644-p6ghb
	  579  k -n prod  describe po node-app-78895c644-p6ghb
	```
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
