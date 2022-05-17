#!/bin/bash
sudo adduser ansible
sudo echo "{{ password }}" | passwd --stdin ansible
echo 'ansible        ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
sudo sed -n 'H;${x;s/\PasswordAuthentication no/PasswordAuthentication yes/;p;}' /etc/ssh/sshd_config > tmp_sshd_config
sudo cat tmp_sshd_config > /etc/ssh/sshd_config
rm -f tmp_sshd_config
sudo service sshd restart