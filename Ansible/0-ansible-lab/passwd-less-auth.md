Checklist for setting up a passwordless remote user


1. [control-machine] Make sure to generate a key pair ( ./key is the private and ./key.pub is the public) by running ssh-keygen -f key

2. [control-machine] Make sure that the private key has the permission 400  ( chmod 400 key ).

3. [target-host] Create a user (.e.g: called ansibleuser ) on the target host ( e.g: adduser ansibleuser , or , useradd -m -d /home/ansibleuser -s /bin/bash ansibleuser )

4. [target-host] Check what's the home directory of the ansibleuser. Make sure he has a home directory

    getent passwd "ansibleuser" | cut -d: -f6

5. [target-host] Make sure that the login shell of the ansibleuser is NOT usr/sbin/nologin or /bin/false . Instead, it should be /bin/bash or /bin/sh ,... so on : 

    getent passwd "ansibleuser" | cut -d: -f7

6. [target-host] Make sure to place the CONTENT of the  public key (key.pub) under the home directory of the remote user and specially as content of the file  ${HOME}/.ssh/authorized_keys .

7. [target-host] .ssh/ directory and .ssh/authorized_keys must have the following permissions:

    chmod 700 ${HOME}/.ssh
    chmod 600 ${HOME}/.ssh/authorized_keys

8. [target-host] Make sure SSHD is running systemctl status sshd .

9. [target-host] Make sure that SSHD allows PublicKeyAuthentication by checking its config file: 

    grep PubkeyAuthentication /etc/ssh/sshd_config
    # must return: 'PubkeyAuthentication yes'

if it  is not the case, you need to update the configuration file /etc/ssh/sshd_config then restart SSH again systemctl restart sshd .

10. [control-machine] Make sure there is no firewall block the SSH communication

netcat -zv <ip.of.target.host> 22


11. [control-machine] Now let's try to connect : ssh -i key ansibleuser@<ip.of.target.host>

________

NOTES:

- If it does not work after following all these steps, keep running  ssh -i key ansibleuser@<ip.of.target.host> -vvvv  , checking the stdout (output of command) until making it work.