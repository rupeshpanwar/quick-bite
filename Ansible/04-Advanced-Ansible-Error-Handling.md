<details>
<summary>Introduction</summary>
<br>

  <img width="875" alt="image" src="https://user-images.githubusercontent.com/75510135/163671261-e538190a-e42e-4d52-a253-a61a9724946d.png">

  <img width="959" alt="image" src="https://user-images.githubusercontent.com/75510135/163671322-645efa2a-a34a-48b5-b89d-f5a4c3888cfe.png">

  <img width="891" alt="image" src="https://user-images.githubusercontent.com/75510135/163671281-5ca8c184-3384-4226-9739-707a469cf575.png">

  <img width="865" alt="image" src="https://user-images.githubusercontent.com/75510135/163671301-104b33ba-84ca-48c1-96e0-2ffc2d494c36.png">

  
</details>
<details>
<summary>Let us do it </summary>
<br>
  
  - stop the execution as soon as error strikes
  ```
  - name: Deploy a web application
    hosts: app_servers
    any_errors_fatal: true
  ```
  - 2nd scenario
  <img width="941" alt="image" src="https://user-images.githubusercontent.com/75510135/163671438-8398292b-11a2-4e23-af35-abfe14e7bace.png">

  ```
  -
  name: Deploy a web application
  hosts: app_servers
  any_errors_fatal: true
  vars:
    db_name: employee_db
    db_user: db_user
    db_password: Passw0rd
  tasks:
    - name: Install dependencies
      apt: name={{ item }} state=present
      with_items:
       - python
       - python-setuptools
       - python-dev
       - build-essential
       - python-pip
       - python-mysqldb

    - name: Install MySQL database
      apt:
        name: "{{ item }}"
        state:  present
      with_items:
       - mysql-server
       - mysql-client

    - name: Start Mysql Service
      service:
        name: mysql
        state: started
        enabled: yes

    - name: Create Application Database
      mysql_db: name={{ db_name }} state=present

    - name: Create Application DB User
      mysql_user: name={{ db_user }} password={{ db_password }} priv='*.*:ALL' host='%' state='present'

    - name: Install Python Flask dependencies
      pip:
        name: '{{ item }}'
        state: present
      with_items:
       - flask
       - flask-mysql

    - name: Copy web-server code
      copy: src=app.py dest=/opt/app.py

    - name: Start web-application
      shell: FLASK_APP=/opt/app.py nohup flask run --host=0.0.0.0 &

    - name: "Send notification email"
      mail:
        to: devops@corp.com
        subject: Server Deployed!
        body: Web Server Deployed Successfully
      ignore_errors: yes
  ```
</details>

