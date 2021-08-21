<img width="656" alt="image" src="https://user-images.githubusercontent.com/75510135/130308433-b355ca85-637c-4806-9b0c-e5c1bc10eec2.png">
<img width="952" alt="image" src="https://user-images.githubusercontent.com/75510135/130308446-7ceb8632-3a27-4b1b-b827-8b9f1dad4331.png">
<img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/130308504-09212887-f877-436d-8ea6-971ee621cc97.png">
<img width="943" alt="image" src="https://user-images.githubusercontent.com/75510135/130308535-a59d8457-f04a-4d05-b874-21b374cbe23a.png">
<img width="981" alt="image" src="https://user-images.githubusercontent.com/75510135/130308599-d06c42c0-31eb-4252-8a3f-9a69c754a552.png">
<img width="900" alt="image" src="https://user-images.githubusercontent.com/75510135/130308705-0500ccc3-231e-4308-8c5d-b088bbcc2b8c.png">

# Jenkins pipeline with NodeJs / Docker

- jenkinsfile
                    node {
                       def commit_id
                       stage('Preparation') {
                         checkout scm
                         sh "git rev-parse --short HEAD > .git/commit-id"                        
                         commit_id = readFile('.git/commit-id').trim()
                       }
                       stage('test') {
                         nodejs(nodeJSInstallationName: 'nodejs') {
                           sh 'npm install --only=dev'
                           sh 'npm test'
                         }
                       }
                       stage('docker build/push') {
                         docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                           def app = docker.build("rupeshpanwar/docker-nodejs-demo:${commit_id}", '.').push()
                         }
                       }
                    }

- create pipeline project , click on New Item , supply project name , select pipeline, click Ok
<img width="1145" alt="image" src="https://user-images.githubusercontent.com/75510135/130309020-95e15343-42df-4491-85c9-579dac0b00c6.png">
- Under pipeline section, supply git url, branch name, jenkinsfile path then click on Save
<img width="1145" alt="image" src="https://user-images.githubusercontent.com/75510135/130309104-e277f116-894c-4f92-a2fe-5eb9bdcf411f.png">

<img width="1145" alt="image" src="https://user-images.githubusercontent.com/75510135/130309125-fb73a8a2-27ff-448b-8768-61bacd6e9298.png">

- click on Build now
- all the stages will appear 
<img width="1145" alt="image" src="https://user-images.githubusercontent.com/75510135/130309267-d3427a32-bc72-49d7-8c0c-d5fd009ab896.png">



