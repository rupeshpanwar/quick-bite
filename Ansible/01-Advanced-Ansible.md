-Env setup => https://github.com/rupeshpanwar/codespaces


<details>
<summary>Code Structure && Ansible.cfg</summary>
<br>
  
  - Code Structure

<img width="444" alt="image" src="https://user-images.githubusercontent.com/75510135/162985208-ac0b265d-e5dc-46bb-9695-ab54911f04f1.png">

<img width="722" alt="image" src="https://user-images.githubusercontent.com/75510135/162986185-4e45aa88-d310-497a-8706-b385530c15c3.png">

- ansible.cfg

<img width="775" alt="image" src="https://user-images.githubusercontent.com/75510135/162986322-1fbdac6e-7614-4c5e-bd17-bc6ba2d2058d.png">

<img width="736" alt="image" src="https://user-images.githubusercontent.com/75510135/162986589-ca414d7e-2348-461b-bfab-9878dbe5229d.png">

<img width="432" alt="image" src="https://user-images.githubusercontent.com/75510135/162987955-81920a25-84fe-4fe1-9157-3140313d93d3.png">

<img width="768" alt="image" src="https://user-images.githubusercontent.com/75510135/162986706-e2de3cc3-b0f1-473f-9873-aeb12c6c3f0e.png">

<img width="736" alt="image" src="https://user-images.githubusercontent.com/75510135/162987063-4ffe6dfa-1624-4cd2-868e-48c8e55035a3.png">

Ansible configuration file

Change into /vagrant/code/chap3 directory on your ansible host. Create a file called ansible.cfg Add the following contents to the file.

On Ansible Control node,

    cd chap4 
    ansible --version

Create ansible.cfg in chap4

    [defaults]
    remote_user = devops
    inventory   = environments/prod
    retry_files_save_path = /tmp
    host_key_checking = False
    log_path=~/ansible.log

Validate that your new configs are picked up,

    ansible --version 
    ansible-config dump
</details>


<details>
<summary>Inventories</summary>
<br>

  <img width="673" alt="image" src="https://user-images.githubusercontent.com/75510135/162998049-592170ad-6989-4bd5-8d64-d3f2b9876822.png">

  <img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/162998130-e0eaa323-a5d4-4d23-b795-a079de3ad170.png">

  <img width="740" alt="image" src="https://user-images.githubusercontent.com/75510135/162998227-00852b05-de8b-4219-a012-99d43b8fb74b.png">

  <img width="709" alt="image" src="https://user-images.githubusercontent.com/75510135/162998596-7dd9bdcc-bf2b-4c49-946c-de2bcd79b55a.png">

  <img width="620" alt="image" src="https://user-images.githubusercontent.com/75510135/162998670-25d0171a-d61f-475d-b6c5-805b962f7a28.png">

  <img width="692" alt="image" src="https://user-images.githubusercontent.com/75510135/162998728-8350d924-8818-4199-88b9-ef28d4376925.png">

  <img width="751" alt="image" src="https://user-images.githubusercontent.com/75510135/162998807-30610d71-7996-4286-851f-d894aec6be7b.png">

  
  Creating Host Inventory

Since you are going to create a environment specific inventory, create a environments directory and a file inside it called prod

    mkdir environments

Create inventory file

file: environments/prod

Let's create three groups as follows,

    [local]
    localhost ansible_connection=local  
    [lb] 
    lb  
    [app] 
    app1 
    app2   
    [db] 
    db  
    [prod:children] 
    lb 
    app 
    db 

    First group contains the localhost, the control host. Since it does not need to be connected over ssh, it mandates we add ansible_connection=local option

    Second group contains Application Servers. We will add two app servers to this group.

    Third group holds the information about the database servers.

The inventory file should look like below.
Setup passwordless SSH between ansible controller and remote machine

on Host machine

Ansible uses passwordless ssh.

