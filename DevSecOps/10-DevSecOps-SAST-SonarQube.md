**Steps**
- https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-jenkins/

<details>
<summary>1. Introduction - SAST - Statis Analysis Security Testing</summary>

  <br>
  
![image](https://user-images.githubusercontent.com/75510135/154796629-01ff6d05-9b2a-426a-9d0e-8cbc6973c786.png)

</details>




<details>
<summary>2. Run Sonarqube as a container</summary>
<br>

       docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:8.9.1-community
       docker logs sonarqube -f
       docker ps -a | grep -i sonar
  
  <img width="1409" alt="image" src="https://user-images.githubusercontent.com/75510135/154797477-e82bec38-8506-48d9-a76a-3dd1763e0736.png">
  
  
  - access Sonarqube in the browser => public-ip-of-vm:9000
  **note default creds => admin/admin**
  
  ![image](https://user-images.githubusercontent.com/75510135/154797522-db341a33-530a-4da7-966f-4b970d7c15cb.png)


</details>

<details>
<summary>3. @Sonarqube , Add a project</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/154797590-8406506c-6d39-438d-a5db-c6682c15a522.png)

  - select Manually
  ![image](https://user-images.githubusercontent.com/75510135/154797637-7c8b9600-1e2c-4c71-b742-cec79ad6080b.png)

  ![image](https://user-images.githubusercontent.com/75510135/154797670-af416401-373c-4d08-9085-e199b47a59a0.png)

  - click on set up
  - then enter a name here to generate token 
  
  ```
  Analyze your project

    We initialized your project on SonarQube, now it's up to you to launch analyses!
    1
    Provide a token
    jenkins-pipeline: here-is-token-number-just-copy 
    The token is used to identify you when an analysis is performed. If it has been compromised, you can revoke it at any point of time in your user account.
  ```
  
  - click on continue
  ![image](https://user-images.githubusercontent.com/75510135/154797904-ee888fc0-c3f5-40c1-bc65-42d56cd159be.png)

  - select Maven application in our case
  ![image](https://user-images.githubusercontent.com/75510135/154797936-9549d387-a3c6-4af8-9418-a95262e01854.png)

  - copy the snipped shown in the window , that would be required to create stage in Jenkinsfile to run SAST via pipeline
  ```
  mvn sonar:sonar \
  -Dsonar.projectKey=numeric-application \
  -Dsonar.host.url=http://142.93.213.194:9000 \
  -Dsonar.login=token-number-generated-in-previous-screen
  ```
</details>

<details>
<summary>4. @Jenkinsfile, add stage to run Sonarqube</summary>
<br>
   
  ```
        }   // stage ending PIT mutations test

      stage('SonarQube - SAST') {
          steps {
            sh "mvn sonar:sonar -Dsonar.projectKey=numeric-application -Dsonar.host.url=http://142.93.213.194:9000 -Dsonar.login="
          }
      } // stage ending SonarQube - SAST
  ```
  
  ![image](https://user-images.githubusercontent.com/75510135/154798411-0b6e4f69-caa8-41f8-bb64-cc83ef4fbbad.png)

  
</details>


<details>
<summary>5. @Sonarqube, validate the result</summary>
<br>
    
  ![image](https://user-images.githubusercontent.com/75510135/154798432-402a58b4-c8b6-4271-a12b-0934a9735897.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/154798490-d6fcf3c2-fce3-4a76-92c4-aa6d6be6bd23.png)

</details>



<details>
<summary>6. @Sonarqube, create custom quality gate condition</summary>
<br>

 - Click on Quality gate  
 ![image](https://user-images.githubusercontent.com/75510135/154798551-750a212a-833a-4eea-b8db-054759703996.png)

  - click on Create, provide a name
  
  ![image](https://user-images.githubusercontent.com/75510135/154798612-313b88cd-72a7-4472-a3c7-6383e5c9d64b.png)

  - click on Save as Default on right upper corner
  
  ![image](https://user-images.githubusercontent.com/75510135/154798666-bda07f67-acf8-40cb-93bc-00320e4b9d4e.png)

  ![image](https://user-images.githubusercontent.com/75510135/154798677-4f797f2e-a552-40ec-97ad-eb40b91cdbb7.png)

  - then click on Add Conditions
  
  ![image](https://user-images.githubusercontent.com/75510135/154798693-e2b34073-1be1-4ec1-98a7-6e6406772170.png)

  ![image](https://user-images.githubusercontent.com/75510135/154798735-b42a1ef0-8317-4023-b196-483016f7947a.png)

  ![image](https://user-images.githubusercontent.com/75510135/154798746-046cb445-318d-4974-8204-d9c3f09da6cb.png)

  - now this time pipeline should fail due to above applied gate conditions, rerun the build and validate the result

  ![image](https://user-images.githubusercontent.com/75510135/154798820-ed6bb06f-cbdb-4b20-83cb-6dfd632087ee.png)

  ![image](https://user-images.githubusercontent.com/75510135/154798846-5a5fc822-77ee-4545-884c-472dfcb2308f.png)

  **note # the result from Sonarqube didn't impact pipeline , its all green, though QualityGate is showing failed**
  
</details>


<details>
<summary>7. Sonarqube scanner - Pause pipeline until QGate is computed </summary>
<br>
  
  
1. @Jenkins, configure Sonarqube server
2. Add a token, generated at Sonarqube, in order to authenticate from Jenkins
3. @Sonarqube, Configure a webhook  
4. @Jenkinsfile , Make changes in SonarQube stage
5. Rerun the build and valid the Sonarqube result n pipeline 
  
  
# 1. @Jenkins, configure Sonarqube server
  - check if SonarQube scanner plugin is installed
  ![image](https://user-images.githubusercontent.com/75510135/154799443-855dead7-14dc-4012-86d7-8b6692366c77.png)

   - https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-jenkins/
  
  ![image](https://user-images.githubusercontent.com/75510135/154799506-b1f7622a-a0d4-4ecc-9598-a6d17178b5e2.png)
  
  - provide SonarQube url to reach by Jenkins
  
  ![image](https://user-images.githubusercontent.com/75510135/154799579-9013fb6f-4ffd-4cc8-9e5b-e098ad51a660.png)

# 2. Add a token, generated at Sonarqube, in order to authenticate from Jenkins
  
  - @Sonarqube , Admin => Security => provide name for token then click generate , copy the token
  
  ![image](https://user-images.githubusercontent.com/75510135/154799642-bb5fdc29-0c8c-4e16-b347-0b6572741b9f.png)

  - @Jenkins, create creds using this token
  
  ![image](https://user-images.githubusercontent.com/75510135/154799710-788cfaf7-1042-49a5-838f-1b521702331e.png)

  ![image](https://user-images.githubusercontent.com/75510135/154799726-9e490579-34d4-433b-a02e-7b4d46695b3f.png)

 # 3. @Sonarqube, Configure a webhook  
  
  - click on Administration , then configuration , then click on webhooks
  
  ![image](https://user-images.githubusercontent.com/75510135/154799820-5b15477d-e894-4896-9ff5-1a683c4aa9c6.png)

  - click on create
  
  ![image](https://user-images.githubusercontent.com/75510135/154799831-67e10b90-733c-47a6-bf15-eb4b11cdf0d3.png)

  - provide Jenkins weburl here and append /sonarqube-webhook/ , then click on Create
  
  ![image](https://user-images.githubusercontent.com/75510135/154799888-d3b091a7-956e-44c7-a2f4-924582d53010.png)

  ![image](https://user-images.githubusercontent.com/75510135/154799910-a85d3cb6-2b73-4950-8b13-647357861922.png)

  # 4. @Jenkinsfile , Make changes in SonarQube stage
  
  ```
        stage('SonarQube - SAST') {
          steps {
                withSonarQubeEnv('SonarQube') {
            sh "mvn sonar:sonar -Dsonar.projectKey=numeric-application -Dsonar.host.url=http://142.93.213.194:9000"
                }
                timeout(time: 2, unit: 'MINUTES') {
          script {
            waitForQualityGate abortPipeline: true
          }
        }
          }
      } // stage ending SonarQube - SAST
 ```
  
  - this time build got failed
  
  ![image](https://user-images.githubusercontent.com/75510135/154800112-5651d06c-26f0-452a-b17d-35fbefdc391a.png)

  -  find the issue of code highlighted by code smell n fix  it
  
  ![image](https://user-images.githubusercontent.com/75510135/154800159-38ac3243-2667-44b5-8ee8-5dfd21fdf730.png)

  <img width="894" alt="image" src="https://user-images.githubusercontent.com/75510135/154800193-25b9a33a-b78b-46a0-bbcc-d07c1412f56e.png">

  - rerun the build
  
  ![image](https://user-images.githubusercontent.com/75510135/154800264-683de958-6986-4eb8-85bf-a949e29c0053.png)

  
  
</details>






