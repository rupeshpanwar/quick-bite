<img width="754" alt="image" src="https://user-images.githubusercontent.com/75510135/145175834-10ab619a-0e55-430b-a2ea-7e64479a2691.png">
<img width="739" alt="image" src="https://user-images.githubusercontent.com/75510135/145176044-6f5b36c6-1f08-441b-b124-d1001b7fdd1e.png">
<img width="836" alt="image" src="https://user-images.githubusercontent.com/75510135/145176316-c0ef307d-ced6-4a0a-bd39-323af5edbf3d.png">
<img width="757" alt="image" src="https://user-images.githubusercontent.com/75510135/145176398-b93ef6f4-8335-40b8-abfe-eafff3f33764.png">
<img width="717" alt="image" src="https://user-images.githubusercontent.com/75510135/145176499-82fb5843-318f-46a6-84c3-0f4ac09a6451.png">
<img width="743" alt="image" src="https://user-images.githubusercontent.com/75510135/145176937-48f8abfa-e9e8-4af9-8acd-391dd565f9de.png">
<img width="870" alt="image" src="https://user-images.githubusercontent.com/75510135/145177138-5618ed4b-b697-4f01-b189-94a948e2bc77.png">
<img width="852" alt="image" src="https://user-images.githubusercontent.com/75510135/145177362-b97c4a33-e3ed-44bf-8dbf-0155f70502fe.png">
<img width="639" alt="image" src="https://user-images.githubusercontent.com/75510135/145177914-fa7095e3-dada-478d-a30d-9e946b098713.png">
- ingress in action
<img width="746" alt="image" src="https://user-images.githubusercontent.com/75510135/145178666-81d86978-cead-475c-8832-55d7ea536d61.png">
<img width="781" alt="image" src="https://user-images.githubusercontent.com/75510135/145179170-aaaaf1fc-b327-426c-8e07-52f46fef1e6d.png">
- ingress controller port config
<img width="666" alt="image" src="https://user-images.githubusercontent.com/75510135/145179805-56e7fabf-7124-48b8-a950-31cdf7fec5f7.png">
<img width="862" alt="image" src="https://user-images.githubusercontent.com/75510135/145180584-52a1928b-97ca-40f2-946d-654023611135.png">
<img width="789" alt="image" src="https://user-images.githubusercontent.com/75510135/145180843-df30b0af-039a-43e8-a1d2-1bfc9df7a94f.png">
<img width="789" alt="image" src="https://user-images.githubusercontent.com/75510135/145180915-6a2a4705-2cca-482d-b8d4-ae8952e78ca1.png">

- deploy NGINX Ingress
<img width="718" alt="image" src="https://user-images.githubusercontent.com/75510135/145180979-abe0f1bc-512e-4ac8-aee1-017e5c8575ea.png">
<img width="695" alt="image" src="https://user-images.githubusercontent.com/75510135/145181408-ffd637ce-a4c4-4e3a-a255-c6b83e95274f.png">
<img width="733" alt="image" src="https://user-images.githubusercontent.com/75510135/145181893-624c74ac-b8bb-41d3-81bf-2c175090fb74.png">
<img width="789" alt="image" src="https://user-images.githubusercontent.com/75510135/145182222-c301cd0b-5467-4079-bf7d-8f5ff471102a.png">

- Ingress DNS and app test
<img width="719" alt="image" src="https://user-images.githubusercontent.com/75510135/145182602-48a37f87-fcd1-49ab-9f09-c59ebad60c9e.png">
<img width="740" alt="image" src="https://user-images.githubusercontent.com/75510135/145182794-6816ea49-97d2-4d14-b62e-f83a13e96542.png">

<img width="802" alt="image" src="https://user-images.githubusercontent.com/75510135/145182927-59252779-f322-4556-81bf-598d82b82596.png">
<img width="715" alt="image" src="https://user-images.githubusercontent.com/75510135/145182985-7d56434e-aac5-45c7-988b-a47fc8998a52.png">
```
   kubectl apply -f https://k8smastery.com/ic-nginx-hn.yaml
   kubectl describe -n ingress-nginx deploy/nginx-ingress-controller
   kubectl describe -n ingress-nginx deploy/ingress-nginx-controller
   hostname -I | awk '{print $1}'
   curl http://172.17.0.13:80
   clear
   kubectl create deploy cheddar --image=errm/cheese:cheddar
   kubectl create deploy stilton --image=errm/cheese:stilton
   kubectl create deploy wensleydale --image=errm/cheese:wensleydale
   kubectl expose deploy cheddar --port=80
   kubectl expose deploy stilton --port=80
   kubectl expose deploy wensleydale --port=80
   ```
   - ingress resources
   <img width="667" alt="image" src="https://user-images.githubusercontent.com/75510135/145184115-07fabe1a-ac09-4a27-99a8-cbddfd8ff916.png">