Generate ssh keypair if not present already using the following command.

    ssh-keygen -t rsa
     
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa):
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /home/ubuntu/.ssh/id_rsa.
    Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub.
    The key fingerprint is:
    SHA256:yC4Tl6RYc+saTPcLKFdGlTLOWOIuDgO1my/NrMBnRxA ubuntu@node1
    The key's randomart image is:
    +---[RSA 2048]----+
    |   E    ..       |
    |  . o +..        |
    | . +o*+o         |
    |. .o+Bo+         |
    |. .++.X S        |
    |+ +ooX .         |
    |.=.OB.+ .        |
    | .=o*= . .       |
    |  .o.   .        |
    +----[SHA256]-----+

Just leave the fields to defaults. This command will generate a public key and private key for you.

Copy over the public key to all remote machine.

Example, assuming ubuntu as the user which has a privileged access on the remote machie

    ssh-copy-id devops@lb
    ssh-copy-id devops@app1  
    ssh-copy-id devops@app2  
    ssh-copy-id devops@db

This will copy our newly generated public key to the remote machine. After running this command you will be able to SSH into the machine directly without using a password.

Ansible Ping

We will use Ansible to make sure all the hosts are reachable

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/162998945-20a149a8-e99a-416a-90d8-444520983a56.png">

  
    ansible all -m ping

[Output]

    lb | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    app1 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    app2 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    db | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
  
  <img width="755" alt="image" src="https://user-images.githubusercontent.com/75510135/162999028-d29cec9f-591c-452d-886e-15e6af66e0f9.png">

  <img width="722" alt="image" src="https://user-images.githubusercontent.com/75510135/162999076-6983e815-be83-46b4-abe2-2939e02ec64f.png">

  <img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/162999121-b6997bc5-ec54-43c3-8438-610c19c73407.png">

  <img width="750" alt="image" src="https://user-images.githubusercontent.com/75510135/162999221-2138019e-6000-4a96-97b8-940af2573807.png">

  
</details>


<details>
<summary>Host Pattern</summary>
<br>

  <img width="696" alt="image" src="https://user-images.githubusercontent.com/75510135/163001459-10543350-15b8-455e-ae86-e47f13b80425.png">

  <img width="710" alt="image" src="https://user-images.githubusercontent.com/75510135/163002172-2447a1d8-3284-45de-8554-d123492438f8.png">

  <img width="587" alt="image" src="https://user-images.githubusercontent.com/75510135/163002238-7ebe45ef-e03c-46d2-b790-776e76a92a03.png">

  <img width="685" alt="image" src="https://user-images.githubusercontent.com/75510135/163002291-c75ebc2d-117c-43fb-8351-4da33c348f7b.png">

  <img width="609" alt="image" src="https://user-images.githubusercontent.com/75510135/163002343-62c22a97-df85-4f04-9def-bd84744b9664.png">

  <img width="762" alt="image" src="https://user-images.githubusercontent.com/75510135/163002441-0f4e6564-cdbd-4113-b2ff-4e735919a8a1.png">

  <img width="573" alt="image" src="https://user-images.githubusercontent.com/75510135/163002511-4ee6cc29-1f02-4535-be96-215deeb1f3db.png">

  <img width="641" alt="image" src="https://user-images.githubusercontent.com/75510135/163002558-1e84257e-feb3-4078-9753-098cc0b90bad.png">

  <img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/163002599-5bd37d02-0851-43a7-ab1f-5b192b0671e5.png">

  
</details>

<details>
<summary>Ad Hoc command</summary>
<br>

  Ad Hoc commands

Try running following fire-and-forget Ad-Hoc commands...

Run hostname command on all hosts

Let us print the hostname of all the hosts

    ansible all -a hostname

[output]

    localhost | SUCCESS | rc=0 >>
    ansible
     
    192.168.61.11 | SUCCESS | rc=0 >>
    db
     
    192.168.61.12 | SUCCESS | rc=0 >>
    app
     
    192.168.61.13 | SUCCESS | rc=0 >>
    app

Check the uptime

How long the hosts are up?

    ansible all -a uptime

