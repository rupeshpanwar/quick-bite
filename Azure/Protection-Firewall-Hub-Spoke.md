- Az firewall

<img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/144957963-37a06fda-3842-4b75-a2a5-6946fe7e39c8.png">

- az firewall is linked to Az Vnet
- Vnet should spare subnet in place
- due to FW helps to communicate on private IP hence public IP is not assigned to VM
<img width="712" alt="image" src="https://user-images.githubusercontent.com/75510135/144958685-97f13b46-8cc4-487a-bc93-8b0d6f10da50.png">
- firewall subnet name should "AzureFirewallSubnet"
<img width="672" alt="image" src="https://user-images.githubusercontent.com/75510135/144958787-804ee333-f658-4582-bfb0-0737506135d1.png">
<img width="784" alt="image" src="https://user-images.githubusercontent.com/75510135/144958916-27df830d-2982-40f8-b66d-bdce3fcde00c.png">
<img width="771" alt="image" src="https://user-images.githubusercontent.com/75510135/144959003-401deba0-d157-4d08-8b45-6bbec35d6845.png">
<img width="767" alt="image" src="https://user-images.githubusercontent.com/75510135/144959064-b38db11a-ec7c-4575-affa-afb8e5a3a976.png">
- add the route
<img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/144959135-2b534301-4a35-4a27-aed0-c85c9d4bf85c.png">
<img width="642" alt="image" src="https://user-images.githubusercontent.com/75510135/144959345-3109ef32-4ad0-4352-a079-3819c67d8f06.png">
<img width="588" alt="image" src="https://user-images.githubusercontent.com/75510135/144959361-7ce07bef-692d-48f7-b36e-12becd34b4e1.png">
<img width="624" alt="image" src="https://user-images.githubusercontent.com/75510135/144959510-e29a1769-111a-4981-8212-22c9d0ec7f92.png">
<img width="777" alt="image" src="https://user-images.githubusercontent.com/75510135/144959559-b3ce0c99-7752-4228-8076-a4bf4feb2c16.png">
<img width="731" alt="image" src="https://user-images.githubusercontent.com/75510135/144959603-8d08b46e-d837-47b7-8615-6ae0e8069a36.png">
<img width="334" alt="image" src="https://user-images.githubusercontent.com/75510135/144959631-49212229-89b2-4013-867f-cc431f2916a3.png">

<img width="339" alt="image" src="https://user-images.githubusercontent.com/75510135/144959688-c8122782-60b3-4bd5-9b27-1af92db85c07.png">

<img width="729" alt="image" src="https://user-images.githubusercontent.com/75510135/144959756-082d7bb5-1f8f-4e23-8783-83e568fcfb81.png">

- supply private ip address of firewall here to route traffic via firewall

<img width="428" alt="image" src="https://user-images.githubusercontent.com/75510135/144959833-9c9157fd-4b26-47ae-8c82-1cade7eeb1a8.png">

<img width="736" alt="image" src="https://user-images.githubusercontent.com/75510135/144959873-a34978ae-ad8c-4a1d-9f9c-40ecacb41416.png">

- attach subnet of VM to route table
<img width="332" alt="image" src="https://user-images.githubusercontent.com/75510135/144959915-a1028f1a-7119-4ea1-9be9-8bb41d11f96c.png">

<img width="544" alt="image" src="https://user-images.githubusercontent.com/75510135/144959955-e2f9c670-cef0-4039-a004-16a957d955f3.png">

<img width="565" alt="image" src="https://user-images.githubusercontent.com/75510135/144959986-699df51c-9cbe-4640-98d9-88b70aaed36f.png">

- connect VM via NAT 

<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144960273-5c9b73ca-6cb0-4f72-8eb7-ece3b28658e4.png">
<img width="800" alt="image" src="https://user-images.githubusercontent.com/75510135/144960498-d5230074-34f9-4a8b-acd7-a7e309a7c2c0.png">

<img width="760" alt="image" src="https://user-images.githubusercontent.com/75510135/144960362-a3675520-83f3-44a4-bf65-1e8ac62fb009.png">
<img width="683" alt="image" src="https://user-images.githubusercontent.com/75510135/144960553-e3946347-70a4-4aa4-a458-c5a6c89b8604.png">

<img width="800" alt="image" src="https://user-images.githubusercontent.com/75510135/144960727-7ce515a2-013e-457b-9d31-3be1f390e452.png">

<img width="763" alt="image" src="https://user-images.githubusercontent.com/75510135/144960803-f931a6ec-f152-447f-beb6-c96495c1a919.png">

<img width="729" alt="image" src="https://user-images.githubusercontent.com/75510135/144960839-b5199a61-d6fa-49c4-a997-972829f662ae.png">

- Hub Spoke model

<img width="562" alt="image" src="https://user-images.githubusercontent.com/75510135/144961856-9998635b-dcc0-4572-a4b5-3fbfadbd25e8.png">

<img width="616" alt="image" src="https://user-images.githubusercontent.com/75510135/144963656-ca8deb6f-ceeb-4bf5-8fb0-b05d6e52be58.png">

- traffic flow will be via peering 

