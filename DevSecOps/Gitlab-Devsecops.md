<details>
<summary>Introduction-SonarCloud</summary>
<br>

  <img width="1068" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/3f58a6bb-0393-4142-beef-587c51d7c26f">

  <img width="1035" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/ad80cd3e-38c4-4636-bc18-8af77ea6a05e">

  <img width="588" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/065d7997-e936-4f75-b795-664fda850b13">
  
</details>

<details>
<summary>SonarCloud Integration</summary>
<br>

  - Login @SQ
  <img width="984" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/4c0642a6-9fde-4e52-a6a6-9712cc838af3">

  <img width="619" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/baf5ae88-ed86-4656-8b40-aa5a712fb427">
  
  ```
  stages:
    - runSAST

  run-sast-job:
      stage: runSAST
      image: maven:3.8.5-openjdk-11-slim
      script: |
        mvn verify package sonar:sonar -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.organization=gitlabdevsecopsintegration - Dsonar.projectKey=gitlabdevsecopsintegration -Dsonar.login=token01 
  ```
   - create organization
   <img width="926" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/f31153cc-8031-4f61-80ec-bc9f9f2380e3">

   <img width="926" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/77df71c3-d17d-48c0-ad89-d2b2263924ec">

   <img width="926" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/9b320be9-e39b-47a2-bdb3-b2f6889c0ce6">

   <img width="926" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/8202ad37-f76e-4c2e-b47e-d6a4c93dbef7">

   - add project key
     <img width="926" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/ff908f88-6e62-4cf6-b08d-676c89f1b740">
    - create security token
     <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/976522d6-b1ce-4ebe-941a-99c2bc5898fc">

     - here is final command to start the scan
     <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/1a5c46ad-6609-455d-b540-bd3ad5caaa49">

     - validate
     <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/5ef75747-1ab1-4472-a3c5-360a5e6fb256">

     <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/9dd77895-fd66-4055-9b40-c342e334d649">

    - create custom Quality Gate
    
    ```
    1) Create Custom Quality Gate in SonarCloud and Add conditions to the Quality Gate
    2) Assign this Quality Gate to the Project
    3) Add script in .gitlab-ci.yml file to enable quality gate check (Note: This will fail your build in case Quality Gate fails)
    
    sleep 5
    apt-get update
    apt-get -y install curl jq 
    quality_status=$(curl -s -u 14ad4797c02810a818f21384add02744d3f9e34d: https://sonarcloud.io/api/qualitygates/project_status?projectKey=gitLabdevsecopsintegration | jq -r '.projectStatus.status')
    echo "SonarCloud Analysis Status is $quality_status"; 
    if [[ $quality_status == "ERROR" ]] ; then exit 1;fi
    
    
    -----------Sample JSON Response from SonarCloud or SonarQube Quality Gate API---------------------
    
    {
    	"projectStatus": {
    		"status": "ERROR",
    		"conditions": [
    			{
    				"status": "ERROR",
    				"metricKey": "coverage",
    				"comparator": "LT",
    				"errorThreshold": "90",
    				"actualValue": "0.0"
    			}
    		],
    		"periods": [],
    		"ignoredConditions": false
    	}
    }
    ```


    ```
    stages:
    - runSAST

    run-sast-job:
        stage: runSAST
        image: maven:3.8.5-openjdk-11-slim
        script: |
          apt-get update
          apt-get -y install curl jq
          mvn verify package sonar:sonar -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.organization=gitlabdevsecopsintegrtion -Dsonar.projectKey=gitLabdevsecopsintegration -Dsonar.login=14ad4797c02810a818f21384add02744d3f9e34d
          sleep 5 
          quality_status=$(curl -s -u 14ad4797c02810a818f21384add02744d3f9e34d: https://sonarcloud.io/api/qualitygates/project_status?projectKey=gitLabdevsecopsintegration | jq -r '.projectStatus.status')
          echo "SonarCloud Analysis Status is $quality_status"; 
          if [[ $quality_status == "ERROR" ]] ; then exit 1;fi
    ```

    <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/c8407952-8b96-413e-8d9f-069a71d20311">

    
</details>

<details>
<summary>Unit Test-Jococo</summary>
<br>

  <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/7cf48b23-6826-44d0-a9d3-896bd1b20b2f">

  - Test
  <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/7edfbaf0-30e9-47dd-9f80-b26b76529628">

  - JUnit plugin
  <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/e967ea95-d851-4de4-aafb-f0214f6c23b3">

  - Jococo plugin & report 
 <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/20c9d2f3-be3f-45b7-aed9-2501e79bd185">
 <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/e54e0584-3b11-44f8-9221-4a60f41b97fa">

  - Maven verify goal

    ```
    stages:
    - runSAST

    run-sast-job:
        stage: runSAST
        image: maven:3.8.5-openjdk-11-slim
        script: |
          mvn verify package sonar:sonar -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.organization=gitlabdevsecopsintegration -Dsonar.projectKey=gitlabdevsecopsintegration -Dsonar.login=2fda8f4a1af600afbede42c54c868083d8e34c01 
    ```

    <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/f9be07f1-a0b2-4522-a77a-ef49fe8a83e1">
    - validate
    <img width="1054" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/2ad19c09-03b1-4642-84e5-c14f6f444780">
    
    