[Output]

    localhost | SUCCESS | rc=0 >>
     13:17:13 up  2:21,  1 user,  load average: 0.16, 0.03, 0.01
     
    192.168.61.12 | SUCCESS | rc=0 >>
     13:17:14 up  1:50,  2 users,  load average: 0.00, 0.00, 0.00
     
    192.168.61.13 | SUCCESS | rc=0 >>
     13:17:14 up  1:47,  2 users,  load average: 0.00, 0.00, 0.00
     
    192.168.61.11 | SUCCESS | rc=0 >>
     13:17:14 up  1:36,  2 users,  load average: 0.00, 0.00, 0.00

Check memory info on app servers

Does my app servers have any disk space free?

    ansible app -a free

[Output]

    192.168.61.13 | SUCCESS | rc=0 >>
                 total       used       free     shared    buffers     cached
    Mem:        372916     121480     251436        776      11160      46304
    -/+ buffers/cache:      64016     308900
    Swap:      4128764          0    4128764
     
    192.168.61.12 | SUCCESS | rc=0 >>
                 total       used       free     shared    buffers     cached
    Mem:        372916     121984     250932        776      11228      46336
    -/+ buffers/cache:      64420     308496
    Swap:      4128764          0    4128764

Installing packages

Let us install Docker on app servers

    ansible app -a "yum install -y docker-engine"

This command will fail.

[Output]

    192.168.61.13 | FAILED | rc=1 >>
    Loaded plugins: fastestmirror, prioritiesYou need to be root to perform this command.
     
    192.168.61.12 | FAILED | rc=1 >>
    Loaded plugins: fastestmirror, prioritiesYou need to be root to perform this command.

Run the fillowing command with sudo permissions.

    ansible app -s -a "yum install -y docker-engine"

This will install docker in our app servers

[Output]

    192.168.61.12 | SUCCESS | rc=0 >>
    Loaded plugins: fastestmirror, priorities
    Setting up Install Process
    Loading mirror speeds from cached hostfile
     * base: mirrors.nhanhoa.com
     * epel: mirror.rise.ph
     * extras: mirror.fibergrid.in
     * updates: mirror.fibergrid.in
    283 packages excluded due to repository priority protections
    Resolving Dependencies
    --> Running transaction check
    ---> Package docker-engine.x86_64 0:1.7.1-1.el6 will be installed
    --> Finished Dependency Resolution
     
    Dependencies Resolved
     
    ================================================================================
     Package             Arch         Version              Repository          Size
    ================================================================================
    Installing:
     docker-engine       x86_64       1.7.1-1.el6          local_docker       4.5 M
     
    Transaction Summary
    ================================================================================
    Install       1 Package(s)
     
    Total download size: 4.5 M
    Installed size: 19 M
    Downloading Packages:
    Running rpm_check_debug
    Running Transaction Test
    Transaction Test Succeeded
    Running Transaction
      Installing : docker-engine-1.7.1-1.el6.x86_64                             1/1
      Verifying  : docker-engine-1.7.1-1.el6.x86_64                             1/1
     
    Installed:
      docker-engine.x86_64 0:1.7.1-1.el6
     
    Complete!
     
    192.168.61.13 | SUCCESS | rc=0 >>
    Loaded plugins: fastestmirror, priorities
    Setting up Install Process
    Loading mirror speeds from cached hostfile
     * base: mirror.fibergrid.in
     * epel: mirror.rise.ph
     * extras: mirror.fibergrid.in
     * updates: mirror.fibergrid.in
    283 packages excluded due to repository priority protections
    Resolving Dependencies
    --> Running transaction check
    ---> Package docker-engine.x86_64 0:1.7.1-1.el6 will be installed
    --> Finished Dependency Resolution
     
    Dependencies Resolved
     
    ================================================================================
     Package             Arch         Version              Repository          Size
    ================================================================================
    Installing:
     docker-engine       x86_64       1.7.1-1.el6          local_docker       4.5 M
     
    Transaction Summary
    ================================================================================
    Install       1 Package(s)
     
    Total download size: 4.5 M
    Installed size: 19 M
    Downloading Packages:
    Running rpm_check_debug
    Running Transaction Test
    Transaction Test Succeeded
    Running Transaction
      Installing : docker-engine-1.7.1-1.el6.x86_64                             1/1
      Verifying  : docker-engine-1.7.1-1.el6.x86_64                             1/1
     
    Installed:
      docker-engine.x86_64 0:1.7.1-1.el6
     
    Complete!

