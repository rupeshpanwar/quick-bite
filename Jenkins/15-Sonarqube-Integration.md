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
  
 
