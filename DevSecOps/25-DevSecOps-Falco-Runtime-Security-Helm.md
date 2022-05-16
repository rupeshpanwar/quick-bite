- https://falco.org/docs/getting-started/installation/
- https://falco.org/blog/extend-falco-outputs-with-falcosidekick/


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
This is how you dropdown.
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