Running commands one machine at a time

Do you want a command to run on one machine at a time ?

    ansible all -f 1 -a "free"



</details>

<details>
<summary>Module</summary>
<br>

  <img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/163003906-fe3c4ce4-f862-4ede-a458-04b620484e40.png">

  <img width="783" alt="image" src="https://user-images.githubusercontent.com/75510135/163004028-7ca2e2bd-37be-4b58-8525-b1cee92b4a0c.png">

  <img width="704" alt="image" src="https://user-images.githubusercontent.com/75510135/163004116-51a30adf-6552-4bbf-a184-8c35182159f2.png">

  <img width="644" alt="image" src="https://user-images.githubusercontent.com/75510135/163004194-6036bd65-6f57-4477-a072-9a4e6db48d61.png">

  <img width="627" alt="image" src="https://user-images.githubusercontent.com/75510135/163004251-3e83cac7-5a22-4fec-b515-3e8fdd1b71ea.png">

  <img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/163004299-10f1a21c-f434-4b9e-ac49-68b754495592.png">

  <img width="452" alt="image" src="https://user-images.githubusercontent.com/75510135/163004361-a145660d-74b0-4bbd-8e7d-6eb641065fc5.png">

  Using modules to manage the state of infrastructure

Creating users and groups using user and group

To create a group

    ansible app -s -m group -a "name=admin state=present"

The output will be,

    192.168.61.13 | SUCCESS => {
        "changed": true,
        "gid": 501,
        "name": "admin",
        "state": "present",
        "system": false
    }
    192.168.61.12 | SUCCESS => {
        "changed": true,
        "gid": 501,
        "name": "admin",
        "state": "present",
        "system": false
    }

To create a user

    ansible app -s -m user -a "name=devops group=admin createhome=yes"

This will create user devops,

    192.168.61.13 | SUCCESS => {
        "changed": true,
        "comment": "",
        "createhome": true,
        "group": 501,
        "home": "/home/devops",
        "name": "devops",
        "shell": "/bin/bash",
        "state": "present",
        "system": false,
        "uid": 501
    }
    192.168.61.12 | SUCCESS => {
        "changed": true,
        "comment": "",
        "createhome": true,
        "group": 501,
        "home": "/home/devops",
        "name": "devops",
        "shell": "/bin/bash",
        "state": "present",
        "system": false,
        "uid": 501
    }

Copy a file using copy modules

We will copy file from control node to app servers.

    ansible app -m copy -a "src=/vagrant/test.txt dest=/tmp/test.txt"

File will be copied over to our app server machines...

    192.168.61.13 | SUCCESS => {
        "changed": true,
        "checksum": "3160f8f941c330444aac253a9e6420cd1a65bfe2",
        "dest": "/tmp/test.txt",
        "gid": 500,
        "group": "vagrant",
        "md5sum": "9052de4cff7e8a18de586f785e711b97",
        "mode": "0664",
        "owner": "vagrant",
        "size": 11,
        "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1472991990.29-63683023616899/source",
        "state": "file",
        "uid": 500
    }
    192.168.61.12 | SUCCESS => {
        "changed": true,
        "checksum": "3160f8f941c330444aac253a9e6420cd1a65bfe2",
        "dest": "/tmp/test.txt",
        "gid": 500,
        "group": "vagrant",
        "md5sum": "9052de4cff7e8a18de586f785e711b97",
        "mode": "0664",
        "owner": "vagrant",
        "size": 11,
        "src": "/home/vagrant/.ansible/tmp/ansible-tmp-1472991990.26-218089785548663/source",
        "state": "file",
        "uid": 500
    }
  
</details>
