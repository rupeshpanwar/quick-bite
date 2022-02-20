- https://www.conftest.dev/install/#docker
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- https://github.com/gbrindisi/dockerfile-security


**Steps**
<details>
<summary>Introduction</summary>
<br>

  
 ![image](https://user-images.githubusercontent.com/75510135/154826815-0065404f-61a2-446b-9c2a-75b95e094571.png)

</details>



<details>
<summary>1. Docker Best Practice n OPA Conftest tool</summary>
<br>

![image](https://user-images.githubusercontent.com/75510135/154826936-a7d6ef9c-137a-446d-91e4-341fe289161a.png)

![image](https://user-images.githubusercontent.com/75510135/154826951-973b4a75-baaf-4708-ac26-4a7811733f10.png)

![image](https://user-images.githubusercontent.com/75510135/154826981-7757d687-651a-48da-9719-1173c7db4683.png)

- look for rego file in git to place the rules against dockerfile
  
> https://github.com/rupeshpanwar/dockerfile-security/blob/main/dockerfile-security.rego

### Check the current container running under root user or not
> kubectl exec -it  devsecops-6df5c8c5b5-7tj2q -- id
  
<img width="1052" alt="image" src="https://user-images.githubusercontent.com/75510135/154827346-7c14c43b-bcb7-4740-a57a-f14c78b1c020.png">

  
## @Project root directory , create a new rego file - opa-docker-security.rego
 > copy rules from > https://github.com/rupeshpanwar/dockerfile-security/blob/main/dockerfile-security.rego

<img width="983" alt="image" src="https://user-images.githubusercontent.com/75510135/154827460-9e2a2a7b-4bc5-4918-98c4-f0f73e7c6327.png">

## @Jenkinsfile, Add a stage for scan

```
             "OPA Conftest": {
            sh 'docker run --rm -v $(pwd):/project openpolicyagent/conftest test --policy opa-docker-security.rego Dockerfile'
             }
```
<img width="1163" alt="image" src="https://user-images.githubusercontent.com/75510135/154827747-6c07321e-b2e5-425e-81a5-f2c49c080728.png">
  
</details>



<details>
<summary>2. Validate & Fix</summary>
<br>
  
![image](https://user-images.githubusercontent.com/75510135/154827799-4ca476c1-cc95-4506-94cd-b6392433e277.png)


  
## Modify the rego file to accomodate the changes , like base image issue here

 <img width="695" alt="image" src="https://user-images.githubusercontent.com/75510135/154827827-ec68eccb-9a5b-405e-9d9f-54669379171a.png">
 
  
## Modify dockerfile  to accomodate the changes , like
  - use COPY instead of ADD
  - run process under a user hence create new user first
  
```
FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8080
ARG JAR_FILE=target/*.jar
RUN addgroup -S pipeline && adduser -S k8s-pipeline -G pipeline
COPY ${JAR_FILE} /home/k8s-pipeline/app.jar
USER k8s-pipeline
ENTRYPOINT ["java","-jar","/home/k8s-pipeline/app.jar"]
```

 - rerun the build job n verify the result
  
 ![image](https://user-images.githubusercontent.com/75510135/154827929-986e0634-c6da-47aa-af16-596e5a411aa9.png)

 <img width="724" alt="image" src="https://user-images.githubusercontent.com/75510135/154827946-68698a91-04fc-4439-af56-6d1e2933e4d3.png">

</details>


<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
