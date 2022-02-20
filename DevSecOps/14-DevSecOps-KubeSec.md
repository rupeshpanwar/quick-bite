

**Steps**
<details>
<summary>Introduction</summary>
<br>
 - OPA Conftest (k8s deployment)
 
![image](https://user-images.githubusercontent.com/75510135/154843046-f5a62498-c22d-440f-8a2c-1ee03c562439.png)

  
</details>


<details>
<summary>1. OPA Conftest Security & Jenkins Stage</summary>
<br>
  
- Create OPA Conftest Security, create a new file in project root directory  opa-k8s-security.rego
  
```
  package main

deny[msg] {
  input.kind = "Service"
  not input.spec.type = "NodePort"
  msg = "Service type should be NodePort"
}

deny[msg] {
  input.kind = "Deployment"
  not input.spec.template.spec.containers[0].securityContext.runAsNonRoot = true
  msg = "Containers must not run as root - use runAsNonRoot wihin container security context"
}
```
  
  
  
- @Jenkinsfile , add a stage 

```
     stage('Vulnerability Scan - Kubernetes') {
      steps {
        sh 'docker run --rm -v $(pwd):/project openpolicyagent/conftest test --policy opa-k8s-security.rego k8s_deployment_service.yaml'
      }
    }
```
  
  
</details>



<details>
<summary>2. Validate & Fix</summary>
<br>
  
![image](https://user-images.githubusercontent.com/75510135/154844107-55bf58dd-c57b-44af-baf5-e38d40d3a303.png)

  -  Error => Containers must not run as root - use runAsNonRoot wihin container security context

  <img width="637" alt="image" src="https://user-images.githubusercontent.com/75510135/154844240-7d40d32b-1ede-421e-9c8c-c4f5b59753ec.png">

 - rerun the build job
  
  ![image](https://user-images.githubusercontent.com/75510135/154844394-43906643-28cc-4960-b250-e82bef47dcea.png)

</details>

<details>
<summary>Add on - k8s rollout</summary>
<br>

  - In case during the scan deployment fails then you might need to undo the deployment, below are the cmds to be executed
  
  ```
  kubectl get all # look for any pod that has encountered issue
  kubectl describe po pod-name # pod/devsecops-5fcd55ff5d-86mb7
  kubectl get deploy
  kubectl rollout deploy -h
  kubectl rollout history deploy devsecops
  kubectl rollout status deploy devsecops
  kubectl rollout undo deploy devsecops # it will rollback to immediate previous one
  
  ```
  
</details>
