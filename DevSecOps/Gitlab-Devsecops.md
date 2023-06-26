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
<summary>Introduction</summary>
<br>
  
</details>
