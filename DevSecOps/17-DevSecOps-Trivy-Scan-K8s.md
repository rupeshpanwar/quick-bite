**Steps**

<details>
<summary>@Jenkins, extend the stage to include Trivy scan</summary>
<br>

```
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
 ```
 - create trivy-k8s-scan.sh @ project root directory
 
 ```
  #!/bin/bash


echo $imageName #getting Image name from env variable

docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image --exit-code 0 --severity LOW,MEDIUM,HIGH --light $imageName
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image --exit-code 1 --severity CRITICAL --light $imageName

    # Trivy scan result processing
    exit_code=$?
    echo "Exit Code : $exit_code"

    # Check scan results
    if [[ ${exit_code} == 1 ]]; then
        echo "Image scanning failed. Vulnerabilities found"
        exit 1;
    else
        echo "Image scanning passed. No vulnerabilities found"
    fi;
 ```
  
</details>


<details>
<summary>Validate & Fix</summary>
<br>

 <img width="1157" alt="image" src="https://user-images.githubusercontent.com/75510135/154979443-39259c9c-ef61-413d-aa96-d159ee5fc424.png">

 <img width="1077" alt="image" src="https://user-images.githubusercontent.com/75510135/154979607-c63cc712-6189-4bf4-83af-2cf6dd6812de.png">

  - nevigate to dependcy version then add stable version in pom file
  
  <img width="830" alt="image" src="https://user-images.githubusercontent.com/75510135/154981565-7b129977-f5dd-461f-afa7-29cb710bc257.png">

  <img width="1185" alt="image" src="https://user-images.githubusercontent.com/75510135/154981895-a83e01b8-b941-44e9-9640-b3ff43d4423a.png">

  <img width="1162" alt="image" src="https://user-images.githubusercontent.com/75510135/154982224-bd07276a-81f5-464a-b336-0aaf24774318.png">

</details>
