Install Ansible

Installing Ansible means installing Ansible CLI (Command line interface).

We have covered this topic in the previous lecture ( Lecture 6), and specially starting from the minute 8:39, we explained there how to install Ansible CLI.

However, in order to make it easy for you, i will summarize here all what's required in order to install Ansible for any OS : 
1. MacOS :

    # python3 & pip are installed
    ```
    brew install python3
    curl -O https://bootstrap.pypa.io/get-pip.py
    sudo python3 get-pip.py
     
    # install ansible
    sudo pip3 install ansible --upgrade
    # or try:  pip3 install ansible --upgrade --user
    ```

2. Ubuntu (18.04 or later)
```
    # python3 & pip are installed
    sudo apt update -y
    sudo apt install python3-pip
     
    # install ansible
    sudo pip3 install ansible --upgrade
    # or try:  pip3 install ansible --upgrade --user
```

3. Windows

( Ansible as CLI is installed on the control machine, and the control machine must be a Linux Machine. The workaround with Windows is to install WSL before (WSL stands for Windows Subsystem Linux)

a. Install WSL 2 ( Follow the Official Documentation here )

b. If you choose to install Ubuntu as distribution for WSL, commands above about Ubuntu (2) are still valid.


4. CentOS

    # option 1: to install pip3
    sudo yum install --assumeyes python3-pip
    # option 2: to install pip3
    # if above command does not work, try the following:
    sudo yum install python36
    sudo yum update python-devel
    sudo yum install python36-devel
    sudo easy_install-3.6 pip
     
    # install ansible
    sudo pip3 install ansible --upgrade
    # or try:  pip3 install ansible --upgrade --user


5. Enterprise Linux (RHEL 7)


    subscription-manager repos --enable rhel-7-server-ansible-2-rpms
    sudo yum install -y ansible

Note, that Red Hat (as Company) can deprecate its repository(ies) any time.

Accordingly, if you purchase a subscription from Red Hat, I assume that you know the process.


6. Run it with Docker


If you have already docker installed, you can run ansible without installing anything, but just selecting the right container image.

In the following commands, we are using the container image abdennour/ansible.


    alias ansible='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/code -w /code abdennour/ansible:2.9.6 ansible'
     
    alias ansible-playbook='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/code -w /code abdennour/ansible:2.9.6 ansible-playbook'
     
    alias ansible-inventory='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/code -w /code  abdennour/ansible:2.9.6 ansible-inventory'
     
    alias ansible-galaxy='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/code -w /code abdennour/ansible:2.9.6 ansible-galaxy'
     
    alias ansible-doc='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/code -w /code abdennour/ansible:2.9.6 ansible-doc'
