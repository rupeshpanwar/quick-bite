<details>
<summary>Docker based setup</summary>
<br>

  <img width="561" alt="image" src="https://user-images.githubusercontent.com/75510135/163583431-808fa032-fe9c-4a90-a643-fd7383785850.png">

  - install ansible on ubuntu
  ```
    $ sudo apt update
    $ sudo apt install software-properties-common
    $ sudo add-apt-repository --yes --update ppa:ansible/ansible
    $ sudo apt install ansible
  ```
  - create ssh enabled docker image => dockerfile
  ```
  FROM ubuntu:16.04
  RUN apt-get update && apt-get install -y openssh-server
  RUN mkdir /var/run/sshd
  RUN echo 'root:Passw0rd' | chpasswd
  RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
  ENV NOTVISIBLE "in users profile"
  RUN echo "export VISIBLE=now" >> /etc/profile
  EXPOSE 22
  CMD ["/usr/sbin/sshd", "-D"]
  ```
  
  - run 3 times to create 3 containers 
  
    > docker run -it -d mmumshad/ubuntu-ssh-enabled
  
  - fetch ipaddress of each container
  
   > docker inspect 7f | grep IPAddress
  
  - create inventory file
  ```
    cat > inventory.txt
    target1 ansible_host=172.17.0.2 ansible_ssh_pass=Passw0rd
    target2 ansible_host=172.17.0.3 ansible_ssh_pass=Passw0rd
    target3 ansible_host=172.17.0.4 ansible_ssh_pass=Passw0rd
  ```
  - test
  ```
    ansible target1 -m ping -i inventory.txt
    target1 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
    }
  ```
</details>

<details>
<summary>Small project Webapplication</summary>
<br>

  <img width="971" alt="image" src="https://user-images.githubusercontent.com/75510135/163585058-775caabc-9538-42ed-953d-d68f628b45b0.png">

  - manual deployment https://github.com/rupeshpanwar/simple-webapp
</details>


<details>
<summary>Code - Small project Webapplication</summary>
<br>
  
  ```
  db_and_webserver1 ansible_host=172.17.0.2 ansible_ssh_pass=Passw0rd ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  db_and_webserver2 ansible_host=172.17.0.3 ansible_ssh_pass=Passw0rd ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  db_and_webserver3 ansible_host=172.17.0.4 ansible_ssh_pass=Passw0rd ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  ```
  
  ```
  ---
- name: Simple Web Application
  hosts: db_and_webserver1,db_and_webserver2
  tasks:
   - name: ping
     ping:
  ```
  
  ```
  ansible-playbook playbook.yml -i inventory.txt

PLAY [Simple Web Application] ***********************************************************

TASK [Gathering Facts] ******************************************************************
ok: [db_and_webserver2]
ok: [db_and_webserver1]

TASK [ping] *****************************************************************************
ok: [db_and_webserver2]
ok: [db_and_webserver1]

PLAY RECAP ******************************************************************************
db_and_webserver1          : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db_and_webserver2          : ok=2    changed=0    unreachable=0    failed=0    skipped=0
  ```
</details>