<img width="744" alt="image" src="https://user-images.githubusercontent.com/75510135/145184372-d91d9a71-41d1-428b-bea8-6c0e0aedbc90.png">
<img width="725" alt="image" src="https://user-images.githubusercontent.com/75510135/145185146-82d9f6e4-b22e-41e3-80d7-27058b177c09.png">
- ingress flowchart
<img width="785" alt="image" src="https://user-images.githubusercontent.com/75510135/145186331-adcbec0b-06c2-4e43-a624-7a582aed0202.png">

<img width="782" alt="image" src="https://user-images.githubusercontent.com/75510135/145186358-e28fe9c8-5211-48c4-8f73-7b5600d99d83.png">
- Annotation
<img width="739" alt="image" src="https://user-images.githubusercontent.com/75510135/145186455-541ff1cd-9443-411f-bf4e-0b18cc02ca61.png">

<img width="776" alt="image" src="https://user-images.githubusercontent.com/75510135/145186833-92c05378-5405-45b8-b7c9-65577d269762.png">
- Inspecting the ingress resources
<img width="554" alt="image" src="https://user-images.githubusercontent.com/75510135/145187741-f9c9f0a0-9398-4d81-a6f1-824a2b1ae831.png">

# Traefik
<img width="786" alt="image" src="https://user-images.githubusercontent.com/75510135/145190262-e1402c9f-8f18-493b-9b70-d0ff6cf814f8.png">
<img width="864" alt="image" src="https://user-images.githubusercontent.com/75510135/145190870-ca0dc77b-d4d3-4faf-bbf3-d7197bc452cd.png">
<img width="670" alt="image" src="https://user-images.githubusercontent.com/75510135/145190961-88b93b3d-0f2d-4518-b88a-5b5f334541aa.png">

<img width="672" alt="image" src="https://user-images.githubusercontent.com/75510135/145316080-3868765d-448b-46bf-9012-42daa25d0835.png">
<img width="730" alt="image" src="https://user-images.githubusercontent.com/75510135/145316422-e82e97cf-5a94-4b1a-b1ec-44d8a677a099.png">
<img width="718" alt="image" src="https://user-images.githubusercontent.com/75510135/145316785-5ede7a83-d126-4f11-9ffa-dee60d4c3e76.png">
<img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/145316812-dee7367c-fe03-45f6-b77a-1172d55dd3c5.png">
<img width="714" alt="image" src="https://user-images.githubusercontent.com/75510135/145316907-ed212f32-41a2-42da-badd-b3d93571ca36.png">
<img width="759" alt="image" src="https://user-images.githubusercontent.com/75510135/145317348-69453bde-0046-4951-9f3b-3caee746912d.png">
<img width="825" alt="image" src="https://user-images.githubusercontent.com/75510135/145317470-f6fb3de5-4a25-4cbb-bba5-c5f07549cf0d.png">
<img width="768" alt="image" src="https://user-images.githubusercontent.com/75510135/145317551-59f95e8f-5bb7-4590-9146-e132beb928b6.png">
<img width="858" alt="image" src="https://user-images.githubusercontent.com/75510135/145317759-8ca982a3-9cfb-43e2-aaba-da59bace6935.png">
- Alternatives
<img width="706" alt="image" src="https://user-images.githubusercontent.com/75510135/145317822-46a84b6f-f4d0-497f-ad9c-c05173064f24.png">
<img width="792" alt="image" src="https://user-images.githubusercontent.com/75510135/145320133-9c8b2484-f12f-43f9-80ff-2570dc2a7ddc.png">


<img width="679" alt="image" src="https://user-images.githubusercontent.com/75510135/145320344-f03856a1-2f70-4689-8cbe-bf9ced0a9ce6.png">







