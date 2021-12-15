Wrapup-Advanced


(CI)Basic Setup
* Look for branch
* Create new branch
* Under Project Settings -> Enable Repos
* It will create Main branch , we change it later
* Then click on initialise , then it will initialise repo
* Click on Main, select +Add , then create other branches like Development
* Clone the brach to local git 
* Open in VS Code

Coding and check-in
* Create a new project in VS Code 
*        dotnet new webapi 
* Commit the change to repo in git
* Push the change back to Az DevOps Repo, cross check at Azure Repo
* Note # main branch will be empty at the beginning

Working on Features
*    Create a new branch based on development brach for feature(as per Jira work item)
*    Run -> git fetch , in vs code and it will pull feature brach from Az Repo to VS code
*    Testing , make some code changes then
-        run , dotnet run , cmd in VS code
-        Commit the changes
-        Push the change to repo
   
To merge the branch(after feature branch is fully tested)
-      Switch to Dev branch in VS code
-      Then make a pull request
*   Then Branch -> merge branch
*   Again push Dev branch code to repo
     
Release to Azure(Appservice / ACR)
  Create a release branch based on Dev branch
  This release branch can be pushed to UAT/QA/Prod on Azure
   Note #once released to production then merge it with Production
  
Working on Variable 
   Create a json file in VS code , listing variable
   Define the same , pipeline -> Library

(CD)Pipeline
 Create a new pipeline [connect -> select -> configure -> review]


*     Click on classic editor(where is your code) 
*     Pick the Dev branch from Az Repo(created above)
*     Select respective template(Asp.net core here in eg)
*     It will add required tasks
-          Restore 
-          Build 
-          Test
-           Publish
*     Link the variables to pipeline
*     On agent , click + , select file transform, do the necessary changes as shown in screenshot
*    Now, time to run the pipeline as shown in screenshot
*    It appears as queued Agent job, look for progress of agent job run


Release Pipeline(Deploy webapp to Dev in Azure)
* Create a new release pipeline
* Click on Add artifacts , select the pipeline , setup during CI
* Select template (empty ) @ stage 1
* Click on stage 1, add task to agent job, search for “App service deploy”
* Next Select , Az Subs, App Service 
* Save and create the release
* Go to release -> click on Deploy (as this is manual one)
* Click on logs , check the progress of deployment
* Check App Service in Azure portal


Release Pipeline(Deploy webapi to UAT/QA/Prod in Azure)
*    Take build id from Dev release pipeline
*    Clone the dev release pipeline -> modify the name to QA
*    Stage 1 -> click on icon -> enable pre-deployment condition for approval to QA environment
*    Note # Azure side, you should create a different staging environment to host QA release
*    On Deployment Build, click , then select Release (release to trigger QA release pipeline)
*    Select the latest / last successful version and release
*    A new release will be queued , need to click on Deploy
*    Lastly Approve the release
