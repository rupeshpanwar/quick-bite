

<img width="798" alt="image" src="https://user-images.githubusercontent.com/75510135/154292546-b4b26cb6-04f0-4739-a981-a22f0a19bf3e.png">
<img width="809" alt="image" src="https://user-images.githubusercontent.com/75510135/154293287-9e9e9813-e789-4e46-b0b8-aedaa9c45d95.png">
```
pipeline {
    agent any

    stages {
        stage('git version') {
            steps {
                sh "git version"
            }
        }
         stage('maven version') {
            steps {
                sh "mvn -v"
            }
        }
        stage('docker version') {
            steps {
                sh "docker -v"
            }
        }
        stage('k8s version') {
            steps {
                sh "kubectl version --short"
            }
        }
    }
}



<img width="1123" alt="image" src="https://user-images.githubusercontent.com/75510135/154294328-e973d385-1b78-48d7-a207-fe468e068e50.png">
<img width="1407" alt="image" src="https://user-images.githubusercontent.com/75510135/154294995-10452bac-1efb-47d8-a680-eb5e4bd26fbc.png">

## for K8s , we need to create creds 
### kube config file
- cat /root/.kube/config => copy into a file 
- create creds in jenkins , upload kubeconfig file


<img width="853" alt="image" src="https://user-images.githubusercontent.com/75510135/154295326-734c4cb9-e646-4631-89df-1e36cc0b87d5.png">

- now make changes in the jenkinsfile
```
pipeline {
  agent any

  stages {

    stage('git version') {
      steps {
        sh "git version"
      }
    }

    stage('maven version') {
      steps {
        sh "mvn -v"
      }
    }

    stage('docker version') {
      steps {
        sh "docker -v"
      }
    }

    stage('kubernetes version') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig']) {
          sh "kubectl version --short"
        }
      }
    }
  }
}


# 
<img width="1098" alt="image" src="https://user-images.githubusercontent.com/75510135/154295824-3d7b0a06-977d-4b07-b9f2-4076ef078974.png">

# Use Case
![image](https://user-images.githubusercontent.com/75510135/154379940-aa6facec-60a0-4de7-9ffb-c10eab28bdfb.png)

![image](https://user-images.githubusercontent.com/75510135/154380807-fcdbf492-441d-42e1-8410-1cf63a80351e.png)


