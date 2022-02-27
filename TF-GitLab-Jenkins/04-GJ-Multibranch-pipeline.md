- acronym => MBP = [Multibranch Pipeline]


**steps**

<details>
<summary>@Jenkins, Create Multibranch pipeline</summary>
<br>

 ** Note , there must be Jenkinsfile in git repo**
  
  ![image](https://user-images.githubusercontent.com/75510135/155863474-5010dae8-6918-42e9-b66f-98b0227b1fb1.png)
  
  - Under Branch Source , select Git and feed url of Repo( here GitLab)
  
  ![image](https://user-images.githubusercontent.com/75510135/155863549-ad0be973-86c9-411a-879f-56e5c51f8ac4.png)

  ![image](https://user-images.githubusercontent.com/75510135/155863560-d463d508-4faf-4b41-a04c-320e2cab506a.png)

  - Set Discover branch behaviour [like scan branch where name starts with fix or dev]
  
  ![image](https://user-images.githubusercontent.com/75510135/155864186-c9ff757b-4653-44f7-b2a9-058c484baba4.png)

  - Set additonal behaviour , checkout, cleanup before n after
  
  ![image](https://user-images.githubusercontent.com/75510135/155864245-f6b2829c-0bf1-45e1-a81a-22232a12ff98.png)

  - Define the interval , at which scan for new change should be run
  
  ![image](https://user-images.githubusercontent.com/75510135/155864767-87a9a83a-a80a-48ab-900a-5980a577b62a.png)

 
  
</details>

<details>
<summary>Create New Branches</summary>
<br>

   - to create feature branch n push to upstream
  
  ```
      git checkout -b fix-123
      git push --set-upstream origin fix-123
      git checkout main
      git checkout -b dev-456
      git push --set-upstream origin dev-456
  
  ```

  ![image](https://user-images.githubusercontent.com/75510135/155864128-7364d53a-a585-45d9-9369-c51da0054ad0.png)

  - @Jenkinsfile, add branch specific stage 
  
  ```
              pipeline {
              agent any

              options {
                      buildDiscarder logRotator(
                          artifactDaysToKeepStr:'',
                          artifactNumToKeepStr:'5',
                          daysToKeepStr:'',
                          numToKeepStr:'5'
                      )
                      disableConcurrentBuilds()
              }
              stages {
                  stage('Hello') {
                      steps {
                          echo 'Hello World'
                      } // steps end here
                  }// stage ends here
                  stage('cat readme'){
                      when {
                          branch "dev-*"
                      }
                      steps {
                          sh ```
                              cat README.md
                             ```
                          }
                     }// stage cat readme ends here
              }
          }
  ```
  
  - to delete the branch locally
  
  ```
   git branch -d fix-123  [delete from local]
   git push origin --delete fix-123 [delete from remote]
  
  ```
  
  - Now scan the multibranch pipeline
  
  ![image](https://user-images.githubusercontent.com/75510135/155864789-59aee3c4-1c2b-41af-a45d-1d2b98198100.png)

  
</details>



<details>
<summary>Validate & Fix </summary>
  
  - MBP creates a parent folder 
  
  ![image](https://user-images.githubusercontent.com/75510135/155864803-d91eb344-15a4-463d-b74c-a0de05989c28.png)

  ![image](https://user-images.githubusercontent.com/75510135/155864812-e107ccda-9e79-42e8-8c4e-de21002389af.png)

 - scan logs
  
  ![image](https://user-images.githubusercontent.com/75510135/155865294-fd7eac8f-f210-4745-bbce-796d6765f146.png)

- possible chances of Jenkins encounter issue of no access to git lab
  
  > multibranch pipeline stderr: Host key verification failed.
  
 - Solution > take the pub key from Jenkins server n paste it into authorized_key in Gitlab
  
- we can now find the branches as per out criteria in MBP configuration
  
  ![image](https://user-images.githubusercontent.com/75510135/155865352-a29c7719-2aaa-4b45-b3a0-b776d20094b6.png)

- Each of these branches run as per Jenkinsfile
  
  ![image](https://user-images.githubusercontent.com/75510135/155865378-4b4202cf-4bc4-4b5c-9563-6eb3c3ca8630.png)

  
<br>

</details>

<details>
<summary>Alternate => Scan Via plugin & Webhook</summary>
<br>

  - @Jenkins, Install plugin => Multibranch Scan Webhook Trigger , click on Install without restart
  
  ![image](https://user-images.githubusercontent.com/75510135/155866195-896bdb03-0ae0-4dae-80b0-1ecb45b19e9c.png)

  - click on MBP now , under Configure => check section "Scan Multibranch Pipeline Triggers" 
  - new option "Scan by Webhook" is added
  
  ![image](https://user-images.githubusercontent.com/75510135/155866264-8c8f5756-301d-4c08-9a5d-ed117383dbe9.png)

  - Check "Scan by Webhook" option , enter any suitable name here
  
  ![image](https://user-images.githubusercontent.com/75510135/155866285-2f1e75f5-9c41-44cf-b261-2328112dffca.png)

  - Click on "?" in same window, it will give you the URL link of Jenkins webhook to configure with repo
  - JENKINS_URL/multibranch-webhook-trigger/invoke?token=[Trigger token] 
  ![image](https://user-images.githubusercontent.com/75510135/155866331-ee8af364-d97d-4be5-a8f8-1d4f51d20a1e.png)

  - save the MBP 
  
  
  
</details>

<details>
<summary>@GitLab, Configure the webhook obtained from Jenkins MBP</summary>
<br>
  
  - Click on Settings under Project
 
</details>


<details>
<summary>sample</summary>
<br>

</details>
