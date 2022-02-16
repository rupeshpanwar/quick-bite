- quick Ansible installation on ubuntu server

```
    # python3 & pip are installed
    sudo apt update -y
    sudo apt install python3-pip
     
    # install ansible
    sudo pip3 install ansible --upgrade
    # or try:  pip3 install ansible --upgrade --user
 ```
 
- ansible -i inventory example -m ping -u <your_user_name> --ask-pass

```
hosts

[jenkins]
machinename ansible_connection=ssh ansible_user=<<>>
[local]
127.0.0.1 ansible_connection=local

```

```
ansible.cfg

[defaults]
inventory = hosts
host_key_checking = False

```
- now if you need to run a playbook against target host
```
checkJenkinsService.yml

---
- hosts: jenkins
  tasks:
    - name: Check status of Jenkins service
      service_facts:
      register: service_state
    - debug:
        var: service_state.ansible_facts.services["jenkins.service"].state

```
- to run the playbook => ansible-playbook checkJenkinsService.yml --ask-pass

- remove jenkins from Ubuntu
```
sudo apt-get remove --purge jenkins
```
# install Jenkins
```
---
- hosts: jenkins
  become: yes
  tasks:
  - name: openjdk
    apt: name=openjdk-8-jdk update_cache=yes

  - name: repo key
    apt_key: url=https://pkg.jenkins.io/debian-stable/jenkins.io.key state=present

  - name: repo
    apt_repository: repo='deb https://pkg.jenkins.io/debian-stable binary/' state=present

  - name: jenkins
    apt: name=jenkins update_cache=yes

  - name: jenkins service
    service: name=jenkins state=started

  - name: print passwd
    command: cat /var/lib/jenkins/secrets/initialAdminPassword
    register: jpass

  - name: passwd
    debug:
      var: jpass
  ```
  
  # check JenkinsService run status
  ```
  root@jenkins:~# more checkJenkinsService.yml
---
- hosts: jenkins
  become: yes
  tasks:
  - name: jenkins service
    service: name=jenkins state=started
  ```
  
  # Install Ansible plugin
![image](https://user-images.githubusercontent.com/75510135/154173727-f816589e-2b44-417f-89f2-af7ab2545fe1.png)


- check the box n click on install without restart
![image](https://user-images.githubusercontent.com/75510135/154173854-a2e1f654-b7cc-4405-83e5-a72eb891844a.png)

- switch to manage jenkins => Global Configuration Tool => Ansible section => click on Add Ansible

- add path as installation path on server
<img width="456" alt="image" src="https://user-images.githubusercontent.com/75510135/154174135-46745963-eba3-4936-ad7f-e045198f466b.png">

![image](https://user-images.githubusercontent.com/75510135/154182097-d997c19e-1210-4f7a-9bcb-4aa0c9033063.png)

## note , setting up the password for Jenkins
```
sudo visudo
jenkins    ALL=(ALL) NOPASSWD:ALL
```

# Jenkinsfile
```
pipeline{
    agent {
        node{
            label "node:ansible"
            customWorkspace "/usr/Jenkins"
        }
    }
    stages{
        stage('test echo') {
          steps {
            // One or more steps need to be included within the steps block.
            echo 'test'
        //   sh 'echo $PATH'
        //   sh 'ls -lrta'
        //   sh 'ansible --version'
        //   sh 'which ansible'
          }
        } // stage - test echo closed
        
        stage('test service playbook') {
          steps {
            // One or more steps need to be included within the steps block.
            ansiblePlaybook installation: 'ansible', inventory: '/usr/Jenkins/hosts', playbook: '/usr/Jenkins/checkJService.yml'
          }
       } // stage - test service laybook closed
    }
}
```

# Publish Job output to HTML Report 
![image](https://user-images.githubusercontent.com/75510135/154197266-1f0f5dc6-16aa-4876-9d46-295d6107eae2.png)

# find text in console output and mark the job fail
```
pipeline{
    agent {
        node{
            label "node:ansible"
            customWorkspace "/usr/Jenkins"
        }
    }
    stages{
        stage('test echo') {
          steps {
            // One or more steps need to be included within the steps block.
            echo 'test'
        //   sh 'echo $PATH'
        //   sh 'ls -lrta'
        //   sh 'ansible --version'
        //   sh 'which ansible'
          }
        } // stage - test echo closed
        
        stage('test service playbook') {
          steps {
            // One or more steps need to be included within the steps block.
            ansiblePlaybook installation: 'ansible', inventory: '/usr/Jenkins/hosts', playbook: '/usr/Jenkins/checkJService.yml'
          }
       } // stage - test service laybook closed
       
       stage('test html report') {
          steps {
            // One or more steps need to be included within the steps block.
            echo 'test'
           // findText(textFinders: [textFinder(regexp: 'PLAY RECAP', alsoCheckConsoleOutput: true)])
            //  publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: 'Job Output'])
          }
       } // stage - test HTML report closed
       
      
       
    //   stage('test email notification') {
    //       steps {
    //         // One or more steps need to be included within the steps block.
    //          mail bcc: '', body: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:', cc: '', from: 'rupeshpanwar28@gmail.com', replyTo: '', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'rupeshpanwar28@gmail.com'
    //       }
    //   } // stage - test email notification
      
    }
}
```
# Configure Email Notification
- Under Configure System
![image](https://user-images.githubusercontent.com/75510135/154193400-e525d78f-5f36-429c-a1c5-dab07699d154.png)

![image](https://user-images.githubusercontent.com/75510135/154193919-2770c3a4-ea9d-4f2d-b178-df317219f276.png)

![image](https://user-images.githubusercontent.com/75510135/154195090-f701b237-b82a-4a76-913c-69d17cc841e5.png)



- reference links
- https://www.shellhacks.com/ansible-sudo-a-password-is-required/
- https://www.cyberciti.biz/faq/change-root-password-ubuntu-linux/
- https://fuzzyblog.io/blog/ansible/2020/06/03/getting-past-ansible-password-required-issues.html
- https://tech.davidfield.co.uk/from-0-to-code-using-ansible-in-jenkins-pipelines/
- https://blog.dbi-services.com/jenkins-deploy-ansible-playbook-with-jenkins-plugin/
- https://tech.davidfield.co.uk/from-0-to-code-using-ansible-in-jenkins-pipelines/
