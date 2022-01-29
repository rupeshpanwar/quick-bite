- How filebeat works
<img width="826" alt="image" src="https://user-images.githubusercontent.com/75510135/150622396-36b22acc-6c1b-41bb-9100-3cb6b0b8bfc1.png">
- log source
<img width="660" alt="image" src="https://user-images.githubusercontent.com/75510135/150622449-bb1d5ac9-5e21-468c-83ff-51f3e18490fc.png">
<img width="944" alt="image" src="https://user-images.githubusercontent.com/75510135/150622473-a7bb9908-659a-443f-8cce-e33e91e889dd.png">
<img width="846" alt="image" src="https://user-images.githubusercontent.com/75510135/150622482-7ce8a3dd-55d7-4689-88a2-1973fb99e963.png">
- filebeat registry
<img width="771" alt="image" src="https://user-images.githubusercontent.com/75510135/150622543-1b20982e-a691-4534-93ab-bf304a2f530d.png">
- deliverying the events/data
<img width="739" alt="image" src="https://user-images.githubusercontent.com/75510135/150622623-d9b1def3-2606-47c8-8f1f-9903c615e048.png">
<img width="703" alt="image" src="https://user-images.githubusercontent.com/75510135/150622633-21590d00-576d-4010-8c97-c990823da9c3.png">
<img width="710" alt="image" src="https://user-images.githubusercontent.com/75510135/150622674-dbaef834-44f7-413e-a490-8ffac343a968.png">





<img width="867" alt="image" src="https://user-images.githubusercontent.com/75510135/150619759-71320136-5e2a-45de-8cf2-1b5f304e3074.png">
<img width="963" alt="image" src="https://user-images.githubusercontent.com/75510135/150619767-bd456ade-1150-461a-b357-53cf777a7e0a.png">
<img width="867" alt="image" src="https://user-images.githubusercontent.com/75510135/150619828-72200692-85b1-4633-b862-6601d2e9dfa9.png">
<img width="935" alt="image" src="https://user-images.githubusercontent.com/75510135/150619895-30e7239e-a98b-493e-ad3b-3fba549901fd.png">
<img width="893" alt="image" src="https://user-images.githubusercontent.com/75510135/150619954-b0c9e6f3-675f-43d1-ae30-a42af44b0916.png">
<img width="768" alt="image" src="https://user-images.githubusercontent.com/75510135/150620120-386426c0-f8ef-4989-aca8-2a921a087693.png">
- Installation of filebeat
<img width="540" alt="image" src="https://user-images.githubusercontent.com/75510135/150620205-bb24f735-6de7-4dd0-bb92-ac12cea69541.png">
<img width="972" alt="image" src="https://user-images.githubusercontent.com/75510135/150620260-7cef8d48-5a7e-4602-b1ee-3315ed569718.png">
<img width="971" alt="image" src="https://user-images.githubusercontent.com/75510135/150620312-2e677819-0c5e-4f83-9a32-f76c487ef679.png">
- enable module to receive the logs
<img width="699" alt="image" src="https://user-images.githubusercontent.com/75510135/150620419-19c44161-3762-4a7a-a02e-2bf7c5f076db.png">

- different modules
<img width="281" alt="image" src="https://user-images.githubusercontent.com/75510135/150620428-925dcec5-e543-43b1-9dc9-30471eb5c911.png">
<img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/150620460-3bf2d4c6-04e6-41f4-9016-64855a456d8a.png">
- override the default access log behavior
<img width="919" alt="image" src="https://user-images.githubusercontent.com/75510135/150620516-0f67d041-6307-4989-8255-eb3de2dc5a92.png">
<img width="862" alt="image" src="https://user-images.githubusercontent.com/75510135/150620543-6dda7543-00a2-488a-b1e6-6204fd2fd7db.png">

- prepare Logstash pipeline to listen Filebeats events
<img width="724" alt="image" src="https://user-images.githubusercontent.com/75510135/150620779-a5a54655-b90a-477a-8d9e-4bbbc067dcad.png">
<img width="853" alt="image" src="https://user-images.githubusercontent.com/75510135/150620885-6292f94a-9c1e-4339-8804-86e57a1d7132.png">
- start the logstash

