- Summary 
    1. K8s Deployment yml file
    2. @Jenkinsfile, Add K8s stage to execute the deployment & service
    3. Deploy NodeJs Backend service

![image](https://user-images.githubusercontent.com/75510135/154777691-ce87ab12-7fd2-41bd-af2f-2043312c037f.png)

#     1. K8s Deployment yml file
```
k8s_deployment_service.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: devsecops
  name: devsecops
spec:
  replicas: 2
  selector:
    matchLabels:
      app: devsecops
  strategy: {}
  template:
    metadata:
      labels:
        app: devsecops
    spec:
      containers:
      - image: replace
        name: devsecops-container
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: devsecops
  name: devsecops-svc
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    app: devsecops
  type: NodePort
```

#     2. @Jenkinsfile, Add K8s stage to execute the deployment & service
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

      stage('Kubernetes Deployment - DEV') {
        steps {
            withKubeConfig([credentialsId: 'kubeconfig']) {
              sh "sed -i 's#replace#rupeshpanwar/numeric-app:${GIT_COMMIT}#g' k8s_deployment_service.yaml"
              sh "kubectl apply -f k8s_deployment_service.yaml"
            }
        }
      } // stage ending k8s deployment -  DEV

    }
}
```

#     3. Deploy NodeJs Backend service

    kubectl -n default create deploy node-app --image siddharth67/node-service:v1 
    kubectl -n default expose deploy node-app --name node-service --port 5000
    kubectl get all

<img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/154779140-02bfdfed-5198-4831-ac3a-b4e7adbeabcc.png">

**Note # Node service in the code should point to correct url**
<img width="1057" alt="image" src="https://user-images.githubusercontent.com/75510135/154779216-9565f3bc-d4d7-4f29-baf1-1230f865f672.png">

# commit the code 
     git status
     git add .
     git commit -m 'K8s integration'
     git push

# Validate the pipeline
![image](https://user-images.githubusercontent.com/75510135/154779621-c671a1fe-ec92-4ad6-8028-8b405ea7c705.png)

<img width="636" alt="image" src="https://user-images.githubusercontent.com/75510135/154779643-8d55a938-5ff1-41da-919a-e525a79238a6.png">

- Notedown the service name
    NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
    service/devsecops-svc   NodePort    10.98.106.125    <none>        8080:31031/TCP   7m8s

- check frontend & backend endpoints
  BE =>  http://142.93.213.194:31031/compare/51
  FE =>  http://142.93.213.194:31031/increment/77
