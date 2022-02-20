- https://kubesec.io


**Steps**

<details>
<summary>Introduction</summary>
<br>
  
  
  ![image](https://user-images.githubusercontent.com/75510135/154849485-6ce30da0-5f03-43ab-99da-9be2efab5c4b.png)

  ![image](https://user-images.githubusercontent.com/75510135/154849425-f271782a-cece-4c83-ac5c-cdc25449c594.png)

</details>

<details>
<summary>@Jenkinsfile changes</summary>
<br>

- @Jenkinsfile , extend the stage for scanning yml file, refer documentation on https://kubesec.io
  
  ![image](https://user-images.githubusercontent.com/75510135/154850171-6411f513-60ec-4c7e-aad9-6914d7ad46e4.png)

  ```
      stage('Vulnerability Scan - Kubernetes') {
      steps {
        parallel(
          "OPA Scan": {
            sh 'docker run --rm -v $(pwd):/project openpolicyagent/conftest test --policy opa-k8s-security.rego k8s_deployment_service.yaml'
          },
          "Kubesec Scan": {
            sh "bash kubesec-scan.sh"
          }
        )
      }
    }
  ```
  
  - create kubesec-scan.sh @Project root directory
  
```
  #!/bin/bash

#kubesec-scan.sh

# using kubesec v2 api
scan_result=$(curl -sSX POST --data-binary @"k8s_deployment_service.yaml" https://v2.kubesec.io/scan)
scan_message=$(curl -sSX POST --data-binary @"k8s_deployment_service.yaml" https://v2.kubesec.io/scan | jq .[0].message -r ) 
scan_score=$(curl -sSX POST --data-binary @"k8s_deployment_service.yaml" https://v2.kubesec.io/scan | jq .[0].score ) 


# using kubesec docker image for scanning
# scan_result=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < k8s_deployment_service.yaml)
# scan_message=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < k8s_deployment_service.yaml | jq .[].message -r)
# scan_score=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < k8s_deployment_service.yaml | jq .[].score)

	
    # Kubesec scan result processing
    # echo "Scan Score : $scan_score"

	if [[ "${scan_score}" -ge 5 ]]; then
	    echo "Score is $scan_score"
	    echo "Kubesec Scan $scan_message"
	else
	    echo "Score is $scan_score, which is less than or equal to 5."
	    echo "Scanning Kubernetes Resource has Failed"
	    exit 1;
	fi;
```
</details>


<details>
<summary>Validate & Fix</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/154850841-97d7380d-ce5a-4164-a07c-29326bac5dcb.png)

  - here score is 1 vs 5 hence need to look into documentation to improve the score
  - click submit this yml to kubesec

  ![image](https://user-images.githubusercontent.com/75510135/154850926-e3bc64b5-0629-427f-a4ba-9261a0b7a007.png)
  
  - implement these suggestions 
  
  ![image](https://user-images.githubusercontent.com/75510135/154850984-990ef679-5969-45a4-929a-eac9274b3961.png)

  <img width="533" alt="image" src="https://user-images.githubusercontent.com/75510135/154851027-1e299a1c-5e62-4654-b5c8-4d6427e08c33.png">

  - rerun the build now 
  
  ![image](https://user-images.githubusercontent.com/75510135/154851231-ad0815a2-dabc-4f76-82a1-1ac760200a0f.png)


</details>

