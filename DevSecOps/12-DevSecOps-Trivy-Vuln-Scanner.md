- https://github.com/aquasecurity/trivy-action
- https://aquasecurity.github.io/trivy/v0.23.0/


**Steps**

<details>
<summary>1. Introduction</summary>
<br>

![image](https://user-images.githubusercontent.com/75510135/154824514-c63c8fce-602a-42fb-a0a4-04da4d9bac46.png)
  
![image](https://user-images.githubusercontent.com/75510135/154824549-3d77a872-6357-4d60-a580-496a39f75cb7.png)

![image](https://user-images.githubusercontent.com/75510135/154825258-bc01c9ae-6eb7-436a-8a09-9f268ed0a261.png)

![image](https://user-images.githubusercontent.com/75510135/154824900-1401463b-d8ba-4c86-a0e2-86d46774d03c.png)

</details>


<details>
<summary>2. Trivy and scan</summary>
<br>

1. Trivy as docker container
2. @Jenkinsfile, add a parallel stage for Trivy scan
3. @Project root folder, create a trivy-shell-script.sh
  
## 1. Trivy as docker container
  
 - run below command to scan a docker image 
    
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.17.2 python:3.4-alpine
  
  ![image](https://user-images.githubusercontent.com/75510135/154825606-297773d6-af47-4d6f-b0dc-3c86ea7952a5.png)
  
  - work with exist code in pipeline
  
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.17.2 --exit-code 1 --severity CRITICAL python:3.4-alpine

  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/154825824-858b61cb-b3a2-4872-82bf-d9958d4de66f.png">

  
## 2. @Jenkinsfile, add a parallel stage for Trivy scan
  
  ```
     stage('Vulnerability Scan') {
      steps {
        parallel(
          "Dependency Scan": {
            sh "mvn dependency-check:check"
          },
          "Trivy Scan": {
            sh "bash trivy-docker-image-scan.sh"
          }
        )
      }
    }
  ```
  
  ## 3. @Project root folder, create a trivy-shell-script.sh
  
  ```
  ## trivy-docker-image-scan.sh

#!/bin/bash

dockerImageName=$(awk 'NR==1 {print $2}' Dockerfile)  # this will pull image name from dockerfile to run the scan
echo $dockerImageName

docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image --exit-code 0 --severity HIGH --light $dockerImageName
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image --exit-code 1 --severity CRITICAL --light $dockerImageName

    # Trivy scan result processing
    exit_code=$?
    echo "Exit Code : $exit_code"

    # Check scan results
    if [[ "${exit_code}" == 1 ]]; then
        echo "Image scanning failed. Vulnerabilities found"
        exit 1;
    else
        echo "Image scanning passed. No CRITICAL vulnerabilities found"
    fi;
  ```
</details>



<details>
<summary>3. Validation & Fix the issue</summary>
<br>

![image](https://user-images.githubusercontent.com/75510135/154825903-2dead2f4-4342-45a9-aee1-c1ea5978ffb0.png)

![image](https://user-images.githubusercontent.com/75510135/154825910-c269b4f7-91a4-487d-89bb-1c1e46aa97c9.png)

- try to find better image with lower or no vulnerability

  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.17.2 adoptopenjdk/openjdk8:alpine-slim

  <img width="1434" alt="image" src="https://user-images.githubusercontent.com/75510135/154826231-ffc8c7fd-ede6-4aa9-8217-a336737bf3b4.png">

- update dockerfile and re-run the Jenkins job
  
  <img width="596" alt="image" src="https://user-images.githubusercontent.com/75510135/154826265-8fa910ab-f0d8-4f9a-97cf-793ab21ec349.png">

```
FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8080
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
```

 - Jenkinsfile, give sudo permission to Docker to build the image

```
 
      stage('Vulnerability Scan') {
          steps {
            parallel(
              "Dependency Scan": {
                sh "mvn dependency-check:check"
              },
              "Trivy Scan": {
                sh "bash trivy-docker-image-scan.sh"
              }
            )
          }
    } // stage ending Vulnerability Scan

      stage('Docker build & push') {
            steps {
              withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
                  sh 'printenv'
                  sh 'sudo docker build -t rupeshpanwar/numeric-app:""$GIT_COMMIT"" .'
                  sh 'docker push rupeshpanwar/numeric-app:""$GIT_COMMIT""'
                }
            }
      }   //stage ending Docker build and push 
```

![image](https://user-images.githubusercontent.com/75510135/154826354-ecf356f4-22ab-4379-99ea-232f70b7c185.png)

</details>

