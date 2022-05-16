- https://falco.org/docs/getting-started/installation/
- https://falco.org/blog/extend-falco-outputs-with-falcosidekick/
- https://api.slack.com/messaging/webhooks


<details>
<summary>Introduction- Falco - FalcoSideKick</summary>
<br>

  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/168478023-89a2668b-8d15-489d-9834-d95d8715a15e.png">

  <img width="1025" alt="image" src="https://user-images.githubusercontent.com/75510135/168478054-1f32529a-7b18-4c69-b546-710cb2772fa5.png">

  <img width="978" alt="image" src="https://user-images.githubusercontent.com/75510135/168478090-8cc63451-26b7-4ce9-a9f2-8d6b17dd2c2e.png">

  
</details>

<details>
<summary>Falco - installation - rules</summary>
<br>

  <img width="1259" alt="image" src="https://user-images.githubusercontent.com/75510135/168478477-12266dbe-abab-48a9-bd10-e4c8a6c7e9f5.png">

  - install using Helm
  - https://github.com/falcosecurity/charts/tree/master/falco
  
  <img width="528" alt="image" src="https://user-images.githubusercontent.com/75510135/168478839-49c36ef5-7d43-46e0-a345-2b3be1542757.png">

  <img width="535" alt="image" src="https://user-images.githubusercontent.com/75510135/168478887-51f093d9-1d92-4fe0-bea2-f6f7ddd5c8d4.png">

  <img width="884" alt="image" src="https://user-images.githubusercontent.com/75510135/168478943-652e37fe-c77d-427c-973b-02eca334c399.png">

  <img width="395" alt="image" src="https://user-images.githubusercontent.com/75510135/168478970-b3c43adf-7811-4249-b584-304f52577446.png">

  <img width="897" alt="image" src="https://user-images.githubusercontent.com/75510135/168478983-c2a6cba8-2a38-4e11-b5a2-eb6b917029c5.png">

  <img width="884" alt="image" src="https://user-images.githubusercontent.com/75510135/168479032-a69add4a-8d09-44be-a4e5-5afbeebe9661.png">

  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/168479050-d9ac8d46-5b25-44bc-936e-5131193288e2.png">

  <img width="958" alt="image" src="https://user-images.githubusercontent.com/75510135/168479094-492d10a4-fcc2-4abf-9f06-f70ff81e1ae1.png">

  
</details>

<details>
<summary>Helm n FalcoUI</summary>
<br>

  <img width="1235" alt="image" src="https://user-images.githubusercontent.com/75510135/168508783-24400b69-9fb4-4e4d-b102-e702a3812df8.png">

  ```
  kubectl create namespace falco
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm install falco falcosecurity/falco \
--set falcosidekick.enabled=true \
--set falcosidekick.webui.enabled=true \
--set falcosidekick.config.slack.webhookurl="https://hooks.slack.com/services/XXXX" \
-n falco 
  ```
  
  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/168508855-966c1a32-a922-47a7-9fca-e10879a67ab8.png">

  
  - Helm
  <img width="986" alt="image" src="https://user-images.githubusercontent.com/75510135/168508963-7a193ddc-e4df-40d3-a2f6-c94305602b2d.png">

  ```
   13  helm repo add falcosecurity https://falcosecurity.github.io/charts
   14  helm install falco falcosecurity/falco --set falcosidekick.enabled=true --set falcosidekick.webui.enabled=true -n falco
   18  helm repo ls
   19  alias k=kubectl
   20  k -n falco get all
  ```
  - Falco UI
  <img width="922" alt="image" src="https://user-images.githubusercontent.com/75510135/168509683-f6c06f8a-4a7c-415a-ba08-fc11869d13a3.png">

  <img width="792" alt="image" src="https://user-images.githubusercontent.com/75510135/168509889-76cae5d8-2d2e-44d7-94f3-f39a806d9573.png">

  <img width="963" alt="image" src="https://user-images.githubusercontent.com/75510135/168509928-e7f65ec4-bd9b-4059-b7e8-b63611a68e96.png">

  <img width="948" alt="image" src="https://user-images.githubusercontent.com/75510135/168509962-544279c3-fc51-4ebe-95e7-3a4378b5a735.png">

  
  
</details>

<details>
<summary>Falco - Slack Notification</summary>
<br>
  
  <img width="1248" alt="image" src="https://user-images.githubusercontent.com/75510135/168510822-9c09b709-af62-4b03-96bd-fece03d31de3.png">

  <img width="810" alt="image" src="https://user-images.githubusercontent.com/75510135/168510853-e70dbf93-f3bb-4267-b30d-6ff0e61ce09c.png">

  - in slack
  <img width="649" alt="image" src="https://user-images.githubusercontent.com/75510135/168510897-abb98ae3-a1b1-4551-8d81-732b6a72485d.png">

  <img width="557" alt="image" src="https://user-images.githubusercontent.com/75510135/168510928-665866eb-c584-4964-8d49-b2e277256389.png">

  <img width="849" alt="image" src="https://user-images.githubusercontent.com/75510135/168510956-545e4975-b239-4599-b6df-66987aee2f20.png">

  <img width="777" alt="image" src="https://user-images.githubusercontent.com/75510135/168510992-733a4f22-d554-494a-b309-b2925b229830.png">

  <img width="755" alt="image" src="https://user-images.githubusercontent.com/75510135/168511039-9b683b5f-5160-4dbf-9854-0cf84ffab839.png">

  <img width="629" alt="image" src="https://user-images.githubusercontent.com/75510135/168511066-0ed522da-fdb7-41c5-b636-5765f41adfbe.png">

  <img width="843" alt="image" src="https://user-images.githubusercontent.com/75510135/168511099-6f59b59b-2211-44c4-8e6f-a7f9d1666f96.png">

  <img width="751" alt="image" src="https://user-images.githubusercontent.com/75510135/168511129-d95d20f1-6447-46b4-9aad-68c7bce91915.png">

  <img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/168511166-62a4d278-23c8-43e9-b9cf-87fb6442c294.png">

  <img width="648" alt="image" src="https://user-images.githubusercontent.com/75510135/168511195-6f625de8-2c81-4762-817f-724a29ee3ef4.png">

  - upgrade FalcoSideKick
  
  <img width="771" alt="image" src="https://user-images.githubusercontent.com/75510135/168511237-44fc1586-5114-49e7-bb69-43d6bef2b70e.png">

  <img width="773" alt="image" src="https://user-images.githubusercontent.com/75510135/168511296-ce74a9af-3168-4735-9cdc-91dd17047b07.png">

  <img width="956" alt="image" src="https://user-images.githubusercontent.com/75510135/168511327-30ed3119-c1ae-4706-b24f-f5a736b12be0.png">

  <img width="508" alt="image" src="https://user-images.githubusercontent.com/75510135/168511515-7d2703b3-f396-4080-be38-8a7674738294.png">

  
  
</details>


