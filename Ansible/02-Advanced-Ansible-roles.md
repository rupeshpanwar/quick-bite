<details>
<summary>Roles</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/163502740-e5640636-8fb4-4aa6-8942-8b0fee4be3c8.png)

  ![image](https://user-images.githubusercontent.com/75510135/163502999-f6ef3b17-41d9-45ef-a0a0-9d51deb318c1.png) 

  ![image](https://user-images.githubusercontent.com/75510135/163502821-301cd594-5665-4211-a9a4-65dde77825fc.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/163502850-435e23ae-b86a-449d-868e-1b909b875c82.png)

  ![image](https://user-images.githubusercontent.com/75510135/163502953-9fe6b58d-2d0b-40ca-b8ee-bc32891dd14c.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503054-9e623f96-1488-4e8f-8bb5-2ae43df2bd70.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503121-9ca3f529-e4ad-465f-b89f-77471b8c8bf1.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503173-8ddad2ca-c9c7-4729-b6f1-99af61a9ca15.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503191-d60ebc06-fe70-4115-b7da-03ce53950f16.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503323-6cff205d-5a5f-4216-ba67-46c40a7c6f89.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503397-879ab6f1-7666-46df-bb70-b9bb0e137e0c.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503432-58be4a2f-e7a9-43ac-b3a4-a6c6cac92e4f.png)

  ![image](https://user-images.githubusercontent.com/75510135/163503458-7469f871-2cb1-4ce3-89bf-1ec32be1c216.png)

  
  
</details>


<details>
<summary>Problem Statement & Approach</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/163504077-8adf9bb4-5019-44ed-be39-315a18dc4df9.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504102-47a24fad-640e-41c1-8e71-acbfbd7c77b8.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504135-232c5b31-cb60-4119-b8b4-390c99511364.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504190-b15d503b-2ba5-4832-8ea2-522b57ac471c.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504222-7b072ba6-b336-42e7-9635-cf9d64eb8ff4.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504254-f2bd2e8a-2e6b-42e2-a002-412b19a0f0fc.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504289-e58bf6ff-970b-4669-a8d9-8b393cc8d336.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504328-eff56be9-7e32-4c7f-81e1-ef243d48f697.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504358-6c8447f6-b58e-4c03-ad9d-9601e2de8910.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504417-e97cf2a5-7f38-4492-b6c0-254bfc2823b2.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504574-b4abd62b-cb86-48fd-906c-f8b109a65128.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504609-58edfe5f-897f-4669-9685-c6c2145e77e9.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504630-0aba9b2c-c4d1-4506-81ea-52dbf2e4e126.png)

  ![image](https://user-images.githubusercontent.com/75510135/163504685-5adb2f1f-8bd9-4650-86cd-946d652cc693.png)

</details>


<details>
<summary>Target to specific hosts - Install and Start Apache Web Service</summary>
<br>
  
  Writing Tasks to Install and Start Apache Web Service

We are going to create three different tasks files, one for each phase of application lifecycle * Install * Configure * Start Service

To begin with, in this part, we will install and start apache.

    To install apache, Create roles/apache/tasks/install.yml

    ---
      - name: install apache web server
        yum:
          name: httpd
          state: installed

    To start the service, create roles/apache/tasks/service.yml with the following content

    ---
      - name: start apache webserver
        service:
          name: httpd
          state: started
          enabled: true

To have these tasks being called, include them into main task.

    Edit roles/apache/tasks/main.yml

    ---
    # tasks file for apache
      - import_tasks: install.yml
      - import_tasks: service.yml

Create and apply playbook to configure app servers
Create a playbook for app servers app.yml with following contents

      ---
      - hosts: app
        become: true
        roles:
          - apache

    Apply app.yml with ansible-playbook

      ansible-playbook app.yml

[Output]

    PLAY [Playbook to configure App Servers] *********************************************************************
     
    TASK [setup] *******************************************************************
    ok: [192.168.61.12]
    ok: [192.168.61.13]
     
    TASK [apache : Install Apache...] **********************************************
    changed: [192.168.61.13]
    changed: [192.168.61.12]
     
    TASK [apache : Starting Apache...] *********************************************
    changed: [192.168.61.13]
    changed: [192.168.61.12]
     
    PLAY RECAP *********************************************************************
    192.168.61.12              : ok=3    changed=2    unreachable=0    failed=0
    192.168.61.13              : ok=3    changed=2    unreachable=0    failed=0



</details>

<details>
<summary>Notification & Handlers </summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/163506034-cb9950eb-da5c-4f6b-9f5a-f0280677aff8.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506090-c372454c-1115-4698-b9e1-ce4864cf5dc9.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506170-d4c7cc06-3f8c-45c6-8770-14cb8b6e875e.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506195-aac660bb-f033-4fe2-9a3b-5be103367118.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506220-6bfbd1d7-352e-49af-8641-fbd8363064ea.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506249-d5d7a70c-7e61-48c9-b786-06d93f8ba908.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506268-82c0b050-8068-4749-99a9-2587f8c7307e.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506291-15bc04d3-7bbd-4623-af51-8d33d65c5d90.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506346-80739689-5220-46af-9245-2890e0658be7.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506367-3a84cf15-674b-4e89-be7c-c5e3eef5df6f.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506442-3dd870b0-2d14-426d-a476-f20ada18ac73.png)

  ![image](https://user-images.githubusercontent.com/75510135/163506498-a0d76afe-0695-4475-8a4a-81d9e170fe65.png)

  Managing Configurations

    Copy index.html and httpd.conf from chap6/helper to /roles/apache/files/ directory

       cd chap6
       cp helper/httpd.conf roles/apache/files/  

    Create a task file at roles/apache/tasks/config.yml to copy the configuration file.

    ---
      - name: copy over httpd configs
        copy:
          src: httpd.conf
          dest: /etc/httpd.conf
          owner: root
          group: root
          mode: 0644
     

Adding Notifications and Handlers

    Previously we have create a task in roles/apache/tasks/config.yml to copy over httpd.conf to the app server. Update this file to send a notification to restart service on configuration update. You simply have to add the line which starts with notify

    ---
      - name: copy over httpd configs
        copy:
          src: httpd.conf
          dest: /etc/httpd.conf
          owner: root
          group: root
          mode: 0644
        notify: Restart apache service

    Create the notification handler by updating roles/apache/handlers/main.yml

    ---
      - name: Restart apache service
        service: name=httpd state=restarted

Update tasks/main.yml to call the newly created tasks file.

    ---
    # tasks file for apache
      - import_tasks: install.yml
      - import_tasks: service.yml
      - import_tasks: config.yml

Apply and validate if the configuration file is being copied and service restarted.

     ansible-playbook app.yml
</details>

<details>
<summary>Exercise - Role - install Php</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/163507115-1d184f41-8207-47b1-b1dd-af3021a479bc.png)

  ![image](https://user-images.githubusercontent.com/75510135/163507189-c6faf639-0a50-4344-b643-0908c35d76e4.png)

  ![image](https://user-images.githubusercontent.com/75510135/163507274-32b52e0e-6aab-4459-9e2f-003caba70566.png)

  ![image](https://user-images.githubusercontent.com/75510135/163507321-7f8465de-a059-483e-8e28-af55f62b04c5.png)

  ![image](https://user-images.githubusercontent.com/75510135/163507422-cd31d698-ad91-4ef4-89ac-91abd209321d.png)

  Create a role to install php

Generate roles scaffold

    ansible-galaxy init --offline --init-path=roles  php

roles/php/tasks/install.yml

    ---
    # install php related packages
      - name: install php
        package:
          name: "{‌{ item }}"
          state: installed
        with_items:
          - php
          - php-mysql
        notify: Restart apache service

file: roles/php/tasks/main.yml

    ---
    # tasks file for php
    - import_tasks: install.yml

Update app.yml playbook to invoke php role.

file: app.yml

      ---
      - hosts: app
        become: true
        roles:
          - apache
          - php

Apply the playbook

    ansible-playbook app.yml



</details>


<details>
<summary>Exercise- System role and sitewide playbook</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/163510583-e8bf2a65-f083-4c4e-aa8c-ced539ae1390.png)

  ![image](https://user-images.githubusercontent.com/75510135/163510626-a7aa25e4-374b-4072-88a1-935f761676d0.png)

  ![image](https://user-images.githubusercontent.com/75510135/163510661-069d694b-ea94-4b03-b895-166a299c78bf.png)

  ![image](https://user-images.githubusercontent.com/75510135/163510701-9b9b5a7a-3981-447c-8d27-75bd57dbca93.png)

  ![image](https://user-images.githubusercontent.com/75510135/163510739-a65ba31d-b5d7-49e8-8bf6-d707d8691a1a.png)

  ![image](https://user-images.githubusercontent.com/75510135/163510827-ebb1ec03-9129-4e70-8d40-48a633c1a099.png)

  Systems role, dependencies and nested roles

You have already written a playbook to define common systems configurations. Now, go ahead and refactor it so that instead of calling tasks from playbook itself, it goes into its own role, and then call on each server.

    Create a base role with ansible-galaxy utility,

      ansible-galaxy init --offline --init-path=roles systems

    Copy over the tasks from systems.yml and lets just add it to /roles/base/tasks/main.yml

    ---
    # tasks file for systems
      - name: remove user dojo
        user: >
          name=dojo
          state=absent
     
      - name: install tree utility
        yum: >
          name=tree
          state=present
     
      - name: install ntp
        yum: >
          name=ntp
          state=installed

    Define systems role as a dependency for apache role,

    Update meta data for Apache by editing roles/apache/meta/main.yml and adding the following

    ---
    dependencies:
     - {role: systems}

Next time you run app.yml, observe if the above tasks get invoked as well.

Creating a Site Wide Playbook

We will create a site wide playbook, which will call all the plays required to configure the complete infrastructure. Currently we have a single playbook for App Servers. However, in future we would create many.

    Create site.yml in /vagrant/chap5 directory and add the following content

      ---
      # This is a sitewide playbook
      # filename: site.yml
      - import_playbook: app.yml

    Execute sitewide playbook as

    ansible-playbook site.yml

[Output]

    PLAY [Playbook to configure App Servers] ***************************************
     
    TASK [setup] *******************************************************************
    ok: [192.168.61.12]
    ok: [192.168.61.13]
     
    TASK [base : create admin user] ************************************************
    ok: [192.168.61.12]
    ok: [192.168.61.13]
     
    TASK [base : remove dojo] ******************************************************
    ok: [192.168.61.12]
    ok: [192.168.61.13]
     
    TASK [base : install tree] *****************************************************
    ok: [192.168.61.13]
    ok: [192.168.61.12]
     
    TASK [base : install ntp] ******************************************************
    ok: [192.168.61.13]
    ok: [192.168.61.12]
     
    TASK [base : start ntp service] ************************************************
    ok: [192.168.61.13]
    ok: [192.168.61.12]
     
    TASK [apache : Installing Apache...] *******************************************
    ok: [192.168.61.13]
    ok: [192.168.61.12]
     
    TASK [apache : Starting Apache...] *********************************************
    ok: [192.168.61.13]
    ok: [192.168.61.12]
     
    TASK [apache : Copying configuration files...] *********************************
    ok: [192.168.61.12]
    ok: [192.168.61.13]
     
    TASK [apache : Copying index.html file...] *************************************
    ok: [192.168.61.12]
    ok: [192.168.61.13]
     
    PLAY RECAP *********************************************************************
    192.168.61.12              : ok=10   changed=0    unreachable=0    failed=0
    192.168.61.13              : ok=10   changed=0    unreachable=0    failed=0


</details>


<details>
<summary>Nano Project </summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/163511100-b4a2dc8e-4fc6-4e20-9737-14bf9c390479.png)

  - PHP App Source  GitHub https://github.com/devopsdemoapps/devops-demo-app 
  - AppReleases GitHub https://github.com/devopsdemoapps/devops-demo-app/releases
  
  Please paste the contents of  main.yaml task file from frontend role that you have added.

file: roles/frontend/tasks/main.yml
  ---

# tasks file for frontend

  - import_tasks: install.yml

  - import_tasks: service.yml
  
  ---
- name: create release directory  structure 
  file:
    path: /opt/app/release
    state: directory
    mode: 0755
    recurse: true

- name: install unzip 
  package: 
    name: unzip
    state: installed

- name: download and extract a release 
  unarchive:
    src: https://github.com/devopsdemoapps/devops-demo-app/archive/1.2.zip
    dest: /opt/app/release
    remote_src: yes
 

- name: setup symlinks 
  file:
    src: /opt/app/release/devops-demo-app-1.2
    dest: /var/www/html/app
    state: link
  
</details>

