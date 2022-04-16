<details>
<summary>Why , What - Roles</summary>
<br>

  <img width="933" alt="image" src="https://user-images.githubusercontent.com/75510135/163664012-17104fbe-e2e6-4909-b6af-ede1d454fe55.png">

  <img width="924" alt="image" src="https://user-images.githubusercontent.com/75510135/163664039-c732456f-191e-4304-89dd-79ef0a5dfa87.png">

  <img width="975" alt="image" src="https://user-images.githubusercontent.com/75510135/163664049-96fe55c1-c5b9-4463-a47a-72cf0958691a.png">

  
</details>

<details>
<summary>Get your hands dirty- convert tasks to roles</summary>
<br>

  - pick the code from https://github.com/rupeshpanwar/ansible-advance.git , commit # 025d3da..789e97f , branch - main
  - create new branch roles
  > git checkout -b roles
  - create new dir roles / mysql_db
  > ansible-galaxy init mysql_db
  <img width="281" alt="image" src="https://user-images.githubusercontent.com/75510135/163664693-e758e2d9-fc71-4c0c-8f7b-55fedb004a18.png">
  - move code from tasks/deploy_db.yml to mysql_db/tasks/main.yml
  <img width="1105" alt="image" src="https://user-images.githubusercontent.com/75510135/163664763-fddd3d28-07b3-4035-b5ac-e9a9ff3daf9f.png">

  - similiary, create role for flask_web and move the code from tasks/deploy_web.yml to roles/flask_web/tasks/main.yml
  > ansible-galaxy init flask_web
  <img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/163664824-01e4ba7d-af0d-485a-b3ef-e1325ad27f6f.png">
 - feel free to delete tasks dir
 - create one more role to install python dependency and mentioned under playbook.yml in the tasks section
  <img width="896" alt="image" src="https://user-images.githubusercontent.com/75510135/163664882-4554738e-ca7e-4a5f-a109-948bb7fa01eb.png">
  <img width="614" alt="image" src="https://user-images.githubusercontent.com/75510135/163664894-d6a421d7-94fe-4975-89cd-ef8350dbc968.png">

  - finally, include roles section into playbook.yml , in specific order to execute
  <img width="683" alt="image" src="https://user-images.githubusercontent.com/75510135/163664949-ffe4514b-a03a-4f75-9d5b-9cffd8418717.png">

  - when ansible-playbook is run, note down the console output where it mention role name and underlying task attached to that role
  <img width="1044" alt="image" src="https://user-images.githubusercontent.com/75510135/163665024-ed2bf077-45ef-4ea6-9417-40f1b021c414.png">

  
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