</details>


<details>
<summary>GitLab- Snyk</summary>
<br>

  <img width="963" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/dd1d2789-161c-4671-a34c-aeb2da6456d7">

  - sign up
 <img width="994" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/16177327-5df1-4a7c-9176-d2842d139b3c">

 <img width="994" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/8efaeec1-0f50-4fd2-ad3e-d7683738c63a">


 Steps to integrate Snyk using .gitlab-ci.yml file:

1) Add Snyk Plugin to Pom.xml
2) Define Snyk Token as an environment Variable on the runner machine
3) Add code changes to .gitlab-ci.yml file

1) Add Snyk Plugin to Pom.xml
 <img width="732" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/08ff6078-3851-4a16-8ead-74ed0d379daa">

 2) Define Snyk Token as an environment Variable on the runner machine
 <img width="1052" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/04fc0696-71f1-45a9-b19b-04e0f30f506f">

 3) Add code changes to .gitlab-ci.yml file
  <img width="1052" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/0cf3a4fc-2454-49f9-882d-f001f1340835">

  - Validate
  <img width="1052" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/4e97dba2-c79c-483f-a428-9925ba5c6d56">

  
</details>


<details>
<summary>GitLab- DAST - OWASP-ZAP</summary>
<br>

   <img width="1052" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/dcf7c321-8c49-4640-8999-97ddf7ceb163">
    
   <img width="1052" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/7b7bd7b0-e85d-4872-94ab-0619fb3a20c4">

   - validate
   <img width="1052" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/e2c7b594-99b9-4643-9a92-11c9b269f40e">

   - Report
   <img width="1067" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/06ef7197-36f9-48ee-a77b-f6fc74ce191f">
     
</details>



<details>
<summary>Inbuilt-GitLab- SAST - DAST </summary>
<br>

  - https://docs.gitlab.com/ee/user/application_security/sast/
  - https://docs.gitlab.com/ee/user/application_security/dast/
    
   <img width="1067" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/a7349f63-4e80-4c76-83bd-69796fc52d69">

   <img width="1067" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/773d1692-39de-42e7-b46b-801fad872c1c">

  ```
     include:
  - template: Security/SAST.gitlab-ci.yml
  - template: DAST.gitlab-ci.yml

variables:
  SAST_EXPERIMENTAL_FEATURES: "true"
  DAST_WEBSITE: http://www.example.com
  DAST_FULL_SCAN_ENABLED: "true" 
  DAST_BROWSER_SCAN: "true"

stages:
  - test
  - runSASTScanUsingSonarCloud
  - runSCAScanUsingSnyk
  - runDASTScanUsingZAP
  - dast

run-sast-job:
    stage: runSASTScanUsingSonarCloud
    image: maven:3.8.5-openjdk-11-slim
    script: |
      mvn verify package sonar:sonar -Dsonar.host.url=https://sonarcloud.io/ -Dsonar.organization=gitlabdevsecopsintegrationkey -Dsonar.projectKey=gitlabdevsecopsintegrationkey -Dsonar.login=9ff892826b54980437f4fb0fbc72f4049ec97585 

run-sca-job:
    stage: runSCAScanUsingSnyk
    image: maven:3.8.5-openjdk-11-slim
    script: |
      SNYK_TOKEN='2f4afa39-c493-4c6d-b34e-080c1a8f9014'
      export SNYK_TOKEN
      mvn snyk:test -fn 
      
run-dast-job:
    stage: runDASTScanUsingZAP
    image: maven:3.8.5-openjdk-11-slim
    script: |
      apt-get update
      apt-get -y install wget
      wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2.11.1_Linux.tar.gz
      mkdir zap
      tar -xvf ZAP_2.11.1_Linux.tar.gz
      cd ZAP_2.11.1
      ./zap.sh -cmd -quickurl https://www.example.com -quickprogress -quickout ../zap_report.html 
    artifacts:
      paths:
        - zap_report.html
```
    


  - validate
  <img width="1067" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/fda0714c-3bfd-40eb-be97-42b163214c1f">

  - sast
  <img width="1051" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/4d74c325-83f9-4068-be2a-c00afe701a97">
  <img width="1051" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/7bcfed97-c408-43dd-9c86-ce5b5d3ea634">
  <img width="1051" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/bca4ea16-0871-4bfb-9797-77e83df8c709">

  <img width="1066" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/ecf23d35-9dee-485b-bee1-a2336258f736">
    
  - dast
  <img width="1051" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/e9384574-dabd-4baa-a866-16c7da18a9fb">
  <img width="1051" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/2c2cd454-cf5b-430e-9c85-33f6c26349df">
  <img width="1051" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/5f516e3c-8a00-4f56-ae5e-39bdc6840694">

  <img width="1066" alt="image" src="https://github.com/rupeshpanwar/quick-bite/assets/75510135/b6c8d2bc-7037-4129-aacd-9aabc9861a1f">

       
</details>
