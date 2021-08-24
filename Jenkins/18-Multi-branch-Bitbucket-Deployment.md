# Bitbucket(BB) repo
- create workspace(WS) in BB , notedown the name of WS
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130612886-d0d47138-83df-4907-9172-5981edcf1cf9.png">
- create a project under WS
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130612967-3a5b9cd5-2a7e-4e14-92ed-267ecdc0aa40.png">
- create repo with multi-branch
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613055-80d71fc5-c80f-4cae-892d-032b986671d8.png">
# Jenkin, project configuration
- Manage Jenkins, System configuration , configure Bitbucket cloud setting along with user name to login into BB
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130616355-f0728f95-e5fb-435e-9f5a-0572493bcb5c.png">

- click on New item , create a multibranch pipeline
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613452-735cbf5c-3951-4e5b-8d35-09f183de6061.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613573-5d0a0905-a3ea-43c6-bdec-378efccf0d37.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613545-4a1769c0-b3a8-4d4f-821e-55ba66c01e17.png">

- under branch source , add source (Bitbucket)
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613731-91819df5-bde0-4f40-bc57-cfd92d580e68.png">
- add the creds for BB, user name can  be copied from BB
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613849-daa3876d-c18b-4697-9abc-756cf3916ab8.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130613939-2f4954a1-52d4-4a24-9939-7ed40002c29f.png">

- owner , is workspace name(under which project is created)
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130614243-6d48b9a4-b4d9-400e-ab2c-6cc48727762b.png">

- pick the repo to configured
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130614455-51dd3cf1-c165-40bf-8a7a-6bd048cc594d.png">

- under Behavior , modify the strategy as selected below in the screenshot
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130614550-ae8e0039-66f8-4bc4-a784-af5e65a06dc5.png">

- click Add, pick option, Filter by name (with wildcards)
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130614635-ab438683-3d35-4fb2-adb8-53a339b8fc2a.png">

- here mention feature branch name(starting few letters of the feature branch)
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130614807-0075429d-be9a-42dc-873b-7ad8349e043b.png">

- under Build configuration, select option , Periodically if not otherwise run , mention 5 mins
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130614890-e6f78558-f539-4c93-ae1a-d672bea909c6.png">

- click on Save 
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130615030-d188d199-1bba-4247-981d-e5c01dc97aa8.png">

- as soon as job starts running , it pulls the information matching above criteria
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130615128-f2255b5f-935e-477c-9464-e67d5ae8d53a.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130615167-e89b8751-fbf4-4be4-bbe6-223960cba3c5.png">

- click on job, Multi branch deployment , in the dashboard
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130615263-b07e3d83-8dac-46b8-b21e-cde4d3cb87c1.png">

- it lists result for run for individual branch
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130615361-6a7b2dc1-5ba2-4e4d-a959-d249050370cc.png">

- click on individual branch to check the result
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130615420-a9560fed-3f5e-4cb2-a01e-da369aa35239.png">
<img width="1261" alt="image" src="https://user-images.githubusercontent.com/75510135/130616001-dfd9fdf4-567d-4fa5-b269-c0abc8621f26.png">







