<details>
<summary>Introction</summary>
<br>
  
  <img width="759" alt="image" src="https://user-images.githubusercontent.com/75510135/163665914-f1fdc2ff-dc36-4df1-9228-37430a759d1e.png">

  
</details>

<details>
<summary>How to setup</summary>
<br>

  <img width="860" alt="image" src="https://user-images.githubusercontent.com/75510135/163665933-0d9f79e7-dd64-49ae-8b18-be0b20c70598.png">

  <img width="866" alt="image" src="https://user-images.githubusercontent.com/75510135/163665950-1f82ff3f-e0aa-4852-8dd5-217ec920c007.png">

  <img width="915" alt="image" src="https://user-images.githubusercontent.com/75510135/163665961-e2a34055-555a-42f8-b7b8-fc0f163c9555.png">

  - real time example
 ```
 - name: Deploy a mysql DB
  hosts: db_server
  roles:
    - python
    - mysql_db


- name: Deploy a Web Server
  hosts: web_server
  roles:
    - python
    - flask_web

- name: Monitor Web Application for 6 Minutes
  hosts: web_server
  command: /opt/monitor_webapp.py
  async: 360
  poll: 0
  register: webapp_result

- name: Monitor Database for 6 Minutes
  hosts: db_server
  command: /opt/monitor_database.py
  async: 360
  poll: 0
  register: database_result
 ``` 
</details>


<details>
<summary>Strategy</summary>
<br>

  <img width="699" alt="image" src="https://user-images.githubusercontent.com/75510135/163668784-e80b7de8-214b-45c0-ba4b-4312152cd392.png">

  <img width="962" alt="image" src="https://user-images.githubusercontent.com/75510135/163668803-4f2049fa-bf8d-4f38-80e6-6d92bc94ae51.png">

  <img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/163668828-195c0f75-1054-43b9-b126-83f27f92edd7.png">

  <img width="943" alt="image" src="https://user-images.githubusercontent.com/75510135/163668846-90bb555b-dc7e-42de-8450-801c32ef0e3c.png">

  <img width="793" alt="image" src="https://user-images.githubusercontent.com/75510135/163668867-96c0dbfd-06fb-478d-9d8e-35016a58cec0.png">

  
  
</details>

<details>
<summary>Practice - Strategy</summary>
<br>

  - rolling upgrade
  ```
  -
  name: Deploy a web application
  hosts: app_servers
  serial:
    - 2
    - 3
    - 5
  ```
  - 20% at a time
  ```
  -
  name: Deploy a web application
  hosts: app_servers
  serial: "20%"
  vars:
  ```
  - as fast as can
  ```
    name: Deploy a web application
  hosts: app_servers
  strategy: free
  vars:
    db_name: employee_db
    db_user: db_user
    db_password: Passw0rd
  tasks:
  ```
</details>

