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

![image](https://user-images.githubusercontent.com/75510135/154174225-2617d734-0e39-4e11-81d2-1f690851104f.png)

