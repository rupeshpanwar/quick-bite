- code is available =>  https://github.com/rupeshpanwar/ansible-advance.git

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
  FROM ubuntu:18.04
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
  - build the image
  ```
  674  docker build -t ubuntu-with-ssh .
  675  docker login
  676  docker images
  677  docker push rupeshpanwar/ubuntu-with-ssh
  681  docker image tag ubuntu-with-ssh rupeshpanwar/ubuntu-with-ssh:v1
  684  docker push rupeshpanwar/ubuntu-with-ssh:v1
  ```
  
  - run 2 times to create 2 target containers 
  
    > docker run --name db_and_web_server3 -it -d rupeshpanwar/ubuntu-with-ssh:v1
  docker run -d mmumshad/ubuntu-ssh-enabled
  
  - fetch ipaddress of each container
  
   > docker inspect 7f | grep IPAddress
  
  - create inventory file
  ```
    cat > inventory.txt
db_and_web_server1 ansible_host=172.17.0.3 ansible_ssh_pass=Passw0rd ansible_ssh_common_args='-o StrictHostKeyChecking=no'
db_and_webserver2 ansible_host=172.17.0.4 ansible_ssh_pass=Passw0rd ansible_ssh_common_args='-o StrictHostKeyChecking=no'
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
<summary>Dynamic-Inventory</summary>
<br>

  - https://github.com/ansible/ansible/tree/devel/lib/ansible/inventory
  
  <img width="884" alt="image" src="https://user-images.githubusercontent.com/75510135/163698237-a863e534-6c2c-4130-8dc2-b87548dc45a9.png">

  <img width="900" alt="image" src="https://user-images.githubusercontent.com/75510135/163698246-f9fe6e0f-19f3-4f06-83f6-8b7ba4316fc1.png">

  <img width="925" alt="image" src="https://user-images.githubusercontent.com/75510135/163698258-5fd12417-7b55-4582-aafa-1161bb59d552.png">

  <img width="1042" alt="image" src="https://user-images.githubusercontent.com/75510135/163698282-f520f1f3-5acf-42f5-abc4-f8e9d26ff7b0.png">

  <img width="625" alt="image" src="https://user-images.githubusercontent.com/75510135/163698297-d055b529-9cf9-4752-86a5-092af4a965c4.png">

  
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

<details>
<summary>Reorganise code - File Separation</summary>
<br>
 
  
  - host_vars => create same name yml file as host entry as mentioned  in playbook.yml => hosts: then move them to their respective yml file
  <img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/163663008-b11a6b20-c555-4dcf-97d1-b8bec8b71288.png">

  <img width="809" alt="image" src="https://user-images.githubusercontent.com/75510135/163662944-ff0d354a-0c8a-4d2b-8522-6dd6e903f37c.png">
  <img width="889" alt="image" src="https://user-images.githubusercontent.com/75510135/163662956-065b4acc-ff2c-4def-a58f-4a1004dd11b4.png">
  
  - group_vars => alternatively , create a Group in Inventory file
  <img width="961" alt="image" src="https://user-images.githubusercontent.com/75510135/163663093-1c05644d-6769-44df-b06a-173f5eaebd5b.png">
 - then create group_vars and create yml file with same name as of group name then move the variable there
  <img width="995" alt="image" src="https://user-images.githubusercontent.com/75510135/163663147-a4718da4-0557-409d-b73e-fa045f53eaf1.png">
 - Now, Create Tasks dir , move DB related code to deploy_db.yml and Web related code to deploy_web.yml
  <img width="1134" alt="image" src="https://user-images.githubusercontent.com/75510135/163663291-02cf98ef-0b69-4298-b7ff-58386cbb2bdd.png">

  <img width="983" alt="image" src="https://user-images.githubusercontent.com/75510135/163663309-b0677525-b0a1-4239-b97f-67591874a5a4.png">
 - import db & web playbook to main playbook.yml
 <img width="872" alt="image" src="https://user-images.githubusercontent.com/75510135/163663790-c45b3914-ba68-4fd8-a012-d4b507968c40.png">
</details>


