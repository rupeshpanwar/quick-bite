<details>
<summary>Introduction</summary>
<br>

  <img width="644" alt="image" src="https://user-images.githubusercontent.com/75510135/163671928-41ad6009-32a5-4e59-bd32-75597a593f56.png">

  <img width="864" alt="image" src="https://user-images.githubusercontent.com/75510135/163671935-660baade-8e2d-451d-a2d8-bf6e68cbd016.png">

  <img width="1000" alt="image" src="https://user-images.githubusercontent.com/75510135/163671950-52abcd05-9c5b-4bba-a447-a1f070af05ae.png">

  <img width="900" alt="image" src="https://user-images.githubusercontent.com/75510135/163671959-cb731ddf-91ac-4492-90f7-4a4af5b61db6.png">

  <img width="885" alt="image" src="https://user-images.githubusercontent.com/75510135/163671969-f8e0d1e1-30da-4398-9c34-f1e8448f7102.png">

  <img width="955" alt="image" src="https://user-images.githubusercontent.com/75510135/163671992-329b1cc6-4cf9-43d4-a45e-06fec91ba511.png">

</details>

<details>
<summary>Exercise time</summary>
<br>

  - print debug
  <img width="889" alt="image" src="https://user-images.githubusercontent.com/75510135/163672041-0ed2de18-4cbf-4700-ae48-ae499d421d9b.png">

  ```
    - name: Test Jinja2 Templating
    hosts: localhost
    vars:
      first_name: james
      last_name: bond
    tasks:
    - debug:
        msg: 'The name is {{ last_name }}! {{ first_name }} {{ last_name }}!'
  ```
  - apply filter | BOLD
  <img width="803" alt="image" src="https://user-images.githubusercontent.com/75510135/163672493-9b46784f-10cb-487c-8360-a475baf220f1.png">

  ```
    - debug:
      msg: 'The name is {{ last_name | title }}! {{ first_name | title }} {{ last_name | title }}!'
  ```
  - print MIN in a given array
  <img width="919" alt="image" src="https://user-images.githubusercontent.com/75510135/163672557-a7328cfc-237a-479d-893f-4c76e7ad0c36.png">

  ```
  -
  name: Test Jinja2 Templating
  hosts: localhost
  vars:
    array_of_numbers:
      - 12
      - 34
      - 06
      - 34
  tasks:
  - debug:
      msg: 'Lowest = {{ array_of_numbers | min }}'
  ```
  - apply UNION in list of dependency
  <img width="947" alt="image" src="https://user-images.githubusercontent.com/75510135/163672636-04fb9843-a6de-4179-bdca-86288ab0b19a.png">

  ```
  -
  name: Install Dependencies
  hosts: localhost
  vars:
    web_dependencies:
         - python
         - python-setuptools
         - python-dev
         - build-essential
         - python-pip
         - python-mysqldb
    sql_dependencies:
         - python
         - python-mysqldb
  tasks:
  - name: Install dependencies
    apt: name='{{ item }}' state=present
    with_items: '{{ sql_dependencies | union(web_dependencies) }}'
  ```
  
  - RANDOM FILE NAME
  <img width="926" alt="image" src="https://user-images.githubusercontent.com/75510135/163672745-1b1c9249-047c-448a-828a-6370bb608783.png">

  ```
  -
  name: Generate random file name
  hosts: localhost
  tasks:
  - name: Create file
    file:
      path: /tmp/random_file"{{ 1000 | random }}"
      state: touch
  ```
  
  - Valid IPADDRESS
  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/163672778-28e322e7-3c45-4dd9-8074-16528527c406.png">

  ```
  - name: Test valid IP Address
  hosts: localhost
  vars:
    ip_address: 192.168.1.6
  tasks:
  - name: Test IP Address
    debug:
      msg: IP Address = {{ ip_address | ipaddr }}
  ```
</details>

