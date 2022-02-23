<details>
<summary>Introduction</summary>
<br>

<img width="997" alt="image" src="https://user-images.githubusercontent.com/75510135/154983100-a09cea13-c36f-41d9-a514-2eaffb35247a.png">

 
</details>

<details>
<summary>@Jenkinsfile, add stage to check response from Application</summary>
<br>

 ```
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
      } //stage ending Integration testing 
 ```
 
 - Add environment variable 
 
 ```
    environment {
    deploymentName = "devsecops"
    containerName = "devsecops-container"
    serviceName = "devsecops-svc"
    imageName = "rupeshpanwar/numeric-app:${GIT_COMMIT}"
    applicationURL = "http://142.93.213.194:31031/"
    applicationURI = "/compare/51"
  }
  
 ```
  
 - Add shell script at @Project root folder, integration-test.sh
 
```
#!/bin/bash

#integration-test.sh

sleep 5s

PORT=$(kubectl -n default get svc ${serviceName} -o json | jq .spec.ports[].nodePort)

echo $PORT
echo $applicationURL:$PORT/$applicationURI

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
  
```
 
</details>


<details>
<summary>Validate</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/155334274-dc416a36-e1e4-410a-aa54-311ac2cea8fc.png)

  
</details>
