<details>
<summary>Create Deployment script</summary>
<br>

 - @Project root folder, create k8s-deployment.sh
  
```
#!/bin/bash

#k8s-deployment.sh

sed -i "s#replace#${imageName}#g" k8s_deployment_service.yaml
kubectl -n default get deployment ${deploymentName} > /dev/null

if [[ $? -ne 0 ]]; then
    echo "deployment ${deploymentName} doesnt exist"
    kubectl -n default apply -f k8s_deployment_service.yaml
else
    echo "deployment ${deploymentName} exist"
    echo "image name - ${imageName}"
    kubectl -n default set image deploy ${deploymentName} ${containerName}=${imageName} --record=true
fi
```
</details>


<details>
<summary>Create deployment rollout script</summary>
<br>

  - create deployment rollout script , k8s-deployment-rollout-status.sh
  
```
 #!/bin/bash

#k8s-deployment-rollout-status.sh

sleep 60s

if [[ $(kubectl -n default rollout status deploy ${deploymentName} --timeout 5s) != *"successfully rolled out"* ]]; 
then     
	echo "Deployment ${deploymentName} Rollout has Failed"
    kubectl -n default rollout undo deploy ${deploymentName}
    exit 1;
else
	echo "Deployment ${deploymentName} Rollout is Success"
fi
  
```
</details>


<details>
<summary>@Jenkinsfile, Env vars & Modify the existing K8s deployment stage</summary>
<br>
  
 - Add env vars
  
  ```
   environment {
    deploymentName = "devsecops"
    containerName = "devsecops-container"
    serviceName = "devsecops-svc"
    imageName = "rupeshpanwar/numeric-app:${GIT_COMMIT}"
    applicationURL = "http://142.93.213.194:31031/"
    applicationURI = "/increment/99"
  }

  ```
 -  Modify the existing K8s deployment stage

 ```
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
  ```
  
</details>


<details>
<summary>Validate</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/154849074-d2172718-a0c6-4092-b07d-5f01d7138437.png)

  ![image](https://user-images.githubusercontent.com/75510135/154849112-fdf90cfd-c948-47da-b680-7efd6c08069d.png)

  ```
   kubectl rollout status deploy devsecops
   kubectl rollout history deploy devsecops
  ```
  <img width="1342" alt="image" src="https://user-images.githubusercontent.com/75510135/154849224-b61091cb-142a-4072-8ed9-b3ab1f2c5f18.png">

  
</details>

<details>
<summary>Add-on </summary>
<br>

- check for po readonly file 
	
> kubectl get po
	
> kubectl get po devsecops-5688749f69-6swww -o yaml | grep read
	
<img width="644" alt="image" src="https://user-images.githubusercontent.com/75510135/154971506-c060cde8-7894-4cb3-b282-31204af8560c.png">

- make changes in deployment file

<img width="843" alt="image" src="https://user-images.githubusercontent.com/75510135/154972036-0684fdd2-2980-4823-912e-7ebf1f159c57.png">
	
- add Volume spec to k8s deployment yml
	
```
    spec:
      volumes:
      - name: vol
        emptyDir: {}
      serviceAccountName: default
      containers:
      - image: replace
        name: devsecops-container
        volumeMounts:
        - mountPath: /tmp
          name: vol
        securityContext:
          runAsNonRoot: true
          runAsUser: 100
          readOnlyRootFilesystem: true
```
<img width="1149" alt="image" src="https://user-images.githubusercontent.com/75510135/154974777-b043381c-c19a-40bd-8b40-4869e83a4fd1.png">

- check the file system again
	
<img width="630" alt="image" src="https://user-images.githubusercontent.com/75510135/154974915-f22ac2f5-b8ec-48a4-b116-e63a94d4d522.png">
	


</details>