<img width="585" alt="image" src="https://user-images.githubusercontent.com/75510135/144963752-b1f303fe-0d95-4f05-a4eb-05521e82a743.png">

- attach route table to GatewaySubnet 
<img width="611" alt="image" src="https://user-images.githubusercontent.com/75510135/144963927-8bda8842-1766-4466-9179-11d659a351d8.png">

<img width="627" alt="image" src="https://user-images.githubusercontent.com/75510135/144964302-78bf5844-4bf9-4bb3-8785-7c14e863066e.png">

- Setting up Hub network
<img width="671" alt="image" src="https://user-images.githubusercontent.com/75510135/144964732-307df4f2-098b-4a59-ad5c-9109acc40a70.png">

- acting as onprem machine with routing capability

<img width="871" alt="image" src="https://user-images.githubusercontent.com/75510135/144964801-ea43673d-5448-4bf2-8fe8-861a9598a91f.png">

# Part 1- now install 3 components in azure for Hub setup
1. create VNet for Hub
2. vn gateway
3. az bastion
<img width="334" alt="image" src="https://user-images.githubusercontent.com/75510135/144964926-83fc22a5-6f10-4718-b36f-69a19bcf1b3c.png">
<img width="680" alt="image" src="https://user-images.githubusercontent.com/75510135/144965198-9d41a173-5958-4883-964c-eb4f28dd69e8.png">
<img width="670" alt="image" src="https://user-images.githubusercontent.com/75510135/144965249-b0b66107-8337-4ea6-9a52-ade201307e4f.png">
2. Enable Azure Firewall in the HubVnet
<img width="333" alt="image" src="https://user-images.githubusercontent.com/75510135/144965319-54c41249-770b-4d2b-8b14-c58a282e5211.png">
<img width="675" alt="image" src="https://user-images.githubusercontent.com/75510135/144965429-1363e85f-6941-454e-894f-25e58de43053.png">
<img width="754" alt="image" src="https://user-images.githubusercontent.com/75510135/144965531-c3b27697-b2cc-41e4-81a4-1affeb31fad0.png">

4. add gatewaysubnet to hubVnet
<img width="772" alt="image" src="https://user-images.githubusercontent.com/75510135/144965688-88a572ef-fc9c-4d7f-83bd-25269d37868b.png">
<img width="523" alt="image" src="https://user-images.githubusercontent.com/75510135/144965720-58356ede-5836-4ae2-8fd1-ffc81ac46f7a.png">

5. Create Virtual network gateway

<img width="790" alt="image" src="https://user-images.githubusercontent.com/75510135/144965781-0bead141-7441-47b6-89d5-6ddc6d4a53a8.png">
<img width="581" alt="image" src="https://user-images.githubusercontent.com/75510135/144965844-8c2cba7f-b1bf-44b6-bfff-e38599ed05f1.png">
<img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/144965867-4af6d4be-cd80-4065-b2df-0d8b94f8ce67.png">
<img width="514" alt="image" src="https://user-images.githubusercontent.com/75510135/144965901-fde7dffa-a0bc-4b27-9621-26d946664271.png">
<img width="393" alt="image" src="https://user-images.githubusercontent.com/75510135/144965951-c688c2fc-7f1b-4223-90a7-cc344bf73f82.png">

# Part 2- create Spoke network
1. create a vnet for spoke and subnet
<img width="789" alt="image" src="https://user-images.githubusercontent.com/75510135/144966158-8c9c70aa-70c8-42b9-a5f2-607212e5043b.png">
2. create a VM in spoke but dont assign any public ip
<img width="675" alt="image" src="https://user-images.githubusercontent.com/75510135/144966336-3822043b-04ad-406e-aa3b-90df38df6e88.png">

# Part 3- Local Network Gateway
1. create local network gateway
<img width="785" alt="image" src="https://user-images.githubusercontent.com/75510135/144966440-5040988e-0333-4634-9ab7-93003b58c048.png">

- assign IP of you on-prem vpn device public IP
- same for address space, should be taken from on-prem vpn subnet
<img width="785" alt="image" src="https://user-images.githubusercontent.com/75510135/144966629-b1ea7447-ba20-4045-ad86-6a7be6ac8c98.png">
<img width="791" alt="image" src="https://user-images.githubusercontent.com/75510135/144966655-b8ab1ffc-75e0-42f3-bc36-366a45b36ffa.png">

<img width="691" alt="image" src="https://user-images.githubusercontent.com/75510135/144966595-64f4d8bb-99bb-4f26-a3af-2e4b2fd9bd8d.png">
<img width="327" alt="image" src="https://user-images.githubusercontent.com/75510135/144966699-9d15a8d4-bde5-448f-8902-885e1904d294.png">

# Part 4- Add VPN Connection @ Virtual Network gateway
1. click on connection on VNgateway
<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144966895-877cbf25-ebce-444e-963e-7ba48385170c.png">
<img width="716" alt="image" src="https://user-images.githubusercontent.com/75510135/144966922-2d688778-f686-48ec-b7b4-1e98824aba3d.png">

