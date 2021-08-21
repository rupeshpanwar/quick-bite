<img width="854" alt="image" src="https://user-images.githubusercontent.com/75510135/130318275-db45fcf9-dc26-487e-a4f4-1f340df62940.png">

<img width="819" alt="image" src="https://user-images.githubusercontent.com/75510135/130318295-9e5ceb52-7fca-4ba3-9c73-fd4b21a6c3b6.png">

<img width="476" alt="image" src="https://user-images.githubusercontent.com/75510135/130318306-8c5e973b-6eb2-4952-90d6-4b102144b920.png">

                                  node {
                                     def commit_id
                                     stage('Preparation') {
                                       checkout scm
                                       sh "git rev-parse --short HEAD > .git/commit-id"
                                       commit_id = readFile('.git/commit-id').trim()
                                     }
                                     stage('Initialize'){
                                          def dockerHome = tool 'docker'
                                          env.PATH = "${dockerHome}/bin:${env.PATH}"
                                      }
                                     stage('test') {
                                       def myTestContainer = docker.image('node:alpine')
                                       myTestContainer.pull()
                                       myTestContainer.inside {
                                         sh 'npm install'
                                         sh 'npm test'
                                       }
                                     }
                                     stage('test with a DB') {
                                       def mysql = docker.image('mysql').run("-e MYSQL_ALLOW_EMPTY_PASSWORD=yes") 
                                       def myTestContainer = docker.image('node:alpine')
                                       myTestContainer.pull()
                                       myTestContainer.inside("--link ${mysql.id}:mysql") { // using linking, mysql will be available at host: mysql, port: 3306
                                            sh 'npm install' 
                                            sh 'npm test'                     
                                       }                                   
                                       mysql.stop()
                                     }                                     
                                     stage('docker build/push') {            
                                       docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                                         def app = docker.build("rupeshpanwar/docker-nodejs-demo:${commit_id}", '.').push()
                                       }                                     
                                     }                                       
                                  }                                          
