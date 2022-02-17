![image](https://user-images.githubusercontent.com/75510135/154499364-d847e4ef-6026-4366-a6b2-21b024b075f7.png)

-  Summary
    1. Docker plugin 
    2. Docker hub credential
    3. Dockerfile
    4. @Jenkinsfile, build  & push docker image


#     1. Docker plugin 
![image](https://user-images.githubusercontent.com/75510135/154503293-192d357f-b369-4310-a586-47cfe43e58d5.png)

#    2. Docker hub credential

- click on Global Credentials to add Dockerhub creds

![image](https://user-images.githubusercontent.com/75510135/154503892-ffc67db3-64d4-4dcf-808f-258e2156c1f8.png)


![image](https://user-images.githubusercontent.com/75510135/154503587-c2d2af0a-7e87-4677-b95c-6675280211c2.png)


- provide same user name & credentials as in dockerhub

![image](https://user-images.githubusercontent.com/75510135/154504033-9b0ecf53-b6cd-4766-80a4-58bfe8a5ac9a.png)


![image](https://user-images.githubusercontent.com/75510135/154504166-4066f181-aa58-439a-add5-b610b7c22660.png)


#     3. Dockerfile

- to refer to build the docker image

```
FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
```

#     4. @Jenkinsfile, build  & push docker image

```
pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' 

            }
      }   //stage ending Build Artifact

      stage('Unit test') {
            steps {
              sh "mvn test"
            }
            post {
              always {
                junit 'target/surefire-reports/*.xml'
                jacoco execPattern: 'target/jacoco.exec'
              }
      }
      }   //stage ending Unit test

      stage('Docker build & push') {
            steps {
              withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
                  sh 'printenv'
                  sh 'docker build -t rupeshpanwar/numeric-app:""$GIT_COMMIT"" .'
                  sh 'docker push rupeshpanwar/numeric-app:""$GIT_COMMIT""'
                }
            }
      }   //stage ending Docker build and push 

    }
}
```

- check the result 

![image](https://user-images.githubusercontent.com/75510135/154505526-8914a25a-bddd-429c-8b45-72cc552f8538.png)

![image](https://user-images.githubusercontent.com/75510135/154505610-8b7004d0-38b5-4aa1-8f9c-25587f86627c.png)




