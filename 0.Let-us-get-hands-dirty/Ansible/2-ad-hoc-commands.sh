# Create a directory using Bash
mkdir /ansible

# Create a directory using Ansible
ansible localhost -m file -a "path=/ansible state=directory"

# Ping
ansible localhost -m ping

# Stat
ansible localhost -m stat -a "path=/ansible"

# Copy
ansible localhost -m copy -a "src=/ansible/info.md dest=/ansible/to-dos.md"

# Replace
ansible localhost -m replace -a "path=/ansible/to-dos.md regexp='^\[\s' replace='[x'"

# Debug and Lookup
ansible localhost -m debug -a "msg={{lookup('file', '/ansible/to-dos.md') }}"

# File
ansible localhost -m file -a "path=/ansible/to-dos.md state=absent"

# convert adhoc to ansible-playbook
ansible all -i <Public Ip Address>, -m ping


---
- hosts: localhost 1
  tasks: 2
  - name: create a directory 3
    file:
      path: /ansible/playbooks
      state: directory

---
- hosts: webservers 
        tasks:
        - name: deploy code to webservers 
                deployment:
                        path: {{ filepath }}
                        state: present
- hosts: dbserver
        tasks:
        - name: update database schema 
          updatedbschema:
                host: {{ dbhost }}
                state: present
- hosts: webservers
        tasks:
        - name: check app status page 
                deployment:
                        statuspathurl: {{ url }}
                        state: present

---
- hosts: all

  tasks:
  - name: run ping
    ping:

# to run the playbook
ansible-playbook docker-ping.yml -i inventory


# Replace the <Public Ip Address> with the actual
# Linux Instance or VM IP Address
ansible all -i <Public Ip Address>, -m ping

# Disable Host Key Checking
# Replace the <Public Ip Address> with the actual 
# Linux instance or VM IP Address
ansible all -i <Public Ip Address>, -m ping -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

# Replace the <Public Ip Address> with the actual 
# Linux instance or VM IP Address and 
# <Password> with your actual password
ansible all -i <Public Ip Address>, -m ping -e "ansible_user=ansible ansible_password=<Password> ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

# Replace <Password> with your Actual Password
# Replace <Public IP Address> with Windows Host IP Address
ansible all -i <Public IP Address>, -m win_ping -e "ansible_user=ansible ansible_password=<Password> ansible_winrm_server_cert_validation=ignore ansible_connection=winrm"