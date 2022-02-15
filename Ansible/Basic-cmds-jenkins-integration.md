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
