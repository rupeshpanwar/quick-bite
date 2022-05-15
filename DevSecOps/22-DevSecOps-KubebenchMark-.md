- https://www.cisecurity.org/
- https://github.com/aquasecurity/kube-bench
- https://github.com/aquasecurity/kube-bench/blob/main/docs/installation.md

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

