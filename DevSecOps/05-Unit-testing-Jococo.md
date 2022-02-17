![image](https://user-images.githubusercontent.com/75510135/154492877-8867dd93-1174-403e-b35f-417caf69f5b6.png)

- installed plugin
![image](https://user-images.githubusercontent.com/75510135/154494654-be459ff5-4dec-4d5d-b982-a7f56faf9e93.png)

- unit test Jenkinsfile
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
        }   //stage ending Unit test
    }
}
```


![image](https://user-images.githubusercontent.com/75510135/154495834-5883cac3-221a-4b3f-8fdb-f8ce20e4b39a.png)

- add plugin in pom.xml
```
<!--                   Jacoco Plugin                   -->
			<plugin>
			<groupId>org.jacoco</groupId>
			<artifactId>jacoco-maven-plugin</artifactId>
			<version>0.8.5</version>
			<executions>
				<execution>
					<goals>
						<goal>prepare-agent</goal>
					</goals>
				</execution>
				<execution>
					<id>report</id>
					<phase>test</phase>
					<goals>
						<goal>report</goal>
					</goals>
				</execution>
			</executions>
			</plugin>
  ```
  
  - add "post => akways" section to perform jococo testing under Unit test stage
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
    }
}
  ```


![image](https://user-images.githubusercontent.com/75510135/154498020-f46f8146-73d8-4b76-9bd1-8d5f01d684ca.png)

![image](https://user-images.githubusercontent.com/75510135/154498180-9603661f-82b7-4f7b-8299-18a796dd3b3f.png)

![image](https://user-images.githubusercontent.com/75510135/154498253-414b2114-5fe8-48b9-94b4-99159d5e8558.png)


![image](https://user-images.githubusercontent.com/75510135/154498305-c45f93db-953c-48da-9075-19544f381ac3.png)

![image](https://user-images.githubusercontent.com/75510135/154498477-039952de-5f73-4d46-b14d-8c971fad43df.png)

![image](https://user-images.githubusercontent.com/75510135/154498788-e7893be7-367b-49d0-98ad-27450615f217.png)




