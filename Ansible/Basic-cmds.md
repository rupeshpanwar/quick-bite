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
