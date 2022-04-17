<details>
<summary>Lookup - Introduction</summary>
<br>

  <img width="946" alt="image" src="https://user-images.githubusercontent.com/75510135/163673055-808c9eef-f872-44bd-ab93-b061ffa034b2.png">

  <img width="930" alt="image" src="https://user-images.githubusercontent.com/75510135/163673064-0610fb72-5fb1-46de-873b-3355baa0f7fd.png">

  
</details>

<details>
<summary>Lookup - Practice</summary>
<br>

  - Lookup password in csvfile
  <img width="951" alt="image" src="https://user-images.githubusercontent.com/75510135/163673099-01f754f9-a16a-4229-be74-27a1dae60dfa.png">

  <img width="714" alt="image" src="https://user-images.githubusercontent.com/75510135/163673108-575e87a6-c9dc-4e21-a33b-bf45b5c3e9f8.png">

  ```
  -
  name: Test Connectivity
  hosts: web_server
  vars:
    ansible_ssh_pass: "{{ lookup('csvfile', 'web_server file=credentials.csv delimiter=,') }}"
  tasks:
  - name: Ping target host
    ping:
      data: "Test"
  ```
  
  - Now try with INI file
  <img width="955" alt="image" src="https://user-images.githubusercontent.com/75510135/163673200-8a700660-511d-4be8-854a-b001c1b8121e.png">

  <img width="758" alt="image" src="https://user-images.githubusercontent.com/75510135/163673222-8dd0d5e2-97c4-4308-99f0-91de78bf852a.png">

  ```
  -
  name: Test Connectivity
  hosts: web_server
  vars:
    ansible_ssh_pass: "{{ lookup('ini', 'password section=web_server file=credentials.ini') }}"
  tasks:
  - name: Ping target host
    ping:
      data: "Test"
  ```
  
</details>

<details>
<summary>Vault</summary>
<br>

  <img width="885" alt="image" src="https://user-images.githubusercontent.com/75510135/163697940-cb6e8efd-fe8a-439c-9e1c-80658b84efd6.png">

  <img width="965" alt="image" src="https://user-images.githubusercontent.com/75510135/163698020-a670527b-cf15-496f-ae26-1b63d15f95c8.png">

</details>
