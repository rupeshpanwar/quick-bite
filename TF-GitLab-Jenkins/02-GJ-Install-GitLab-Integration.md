- https://about.gitlab.com/install/
- https://plugins.jenkins.io/gitlab-plugin/



<details>
<summary>Install Gitlab</summary>
<br>
  
  1. Run below command after logging into droplet

  ```
  sudo apt-get update
  sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
  sudo apt-get install -y postfix => this is optional
  curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
  sudo EXTERNAL_URL="http://gitlab.test" apt-get install gitlab-ee
  ```
  <img width="836" alt="image" src="https://user-images.githubusercontent.com/75510135/155841497-5ab2f9ea-7c17-42fb-a3b7-c83606232184.png">
  ![image](https://user-images.githubusercontent.com/75510135/155841638-7c431725-ee94-4889-84fa-7aaf4cabe6f0.png)
  
 2. Setup DNS hostname
  
  
  <img width="615" alt="image" src="https://user-images.githubusercontent.com/75510135/155841691-8e0fcc2c-5b01-42d9-a976-e2897f35bdc7.png">

  
  ```
  - on mac , open hosts file
  vi /private/etc/hosts 
  - add below dns entry
  143.110.247.9 gitlab.test
  ```

  ![image](https://user-images.githubusercontent.com/75510135/155841767-386aaeb7-c573-4bea-8d48-685493325a11.png)

</details>
  
<details>
<summary>GitLab Credentials setup</summary>
<br>

  - root user and admin user 
  
  - first time login with root and password is available via
  
  > cat /etc/gitlab/initial_root_password
  
  ![image](https://user-images.githubusercontent.com/75510135/155842066-58fbdce5-d6a4-4838-a194-a5bd20e18e67.png)

  - click on New User
  ![image](https://user-images.githubusercontent.com/75510135/155842075-10b7594b-e3a4-423d-b8aa-69a50a67d349.png)

  ![image](https://user-images.githubusercontent.com/75510135/155842099-f5fed034-eea3-4332-8c49-c958fb032f44.png)

  ![image](https://user-images.githubusercontent.com/75510135/155842111-6068bcb0-a611-43c9-bd81-c0301e5e70d3.png)

  ![image](https://user-images.githubusercontent.com/75510135/155842123-6f72199c-edf3-43cb-98ce-519390138c40.png)

  - now create the password, click on Edit
  
  ![image](https://user-images.githubusercontent.com/75510135/155842159-72cac733-20eb-49ef-9459-11c34d092848.png)

  ![image](https://user-images.githubusercontent.com/75510135/155842168-57f8952c-0cc3-4c29-b862-c587152bff16.png)

  - login with newly created user
  ![image](https://user-images.githubusercontent.com/75510135/155842201-609b5eb9-1718-4527-b418-83bf21d72c71.png)

  - change the passowrd 
  ![image](https://user-images.githubusercontent.com/75510135/155842233-a63d6f00-4aad-4441-a852-c855d720fe6c.png)

  
</details>

  <details>
<summary>Configure Git global configuration</summary>
<br>
  
  
    - set this on user machine

   
         ~ $ git --version
             git version 2.29.2
        ~ $ git config --global user.name "Jon Doe"
        ~ $ git config --global user.email "jondoe@doe.com"
        ~ $ git config --list
    
    
  
  
    <img width="496" alt="image" src="https://user-images.githubusercontent.com/75510135/155842450-c123bd1f-fbe5-49ca-8233-a7a64c97fa5e.png">

    
    
</details>



<details>
<summary>Create a GitLab Project</summary>
<br>

  - Login into gitlab with admin
  
  ![image](https://user-images.githubusercontent.com/75510135/155842541-ca4351ee-a068-4bab-8ceb-8488d00d9062.png)

  - click on Create a Project , then click on Blank project
  
  ![image](https://user-images.githubusercontent.com/75510135/155842719-a3fe9a04-39f3-4594-859f-f62ee484f4fc.png)

  -  then enter the details here , note # keep it Private , uncheck create readme file
  ![image](https://user-images.githubusercontent.com/75510135/155842747-7966366a-0e14-4500-ad47-b8f0336554b3.png)

  - we need to add ssh key 
  
  ![image](https://user-images.githubusercontent.com/75510135/155842774-ee53851b-3e80-445f-a89a-039e2aa807df.png)

  ![image](https://user-images.githubusercontent.com/75510135/155844636-997d3f0e-11bc-490b-935d-5f8e22052897.png)

  ![image](https://user-images.githubusercontent.com/75510135/155844644-b7a0d8ed-6186-449e-a1e7-ee7373c42360.png)

  - Next Clone n push the code
  
  ![image](https://user-images.githubusercontent.com/75510135/155844688-98d2164a-4aee-4f79-a756-ac30e5274c17.png)

  ```
  git config --global user.name "jondoe"
  git config --global user.email "jondoe@doe.com"
  
  
  - for a new repo
  git clone git@gitlab.test:jondoe/demo-one.git
  cd demo-one
  git switch -c main
  touch README.md
  git add README.md
  git commit -m "add README"
  git push -u origin main
  
  - for an existing folder
  cd existing_folder
  git init --initial-branch=main
  git remote add origin git@gitlab.test:jondoe/demo-one.git
  git add .
  git commit -m "Initial commit"
  git push -u origin main
  
  - push an existing repo
  
  cd existing_repo
  git remote rename origin old-origin
  git remote add origin git@gitlab.test:jondoe/demo-one.git
  git push -u origin --all
  git push -u origin --tags
  
  
  ```
  
  ![image](https://user-images.githubusercontent.com/75510135/155845250-2f2077de-3805-4f5c-bc06-3bc8b3acb983.png)

</details>
  
  

<details>
<summary>Jenkins Setup & Configure</summary>
<br>

  - Install Jenkins http://142.93.213.194:8080
  
  - Install plugin
  
  ![image](https://user-images.githubusercontent.com/75510135/155845482-19e3c668-931b-482a-b8c1-a3b29f586eff.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/155845518-8988b7dc-8811-4dc6-8f66-2ea4d30bae35.png)

</details>
  
  
  
<details>
<summary>@GL, Create user for GL-Jenkins integration</summary>
<br>

  
  - @GL, Create user for GL-Jenkins integration
  ![image](https://user-images.githubusercontent.com/75510135/155845636-b960cf9e-87dc-4246-ba63-82455647b858.png)
 
  ![image](https://user-images.githubusercontent.com/75510135/155845657-a7c5d1f0-f707-4daf-bc9b-89e635b76a12.png)
 
  - now click on Edit to generate pwd
  ![image](https://user-images.githubusercontent.com/75510135/155845673-a3e84e78-405c-438f-97a9-d8432181fda1.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/155845703-8b44abe8-e73f-492c-b0fd-bcc8f0d3d319.png)

  - Login with newly created user Gitlab-Jenkins & change the pwd
  
  ![image](https://user-images.githubusercontent.com/75510135/155845768-d8d3a646-8f80-4b69-bbe7-ff746c1c1530.png)

  ![image](https://user-images.githubusercontent.com/75510135/155845779-43e160a9-9751-4559-9c20-37734c12575a.png)

  - token created , copy it , would need it at @Jenkins side configuration
  
  ![image](https://user-images.githubusercontent.com/75510135/155846123-3ca36107-582e-4e31-9a65-8d7ccb39ad15.png)

  
  
</details>
  
  
<details>
<summary>@GL, Create token for user</summary>
<br>

  - Click on Edit profile for the user
  
  ![image](https://user-images.githubusercontent.com/75510135/155846060-d53cea05-1e18-4d29-a2d0-77e3d930df83.png)

  - Click on access token
  
  ![image](https://user-images.githubusercontent.com/75510135/155846071-37d91c69-612a-4266-92e1-5541fc3d6a35.png)

  ![image](https://user-images.githubusercontent.com/75510135/155846085-f73fd2de-bea7-48a1-ab85-93b091159299.png)

  
</details>


<details>
<summary>@Jenkins, Configure GL url and access</summary>
<br>

   - @Jenkins
  
  ![image](https://user-images.githubusercontent.com/75510135/155846166-2b9774a4-175c-4eed-b7ff-c352aed37a83.png)

  - take the public ip( in case DNS is not configure for Gitlab on Jenkins server(host entry))
  
  ![image](https://user-images.githubusercontent.com/75510135/155846245-fb0cda03-fc50-4e3d-9734-346ff4898517.png)

  - create new credential at Jenkins using above created token at GitLab
  
  ![image](https://user-images.githubusercontent.com/75510135/155846262-72a8208d-be50-49e5-aac4-cf74dd304310.png)

  ![image](https://user-images.githubusercontent.com/75510135/155846285-76fed956-33e8-4bce-9a9a-aa988142cffd.png)

  - then test connection
  
  ![image](https://user-images.githubusercontent.com/75510135/155846304-b54cf3c6-d3a4-4ffe-acbf-5bd200758ede.png)

  
</details>


<details>
<summary>@GL, grant user permission to Project</summary>
<br>

  - login under Maintainer or root user, then click on Member under Project
  
  ![image](https://user-images.githubusercontent.com/75510135/155846713-e6a43d4f-8d14-4342-a65e-99d0dad3386b.png)

  - Click on Invite member
  
  ![image](https://user-images.githubusercontent.com/75510135/155846763-bf072f2d-e6e5-48d8-b6de-ac207d3c5f02.png)

  ![image](https://user-images.githubusercontent.com/75510135/155846785-617d7d0f-cb22-4ad8-af79-015593fdde86.png)

  
</details>

<details>
<summary>@Jenkins, Add Jenkinsfile to project root dir</summary>
<br>

  ```
  pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
  ```
  
  - then commit the code to gitlab repo
  
  ```
    #!/bin/bash
    git add .
    git commit -m 'Jenkinsfile'
    git push origin master
  ```
</details>


<details>
<summary>Add Jenkins user ssh key to GitLab</summary>
<br>

  - Login into Jenkins server , locate the ~/.ssh/id_rsa.pub ket
  
  ```
  su jenkins
  cd ~
  
  ssh-keygen => enter
  Generating public/private rsa key pair.
  Enter file in which to save the key (/var/lib/jenkins/.ssh/id_rsa):
  Created directory '/var/lib/jenkins/.ssh'.
  Enter passphrase (empty for no passphrase):
  Enter same passphrase again:
  Your identification has been saved in /var/lib/jenkins/.ssh/id_rsa
  Your public key has been saved in /var/lib/jenkins/.ssh/id_rsa.pub
  
  cat /var/lib/jenkins/.ssh/id_rsa.pub
  
  ```
  
  - copy the above public key
  - Login into GITLAB under user GitLab-Jenkins and paste the key 
  
  ![image](https://user-images.githubusercontent.com/75510135/155847344-6ba98ab1-eb93-49a3-ad50-366d5a6649f8.png)

  - click on Add key
  
</details>


<details>
<summary>@Jenkins, Create pipeline</summary>
<br>

  - Click on New Item
  ![image](https://user-images.githubusercontent.com/75510135/155847608-a7e48ad8-c466-4d69-9b55-8613e4f012a5.png)

  ![image](https://user-images.githubusercontent.com/75510135/155847634-1afb5181-dabd-44e4-87dc-239097e0bbe1.png)

  ![image](https://user-images.githubusercontent.com/75510135/155847673-f80f13fc-cc6c-48c0-afe2-8cf469c58a67.png)

  - copy the ssh link from Gitlab repo
  ![image](https://user-images.githubusercontent.com/75510135/155847733-013d3227-c8d6-4926-8f94-51cf47146425.png)

  
  ![image](https://user-images.githubusercontent.com/75510135/155847872-924eab47-36ec-489d-998a-b862961ef66a.png)

  ![image](https://user-images.githubusercontent.com/75510135/155847895-2726c0ce-3175-4a7a-8fe5-d912f2bef843.png)

  
  **Note**
  ![image](https://user-images.githubusercontent.com/75510135/155848444-63b6a660-055e-42f5-9079-c681ccefdc92.png)

   - @jenkins server => to GitLab server
  
  <img width="659" alt="image" src="https://user-images.githubusercontent.com/75510135/155848476-8a6a05bf-2b5c-4812-a083-2ec4e54f17ca.png">

  ![image](https://user-images.githubusercontent.com/75510135/155848524-8701581d-467d-4a5c-8c5b-7bd5279b56f5.png)

  ![image](https://user-images.githubusercontent.com/75510135/155848546-62d61297-bb73-418a-9034-a67f33e60d86.png)

</details>




  
  
  