<img width="787" alt="image" src="https://user-images.githubusercontent.com/75510135/150620911-0ad5b2d2-cbf2-480d-a0c3-2fe4c3fc9fd2.png">
- start filebeat
<img width="694" alt="image" src="https://user-images.githubusercontent.com/75510135/150620947-9f8f263d-1ea2-40ca-9a35-be5f7f6f9bc8.png">
<img width="787" alt="image" src="https://user-images.githubusercontent.com/75510135/150620977-a770a829-7b4a-42ae-a15f-0831acdbbb75.png">
- at logstash
<img width="628" alt="image" src="https://user-images.githubusercontent.com/75510135/150621028-54c83fd8-4465-4d2c-9b02-85c63a8119bc.png">
- filer => tags , modules, fileset
<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/150621117-34c30c47-f749-43a4-b8bf-c8d20ac92695.png">

- Add Elastic search index template
<img width="587" alt="image" src="https://user-images.githubusercontent.com/75510135/150621145-ad52f5e3-602e-426a-8e51-2d26460b0811.png">
<img width="588" alt="image" src="https://user-images.githubusercontent.com/75510135/150621186-ce261bf8-2186-4dad-a062-132bbf02cd10.png">
<img width="857" alt="image" src="https://user-images.githubusercontent.com/75510135/150621210-d46f30ef-63ea-47fe-8971-084f89a07e4b.png">

- jump to Kibana
<img width="447" alt="image" src="https://user-images.githubusercontent.com/75510135/150621288-6ae3118d-4ed9-42da-9de7-e5bbe1e6af28.png">
<img width="425" alt="image" src="https://user-images.githubusercontent.com/75510135/150621318-109bf051-d51c-44be-82a4-ede16b54ac31.png">
<img width="671" alt="image" src="https://user-images.githubusercontent.com/75510135/150621410-d9a45aa7-ab71-4959-bb5b-7e2978588740.png">
<img width="706" alt="image" src="https://user-images.githubusercontent.com/75510135/150621473-e7aa3c85-d889-4461-aebe-34949fefc73a.png">
<img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/150621519-039af465-6a4d-49ee-9377-2607499dd32b.png">
<img width="907" alt="image" src="https://user-images.githubusercontent.com/75510135/150621535-b8fc3f23-852a-4767-806b-6b2ee8d3d6c1.png">
<img width="858" alt="image" src="https://user-images.githubusercontent.com/75510135/150621573-6015a562-c79c-4b0b-9b76-758970bc20e3.png">
<img width="916" alt="image" src="https://user-images.githubusercontent.com/75510135/150621584-9075df80-70d6-494d-9ed2-cda677a81323.png">

- kibana dashboard
- configure kibana endpoint in Filebeat
<img width="636" alt="image" src="https://user-images.githubusercontent.com/75510135/150621717-96b2fadc-4cd4-4f5e-bee5-6ddc2421b1fa.png">

<img width="689" alt="image" src="https://user-images.githubusercontent.com/75510135/150621704-a2531fce-0254-4042-b4c9-0d6ca58b7ff4.png">
<img width="623" alt="image" src="https://user-images.githubusercontent.com/75510135/150621736-605343a6-d0c7-4ea5-bba0-de8e5aed53f7.png">
- add dashboard to kibana
<img width="715" alt="image" src="https://user-images.githubusercontent.com/75510135/150621755-3737a71d-0bde-4a37-a5e1-3858cfcc16f7.png">
<img width="674" alt="image" src="https://user-images.githubusercontent.com/75510135/150621767-132be718-b846-447b-aec4-f2bd8b1d6031.png">
<img width="919" alt="image" src="https://user-images.githubusercontent.com/75510135/150621823-57fe43b6-fcf4-434d-9961-5fedf82aeca4.png">

