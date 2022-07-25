<img width="964" alt="image" src="https://user-images.githubusercontent.com/75510135/130418531-cb5ed8c8-8f9e-492e-a954-1600dcd5ce75.png">
<img width="962" alt="image" src="https://user-images.githubusercontent.com/75510135/130418681-d8bb87f8-9d71-421f-8af8-d2be357dfee8.png">
<img width="958" alt="image" src="https://user-images.githubusercontent.com/75510135/130418929-452f76c0-fe78-4f83-9ee6-cede4acfc15a.png">
<img width="331" alt="image" src="https://user-images.githubusercontent.com/75510135/130419031-711ddb4e-b996-4808-8097-942f2c644af7.png">

                      version: '2'
                      services:
                        jenkins:
                          image: jenkins/jenkins:lts
                          ports:
                            - "8080:8080"
                            - "50000:50000"
                          networks:
                            - jenkins
                          volumes:
                            - /var/jenkins_home:/var/jenkins_home
                            - /var/run/docker.sock:/var/run/docker.sock
                        postgres:
                          image: postgres:9.6
                          networks:
                            - jenkins
                          environment:
                            POSTGRES_USER: sonar
                            POSTGRES_PASSWORD: sonarpasswd
                          volumes:
                            - /var/postgres-data:/var/lib/postgresql/data
                        sonarqube:
                          image: sonarqube:lts
                          ports:
                            - "9000:9000"
                            - "9092:9092"
                          networks:
                            - jenkins
                          environment:
                            SONARQUBE_JDBC_USERNAME: sonar
                            SONARQUBE_JDBC_PASSWORD: sonarpasswd
                            SONARQUBE_JDBC_URL: "jdbc:postgresql://postgres:5432/sonar"
                          depends_on: 
                            - postgres

                      networks:
                        jenkins:
  
 - download & install docker-compose
 - chmod +x /usr/local/bin/docker-compose

- docker-compose up
- sonarqube default admin/admin
# Push the code to SonarQube
<img width="1214" alt="image" src="https://user-images.githubusercontent.com/75510135/130536091-ccee4a5a-0b79-4c48-947c-a483f4558113.png">
- generate a tocken at SOnarqube
<img width="458" alt="image" src="https://user-images.githubusercontent.com/75510135/130536144-45d480d5-f6ea-4bc0-a9a0-2e3407bcee80.png">
<img width="1214" alt="image" src="https://user-images.githubusercontent.com/75510135/130536271-3bfa9623-de1e-464a-b4c0-02418a77ae4d.png">
<img width="1214" alt="image" src="https://user-images.githubusercontent.com/75510135/130536372-ac0b293e-07a7-4dfe-b8e1-64b1bbbcdc94.png">
                          node {
                              def myGradleContainer = docker.image('gradle:jdk8-alpine')
                              myGradleContainer.pull()

                              stage('prep') {
                                  git url: 'https://github.com/wardviaene/gs-gradle.git'
                              }

                              stage('build') {
                                myGradleContainer.inside("-v ${env.HOME}/.gradle:/home/gradle/.gradle") {
                                  sh 'cd complete && /opt/gradle/bin/gradle build'
                                }
                              }

                              stage('sonar-scanner') {
                                def sonarqubeScannerHome = tool name: 'sonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                                withCredentials([string(credentialsId: 'sonar', variable: 'sonarLogin')]) {
                                  sh "${sonarqubeScannerHome}/bin/sonar-scanner -e -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=${sonarLogin} -Dsonar.projectName=gs-gradle -Dsonar.projectVersion=${env.BUILD_NUMBER} -Dsonar.projectKey=GS -Dsonar.sources=complete/src/main/ -Dsonar.tests=complete/src/test/ -Dsonar.language=java -Dsonar.java.binaries=."
                                }
                              }
                          }
                          
  
