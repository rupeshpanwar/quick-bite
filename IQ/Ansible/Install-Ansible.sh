sudo apt update

sudo apt install ansible

ansible --version

# inventory file is located at /etc/ansible/hosts

# setting the custom hosts file path 
export ANSIBLE_INVENTORY=/path/to/hosts.ini

# example, to test connectivity to a host named myhost, run:

ansible myhost -m ping


# generate ssh key pair
ssh-keygen -t rsa -b 4096

#This will generate a public key (id_rsa.pub) and a private key (id_rsa) in the ~/.ssh directory.

# copy pub to target host
ssh-copy-id target_host

# public key will be added to the ~/.ssh/authorized_keys

# test ssh connection
ssh target_host


# Ansible cmds
ansible-playbook -i hosts.ini playbook.yml
