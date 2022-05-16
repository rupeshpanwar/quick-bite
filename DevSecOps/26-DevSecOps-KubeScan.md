- https://github.com/octarinesec/kube-scan

<img width="1016" alt="image" src="https://user-images.githubusercontent.com/75510135/168516457-3995ad57-faea-4ff6-8c58-a23d160e1313.png">

<details>
<summary>Installation</summary>
<br>

  <img width="918" alt="image" src="https://user-images.githubusercontent.com/75510135/168514802-d40a50f6-04da-4d83-98ec-f649293c0929.png">

  <img width="907" alt="image" src="https://user-images.githubusercontent.com/75510135/168514907-57479f5a-a60b-4e49-9415-1ff57ad5c472.png">

  <img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/168515349-1287d118-280c-4e6a-9b32-6dab957b8de3.png">

  <img width="819" alt="image" src="https://user-images.githubusercontent.com/75510135/168515386-e118fe5e-57b0-4ed9-ad7d-c5f0e5a5723a.png">

  <img width="478" alt="image" src="https://user-images.githubusercontent.com/75510135/168515415-cfa4e3be-0a5f-416e-9aa7-81e481c7a5bb.png">


</details>

<details>
<summary>Deploy a risky pod</summary>
<br>

    - deploy a risky pod
  ```
  ########### Risky Pod #############
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx-risky-pod
  name: nginx-risky-pod
spec:
  volumes:
    - name: vol
      hostPath:
       path: /etc
  shareProcessNamespace: true
  containers:
  - image: nginx
    name: nginx-risky-pod
    ports:
    - containerPort: 80
    resources: {}
    securityContext:
          capabilities:
            add:
             - ALL
          readOnlyRootFilesystem: false
          allowPrivilegeEscalation: true
    volumeMounts:
      - name: vol
        mountPath: /opt
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    run: nginx-risky-pod
  name: risky-pod-svc
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx-risky-pod
  type: LoadBalancer
  ```
  
  <img width="415" alt="image" src="https://user-images.githubusercontent.com/75510135/168515545-4945b787-bee9-4c21-86fd-a65d3344fac8.png">

  <img width="1026" alt="image" src="https://user-images.githubusercontent.com/75510135/168515597-a7361eb4-cea8-4fa2-b3af-317aa4422348.png">

  <img width="807" alt="image" src="https://user-images.githubusercontent.com/75510135/168515621-a6cc4ee3-8d62-4efa-9ebb-0a2615d951dd.png">

  
</details>


<details>
<summary>Integration Tests- Pods</summary>
<br>

  - add Jenkinsfile a new stage
  <img width="533" alt="image" src="https://user-images.githubusercontent.com/75510135/168516272-538f769d-4c02-4d4f-b79e-0237daaf2d7f.png">

  - add sh script for testing
  ```
  ################### integration-test-PROD.sh ################### 

#!/bin/bash
sleep 5s

# echo "ok"
# PORT=$(kubectl -n prod get svc ${serviceName} -o json | jq .spec.ports[].nodePort)

### Istio Ingress Gateway Port 80 - NodePort
PORT=$(kubectl -n istio-system get svc istio-ingressgateway -o json | jq '.spec.ports[] | select(.port == 80)' | jq .nodePort)


echo $PORT
echo $applicationURL:$PORT$applicationURI

if [[ ! -z "$PORT" ]];
then

    response=$(curl -s $applicationURL:$PORT$applicationURI)
    http_code=$(curl -s -o /dev/null -w "%{http_code}" $applicationURL:$PORT$applicationURI)

    if [[ "$response" == 100 ]];
        then
            echo "Increment Test Passed"
        else
            echo "Increment Test Failed"
            exit 1;
    fi;

    if [[ "$http_code" == 200 ]];
        then
            echo "HTTP Status Code Test Passed"
        else
            echo "HTTP Status code is not 200"
            exit 1;
    fi;

else
        echo "The Service does not have a NodePort"
        exit 1;
fi;

################### integration-test-PROD.sh ################### 

  ```
</details>


<details>
<summary>Complete Jenkinsfile</summary>
<br>

  ```
  
###################################### JENKINSFILE - ADD stage('Integration Tests - PROD') ######################################

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

    stage('K8S Deployment - PROD') {
      steps {
        parallel(
          "Deployment": {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "sed -i 's#replace#${imageName}#g' k8s_PROD-deployment_service.yaml"
              sh "kubectl -n prod apply -f k8s_PROD-deployment_service.yaml"
            }
          },
          "Rollout Status": {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "bash k8s-PROD-deployment-rollout-status.sh"
            }
          }
        )
      }
    }

    stage('Integration Tests - PROD') {
      steps {
        script {
          try {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "bash integration-test-PROD.sh"
            }
          } catch (e) {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "kubectl -n prod rollout undo deploy ${deploymentName}"
            }
            throw e
          }
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

###################################### JENKINSFILE - ADD stage('Integration Tests - PROD') 
  ```
  
</details>
