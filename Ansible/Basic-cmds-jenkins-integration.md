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
  
  
