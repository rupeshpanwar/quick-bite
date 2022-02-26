- https://plugins.jenkins.io/slack/
- https://slack.com/
- https://www.jenkins.io/doc/book/pipeline/shared-libraries/



<details>
<summary>Introduction</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/155826751-9bcf7287-7447-41dd-abea-a23ace8e5c36.png)
  
  <img width="780" alt="image" src="https://user-images.githubusercontent.com/75510135/155827890-87589afc-0537-4425-92c2-deee24fe8309.png">

</details>


<details>
<summary>Setup and Config</summary>
<br>

  - plugin
  
  <img width="994" alt="image" src="https://user-images.githubusercontent.com/75510135/155827880-b7129816-8003-4692-8fbd-31a8b1c5d9b2.png">

  - Create an account 
  
  <img width="1085" alt="image" src="https://user-images.githubusercontent.com/75510135/155827908-c5213fd6-d183-41fd-bbd7-910fa46fc3a7.png">

  <img width="1091" alt="image" src="https://user-images.githubusercontent.com/75510135/155827915-adf677e1-1f85-4613-ad49-991a5db553a2.png">

  <img width="1096" alt="image" src="https://user-images.githubusercontent.com/75510135/155828000-e59fb33a-6cdf-4276-9a09-1980b2f9d35b.png">

  - create a workspace
  
  <img width="1056" alt="image" src="https://user-images.githubusercontent.com/75510135/155828055-fd9e30b6-2b83-450f-8dac-843fe7bd3bf0.png">

  <img width="1032" alt="image" src="https://user-images.githubusercontent.com/75510135/155828079-6b9f0150-95dd-4af2-95d7-236ac9498db8.png">

  - Create a new channel
  
  <img width="438" alt="image" src="https://user-images.githubusercontent.com/75510135/155828102-719d8786-c7d6-41a0-9628-a92925997ded.png">

  <img width="804" alt="image" src="https://user-images.githubusercontent.com/75510135/155828112-a71a4231-0294-44df-8ad2-f050f5ca0950.png">

  <img width="829" alt="image" src="https://user-images.githubusercontent.com/75510135/155828126-469d00d0-75ba-4699-a5e5-aabee7dd498f.png">

  <img width="937" alt="image" src="https://user-images.githubusercontent.com/75510135/155828138-54a1fd1a-44e5-4881-bcc6-9e14581526f6.png">

  - Manage App (to allow jenkins notification)
  
  <img width="456" alt="image" src="https://user-images.githubusercontent.com/75510135/155828234-11b81e5a-ddc1-4408-ab4c-eb1de0daef9f.png">

  - click on settings => Manage Apps => Search for Jenkins => it will open in new tab
  
  <img width="894" alt="image" src="https://user-images.githubusercontent.com/75510135/155828264-a8d47f08-837d-459e-aae6-12cb7ee9c9b1.png">

  - click on Add to Slack
  
  <img width="1048" alt="image" src="https://user-images.githubusercontent.com/75510135/155828283-7aee9ad5-ffdb-46bb-ace2-426b05b6050b.png">

  - Select a channel
  
  <img width="1049" alt="image" src="https://user-images.githubusercontent.com/75510135/155828300-e8526ca1-1aff-4bf0-8d62-65c94ab397ee.png">

  <img width="1044" alt="image" src="https://user-images.githubusercontent.com/75510135/155828307-b9264b30-efa9-4186-8d61-4a650821daaa.png">

  - it will open instruction page
  
  <img width="1059" alt="image" src="https://user-images.githubusercontent.com/75510135/155828319-e7d720b4-ff56-44b0-85b7-40b46a846dff.png">

  <img width="930" alt="image" src="https://user-images.githubusercontent.com/75510135/155828331-310673e6-2513-47c7-9240-5a0881fcffed.png">

  <img width="824" alt="image" src="https://user-images.githubusercontent.com/75510135/155828337-62b96b14-7782-40ba-91a6-133c63d4cd6c.png">

  <img width="967" alt="image" src="https://user-images.githubusercontent.com/75510135/155828342-07598f4b-2e02-4ea0-b9f4-0b712798805e.png">

  <img width="963" alt="image" src="https://user-images.githubusercontent.com/75510135/155828349-53e04dc6-bd0a-4d35-9a74-74da17048acd.png">

  <img width="967" alt="image" src="https://user-images.githubusercontent.com/75510135/155828356-a10a6a57-1a6f-4102-aa51-14ed51b30b58.png">

  - Configuration @ Jenkins
  
  <img width="1084" alt="image" src="https://user-images.githubusercontent.com/75510135/155828481-e5515db8-5642-4acd-8bc1-8481ae2724b5.png">

  - look above step 3 , to fill-in details here
  
    <img width="793" alt="image" src="https://user-images.githubusercontent.com/75510135/155828548-df3e1095-ffb6-4edf-9910-7d9a54c043ac.png">

    <img width="970" alt="image" src="https://user-images.githubusercontent.com/75510135/155828585-650c9a36-8759-4da8-a622-cfdadec4ab1b.png">

    <img width="1089" alt="image" src="https://user-images.githubusercontent.com/75510135/155828623-421b23df-55a0-4686-8b48-0e80a27f3d12.png">

  
    <img width="949" alt="image" src="https://user-images.githubusercontent.com/75510135/155828632-6ce45695-b1b6-45b8-8222-b4d2ef35bdd5.png">

  
  
