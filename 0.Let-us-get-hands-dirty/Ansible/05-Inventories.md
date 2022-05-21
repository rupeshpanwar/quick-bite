<details>
<summary>Introduction to Inventories</summary>
<br>

![](i/20220518102952.png)  
![](i/20220518103052.png)  
![](i/20220518103115.png)  
![](i/20220518103146.png)  
![](i/20220518103203.png)  
![](i/20220518103223.png)  
![](i/20220518103241.png)  
![](i/20220518103257.png)  
![](i/20220518103330.png)  
![](i/20220518103353.png)  

* hosts
```
db01 database_name=customerdb
hostname.domain.com ansible_user=ansible ansible_password=<Password>
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[webservers]
web01
web02
web03
[dbservers]
db01

[webserver:vars] 
http_port=8080

#azure
vm-linuxweb001.eastus.cloudapp.azure.com ansible_user=ansible ansible_password=<Password> ansible_ssh_common_args='-o StrictHostKeyChecking=no' 

#aws
ec2-50-16-43-189.compute-1.amazonaws.com ansible_user=ansible ansible_password=<Password> ansible_ssh_common_args='-o StrictHostKeyChecking=no'

#azure
vm-winweb001.eastus.cloudapp.azure.com ansible_user=ansible ansible_password=<Password> nsible_winrm_server_cert_validation=ignore ansible_connection=winrm ansible_winrm_transport=ntlm 

#aws
ec2-50-16-43-189.compute-1.amazonaws.com ansible_user=ansible ansible_password=<Password> nsible_winrm_server_cert_validation=ignore ansible_connection=winrm ansible_winrm_transport=ntlm
```
ansible webserver -i hosts -m ping



</details>

<details>
<summary>Use Groups</summary>
<br>

![](i/20220519102316.png)  
![](i/20220519102339.png)  
![](i/20220519102407.png)  
![](i/20220519102431.png)  
```
[linux:vars]
ansible_user=ansible
ansible_password=<Password> 
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[linux] 
vm-linuxweb001.eastus.cloudapp.azure.com 
ec2-54-211-23-17.compute-1.amazonaws.com

[windows:vars]
ansible_user=ansible 
ansible_password=<Password> 
ansible_winrm_server_cert_validation=ignore 
ansible_connection=winrm

[windows] 
vm-winweb001.eastus.cloudapp.azure.com 
ec2-3-231-5-122.compute-1.amazonaws.com
```

![](i/20220519102540.png)  
![](i/20220519102600.png)  

```
---
  - hosts: all
    
    tasks:
    - name: run ping
      ping:
```

```
---
  - hosts: all
    gather_facts: false
  
    tasks:
    - name: run win_ping
      win_ping:
```
```
---
  - hosts: slave
    
    tasks:
    - name: run ping
      ping:
```

```
---
  - hosts: windows
    gather_facts: false
  
    tasks:
    - name: run win_ping
      win_ping:
```

> ansible-playbook ping_novars.yml -i hosts --limit linux
> ansible-playbook win_ping_novars.yml -i hosts --limit windows
 

</details>

<details>
<summary>Organize Hosts and Group Variables</summary>
<br>

![](i/20220521104141.png)  
![](i/20220521104203.png)  
![](i/20220521104226.png)  
![](i/20220521104246.png)  
![](i/20220521104307.png)  
![](i/20220521104325.png)  
![](i/20220521104342.png)  
```
# Review the hosts file
cat hosts

# Create the host_vars directory
mkdir host_vars

# Change into host_vars directory
cd host_vars

# Replace the <LinuxHostDNSname> with the actual domain name
touch <LinuxHostDNSname>.yml

# Replace the <LinuxHostDNSname> with the actual domain name
# Replace the <Public IP Address> with the actual hosts IP Address
echo "ip: <Public IP address>" > <LinuxHostDNSname>.yml

# Replace the <WindowsHostDNSname> with the actual domain name
touch <WindowsHostDNSname>.yml

# Replace the <WindowsHostDNSname> with the actual domain name
# Replace the <Public IP Address> with the actual hosts IP Address
echo "ip: <Public IP address>" > <WindowsHostDNSname>.yml

# Change into the parent directory
cd ..

# Directory structure
tree

# ansible all -i hosts -m debug -a "var=ip"
ansible all -i hosts -m debug -a "var=ip"

# List the hosts and the variables
ansible-inventory -i hosts --list
```
rganized your host and group variables to keep your inventories clean as the number of variables grows. You created group_vars and host_vars as Ansible searches for the respective directories’ variables.

![](i/20220521104642.png)  
![](i/20220521104700.png)  
![](i/20220521104714.png)  
![](i/20220521104728.png)  

</details>

<details>
<summary>Secrets with Ansible Vault: Use Encrypted Files</summary>
<br>

![](i/20220521124351.png)  
![](i/20220521124414.png)  
![](i/20220521124436.png)  
![](i/20220521124500.png)  
![](i/20220521124517.png)  
![](i/20220521124536.png)  
![](i/20220521124552.png)  
![](i/20220521124609.png)  
![](i/20220521124627.png)  
```
# Encrypt linux.yml
ansible-vault encrypt group_vars/linux.yml

# View encrypted contents
cat group_vars/linux.yml

# Edit linux.yml with Ansible vault
ansible-vault edit group_vars/linux.yml

# Encrypt windows.yml
ansible-vault encrypt group_vars/windows.yml

# View encrypted contents
ansible-vault view group_vars/windows.yml

# Verify the variables are loading
ansible-inventory -i hosts --list --ask-vault-pass

# execute the ping_novars.yml playbook
ansible-playbook ping_novars.yml -i hosts --ask-vault-pass

# execute the win_ping_novars.yml playbook
ansible-playbook win_ping_novars.yml -i hosts --ask-vault-pass

# Decrypt files
#Linux
ansible-vault decrypt group_vars/linux.yml

# Windows
ansible-vault decrypt group_vars/windows.yml
```

Using Ansible Vault to encrypt the entire file works excellent! You can now feel good about committing the code to source control, knowing that your password is encrypted. The only downside is that you can’t view the contents without using the following options of the ansible-vault command:

    decrypt
    view
    edit

Ansible Vault to secure your secrets using the encrypted files method. We looked into the following options that the ansible-vault command provides:

    encrypt
    edit
    view
    decrypt


</details>


 
<details>
<summary>Secrets with Ansible Vault: Use Encrypted Strings</summary>
<br>

![](i/20220521125904.png)  
![](i/20220521125926.png)  
![](i/20220521125959.png)  
![](i/20220521130023.png)  
![](i/20220521130041.png)  
ou can encrypt only the secret variables instead of the entire file. We looked at the following option with the ansible-vault command:

    encrypt_string
    debug

```
# Encrypt ansible password
echo -n '<Password>' | ansible-vault encrypt_string --stdin-name 'ansible_password'
# OR
ansible-vault encrypt_string --stdin-name 'ansible_password'

## Replace the ansible password in linux.yml and windows.yml files.

# Verify variables
ansible-inventory -i hosts --list --ask-vault-pass

# Decrypt ansible_password
ansible all -i hosts -m debug -a "var=ansible_password" --ask-vault-pass
```
</details>