<img width="300" alt="image" src="https://user-images.githubusercontent.com/75510135/144966967-f6adec9b-55c4-4050-b63d-71652ea31e8f.png">

2. select above created local network gateway, supply shared key
<img width="314" alt="image" src="https://user-images.githubusercontent.com/75510135/144967041-01cba341-2bb3-47df-8652-0837eb7e9830.png">

# Part 5- on-premises n/w vpn device
1.
<img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/144967150-ecbd761e-7166-473e-9004-352b99ef4bbf.png">
<img width="714" alt="image" src="https://user-images.githubusercontent.com/75510135/144967189-06bb2066-a0c0-4d54-9417-3c8962919c68.png">
<img width="621" alt="image" src="https://user-images.githubusercontent.com/75510135/144967223-9bf967c2-e908-4610-a8b3-c01b2659cf2e.png">
<img width="639" alt="image" src="https://user-images.githubusercontent.com/75510135/144967259-3c6625a2-91ac-41ea-87ee-f4a347252b3d.png">
2. supply public IP address of Virtual Network gateway
<img width="792" alt="image" src="https://user-images.githubusercontent.com/75510135/144967314-4e7c6ff8-cb80-4a96-92cb-ec344b58f0bd.png">
<img width="688" alt="image" src="https://user-images.githubusercontent.com/75510135/144967336-76faaa16-7b88-49ad-b242-b0f1c616c0ed.png">
<img width="702" alt="image" src="https://user-images.githubusercontent.com/75510135/144967349-b011ba98-d158-460d-a74d-604b278353d0.png">
3. in the destination address, hub n spoke vnet information is supplied
<img width="702" alt="image" src="https://user-images.githubusercontent.com/75510135/144967410-313bc417-e0a2-45ce-8aa8-65cb67fd4335.png">

<img width="585" alt="image" src="https://user-images.githubusercontent.com/75510135/144967475-834eba6e-8a48-4f97-a7a7-1ae0ab784554.png">
<img width="545" alt="image" src="https://user-images.githubusercontent.com/75510135/144967503-f9cbdd0c-969d-421b-a3c6-80ee5fd27f6e.png">
<img width="615" alt="image" src="https://user-images.githubusercontent.com/75510135/144967560-ee6ba5c9-4bdb-4012-a747-0308343d5d36.png">
<img width="602" alt="image" src="https://user-images.githubusercontent.com/75510135/144967581-f3aeac2e-7aee-42d5-a0f2-9b50b70f8502.png">
<img width="713" alt="image" src="https://user-images.githubusercontent.com/75510135/144967612-8e8dd7d0-7ca5-47c6-8543-302e2df9bd4b.png">

4. supply pre-shared key in the properties

<img width="682" alt="image" src="https://user-images.githubusercontent.com/75510135/144967670-e31c018b-21b7-4287-a0eb-cb8da85f6ebb.png">
5. right click n connect
<img width="652" alt="image" src="https://user-images.githubusercontent.com/75510135/144967711-f4abe5ed-6565-4a86-837a-ffe81b947a57.png">
<img width="699" alt="image" src="https://user-images.githubusercontent.com/75510135/144967739-c4c714aa-95bb-49c7-a75e-f87d58e23638.png">

# Part 6- Create VNet peering b/w Hub n Spoke
<img width="660" alt="image" src="https://user-images.githubusercontent.com/75510135/144967884-db8457dd-74e6-4eee-a7ed-6b7baf4b51d2.png">
1. open any of the network, hub or spoke, click on peering
<img width="357" alt="image" src="https://user-images.githubusercontent.com/75510135/144967956-50490a47-9f58-4fe6-a57a-99fb82c6f2fc.png">
<img width="435" alt="image" src="https://user-images.githubusercontent.com/75510135/144967994-9451e1cc-31f9-4abd-a56a-3e41772adc4c.png">
2. name peering link name
<img width="649" alt="image" src="https://user-images.githubusercontent.com/75510135/144968087-66286171-0a38-430d-9628-ea6b122c31b9.png">
3. use virtual network gateway
<img width="346" alt="image" src="https://user-images.githubusercontent.com/75510135/144968128-cfd62d7e-64a9-454d-baed-d28e02d4efd0.png">

# network flow now, spoke to VPN gateway to on-premises
<img width="706" alt="image" src="https://user-images.githubusercontent.com/75510135/144968203-69d36460-3423-4cc2-a1e2-38345d04a618.png">

<img width="733" alt="image" src="https://user-images.githubusercontent.com/75510135/144968302-2bd216d9-c2b0-462b-a12b-aa79dcc713ed.png">

# Now , routing the traffic via Az Firewall

<img width="743" alt="image" src="https://user-images.githubusercontent.com/75510135/144968540-20bdad10-c6e9-404f-834b-e4992f69ef4e.png">
<img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/144968590-1eed02dd-a60b-463d-af04-6699a3aa06bd.png">
1. Attach UDR to respective Vnet
2. one to gateway subnet in hub and another to spoke subnet
<img width="716" alt="image" src="https://user-images.githubusercontent.com/75510135/144968743-237cbee4-d42c-4092-9305-62ef4a08cd94.png">

