</details>


<details>
<summary>@Jenkins, Create shared library</summary>
<br>

  <img width="808" alt="image" src="https://user-images.githubusercontent.com/75510135/155828766-4cfc4276-4003-40ab-bbff-4aec8e9dbccb.png">

  - here default version - main => github repo branch name
  
  <img width="814" alt="image" src="https://user-images.githubusercontent.com/75510135/155828812-2c9b1f94-b1d3-48e6-8871-fa52ccfb9013.png">

  <img width="1067" alt="image" src="https://user-images.githubusercontent.com/75510135/155828870-da37f785-683d-4b26-ac7f-fdc4ceff858f.png">

  - Add a groovy script in @Project root dir / vars / sendNotification.groovy
  
  ```
      def call(String buildStatus = 'STARTED') {
       buildStatus = buildStatus ?: 'SUCCESS'

       def color

       if (buildStatus == 'SUCCESS') {
        color = '#47ec05'
       } else if (buildStatus == 'UNSTABLE') {
        color = '#d5ee0d'
       } else {
        color = '#ec2805'
       }

       def msg = "${buildStatus}: `${env.JOB_NAME}` #${env.BUILD_NUMBER}:\n${env.BUILD_URL}"

       slackSend(color: color, message: msg)
      }
  ```
  
  - Add a new step in jenkinsfile
  
  ```
  - this is added at top of Jenkinsfile
  @Library('slack') _
  
  - this is one testing stage
  
   stages {
    stage('Testing Slack') {
      steps {
        sh 'exit 1'
      }
    }

  ```
  
  ```
  
   // Use sendNotifications.groovy from shared library and provide current build result as parameter    
      sendNotification currentBuild.result
    }
  ```
  
  - sample pipeline
  
  ```
  @Library('slack') _

pipeline {
  agent {
          node {
              label "docker"
              customWorkspace "/tmp/deployment"
            }
        }

  environment {
    deploymentName = "devsecops"
    containerName = "devsecops-container"
    serviceName = "devsecops-svc"
    imageName = "rupeshpanwar/numeric-app:${GIT_COMMIT}"
    applicationURL = "http://142.93.213.194"
    applicationURI = "compare/51"
  }
  
   stages {
    stage('Testing Slack') {
      steps {
        sh 'exit 0'
      }
    }
     post {
          always {
        
             sendNotification currentBuild.result
          }
     }
   }
}
  ```
  
</details>



<details>
<summary>Validate</summary>
<br>
 - Stage is successful
  <img width="1064" alt="image" src="https://user-images.githubusercontent.com/75510135/155829599-52de6edd-c118-4328-aba4-59d076b754f3.png">

  <img width="1072" alt="image" src="https://user-images.githubusercontent.com/75510135/155829608-0a899864-3fd7-4fb5-8ade-788a45712d9c.png">

  - Stage is failed
  
  <img width="1063" alt="image" src="https://user-images.githubusercontent.com/75510135/155829636-f6f6eb45-7ccd-43ed-8569-63658b84cbd1.png">

  <img width="867" alt="image" src="https://user-images.githubusercontent.com/75510135/155829663-a9324c20-71db-4a0b-af19-6caf1a0cee08.png">

</details>



