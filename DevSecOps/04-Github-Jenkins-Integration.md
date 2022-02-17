- application binary https://github.com/rupeshpanwar/devsecops-k8s.git
- Create a token 
- @ Jenkins , click on Developer settings under Profile
![image](https://user-images.githubusercontent.com/75510135/154387790-4490d752-027a-4190-a0a4-93bede316de9.png)

- under personal token , give a name , duration for which token should be valid n check the repo box
![image](https://user-images.githubusercontent.com/75510135/154387975-4c6959e1-32d2-4856-9414-a7b0e00438f6.png)

- copy the token 
![image](https://user-images.githubusercontent.com/75510135/154388176-dcb397b1-5980-4bf2-a07f-11808a923369.png)

- @ Jenkins, Manage Jenkins , configure system
- click on Github server
![image](https://user-images.githubusercontent.com/75510135/154388468-eb6f3bc9-db89-4cf7-8dfb-8105c01ee7af.png)

- click on Add Credentials , then fill in respective details along with token (name can be anything here)
![image](https://user-images.githubusercontent.com/75510135/154388660-08d5b853-039b-4c63-a328-85ff960834d0.png)

![image](https://user-images.githubusercontent.com/75510135/154388786-b509dd44-31af-4089-b5a5-95f109793b4b.png)



- create webhook @ Jenkins, click on settings

![image](https://user-images.githubusercontent.com/75510135/154381691-16cbddf9-6c94-45ff-8f45-516566c0f11b.png)

- click on Add webhook
![image](https://user-images.githubusercontent.com/75510135/154381848-64483bfc-184f-4bf6-9dc4-40744ae823ce.png)

- copy the url of jenkins
![image](https://user-images.githubusercontent.com/75510135/154381938-b1943889-1a42-452e-b9ed-7815fb6b5a92.png)

![image](https://user-images.githubusercontent.com/75510135/154382019-45c9e302-e657-47bf-a761-e94624208587.png)

![image](https://user-images.githubusercontent.com/75510135/154382102-c81071fb-e76c-4c02-9f28-717dc25a9ab3.png)

- webhook is created 
![image](https://user-images.githubusercontent.com/75510135/154382183-65856f00-9dce-49ff-9c7a-145960b6f7c8.png)

# @ jenkins, create a new pipeline
![image](https://user-images.githubusercontent.com/75510135/154383430-37260b49-6a93-4c92-806c-84422c6d42c4.png)

- check the option as shown below
![image](https://user-images.githubusercontent.com/75510135/154383491-b83d235a-690b-474b-bb26-cb9c2ac58125.png)

- configure the git based pipeline , copy the url of repo
- make sure about the branch name as in github

![image](https://user-images.githubusercontent.com/75510135/154383913-80fd0721-ec5d-42fd-9a6f-f161d7bcdbaa.png)

![image](https://user-images.githubusercontent.com/75510135/154384042-f58d8763-ad87-4075-9c17-cc49d05f44bd.png)

- here is the jenkinsfile code
```
pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' //so that they can be downloaded later
            }
        }   
    }
}
```
- click on Build now
![image](https://user-images.githubusercontent.com/75510135/154384793-22f4495e-bc64-4a68-9bea-85a4e5d3cf44.png)

- console output
![image](https://user-images.githubusercontent.com/75510135/154384390-4b432110-2cc9-4ef0-8143-7cb77ac619a5.png)

![image](https://user-images.githubusercontent.com/75510135/154384516-43fecd37-7179-49c5-bb4c-090153743676.png)

# Test the connection
- make minor change in any code
- commit the code
```
git add .
git commit -m 'testing integration'
git push
```

- check the build job
![image](https://user-images.githubusercontent.com/75510135/154389987-483c36a2-9e21-4305-8c42-8fee26059909.png)
![image](https://user-images.githubusercontent.com/75510135/154390029-0906927c-3547-433e-8953-1a93d0934c63.png)

- check github for logs
![image](https://user-images.githubusercontent.com/75510135/154390082-617260b9-445b-4cac-8d34-634481e943d5.png)

![image](https://user-images.githubusercontent.com/75510135/154390129-b18f5388-e9da-4f29-bae3-234becec1df5.png)