- configure the pipeline now @ LS
<img width="887" alt="image" src="https://user-images.githubusercontent.com/75510135/150621911-06dc8427-1643-473b-997c-2f61b636939c.png">
<img width="908" alt="image" src="https://user-images.githubusercontent.com/75510135/150622044-a08fb28c-cb92-4d1d-99be-fa92cc2fa348.png">
<img width="1038" alt="image" src="https://user-images.githubusercontent.com/75510135/150622088-663b140a-bfde-4c12-b9c9-0dfc7a83bd7c.png">
<img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/150622102-be64bbc8-66cd-440a-afec-d05ab1c21b32.png">
<img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/150622120-47e2a00e-65b9-4d7a-aa2d-c4ede19f8ea4.png">
<img width="1004" alt="image" src="https://user-images.githubusercontent.com/75510135/150622147-3f1cbddd-e460-4ae9-8f25-a6e4b6053198.png">
<img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/150622177-5ed48cc2-3198-4c57-930e-b024b2ee6399.png">

- clear the registry



# Callback plugins
<img width="385" alt="image" src="https://user-images.githubusercontent.com/75510135/150623470-ab0e085e-63f5-44f2-96b6-4cd550dff11b.png">
<img width="274" alt="image" src="https://user-images.githubusercontent.com/75510135/150623514-acd02d57-2f63-4629-8efe-581590ad8898.png">
<img width="389" alt="image" src="https://user-images.githubusercontent.com/75510135/150623538-d45aeb5c-5e05-47c5-827d-a6e3855beb0b.png">
<img width="301" alt="image" src="https://user-images.githubusercontent.com/75510135/150623615-794335d4-ace1-4e09-9cef-bd37b262dc12.png">
<img width="400" alt="image" src="https://user-images.githubusercontent.com/75510135/150623643-76dcc9b9-3fa4-43f4-b12d-ad0f04082252.png">
<img width="288" alt="image" src="https://user-images.githubusercontent.com/75510135/150623676-50967d9e-faa6-4d52-8d3c-dae40cb9a159.png">
<img width="398" alt="image" src="https://user-images.githubusercontent.com/75510135/150623756-3524c409-6dfe-4aa1-a442-c54bf234dc8b.png">
<img width="388" alt="image" src="https://user-images.githubusercontent.com/75510135/150623804-64b96f42-bbbd-4781-ae44-89529e75394c.png">
<img width="397" alt="image" src="https://user-images.githubusercontent.com/75510135/150623813-ee701474-5c91-41cf-8b3e-5b7b98db0c4f.png">
<img width="395" alt="image" src="https://user-images.githubusercontent.com/75510135/150623827-bf2d0ebb-19dd-43bf-8a37-6fe2ccc2d781.png">
<img width="410" alt="image" src="https://user-images.githubusercontent.com/75510135/150623848-ad5b3608-4840-4940-b044-028a34fa3d0e.png">
- eg
<img width="301" alt="image" src="https://user-images.githubusercontent.com/75510135/150623879-8e52ba81-c266-4a33-8cbc-42e987f11b96.png">

<img width="394" alt="image" src="https://user-images.githubusercontent.com/75510135/150623868-74fc7aed-24b2-45d6-b8e7-a93756964958.png">
<img width="425" alt="image" src="https://user-images.githubusercontent.com/75510135/150623903-67a0495e-35ff-4541-b172-3826236219bd.png">


- references
* https://www.programmerall.com/article/84402249579/
* https://github.com/ujenmr/ansible-logstash-callback/blob/master/README.md
* https://github.com/ujenmr/ansible-logstash-callback
* https://www.youtube.com/watch?v=Dj0hgliEjA8
* https://www.bmc.com/blogs/elasticsearch-logs-beats-logstash/


```
checking out ansible callback plugins - they are python modules that implement callback functions that ansible will call during playbook execution. 
In fact, the messages ansible-playbook logs to your terminal is actually implemented as a callback plugin.
Here are the callback plugins bundled with ansible by default: 
https://github.com/ansible/ansible/tree/devel/lib/ansible/plugins/callback 
- it's possible you may be able to use one of them to send results to logstash, which would feed them into Elasticsearch for viewing with Kibana.
```


