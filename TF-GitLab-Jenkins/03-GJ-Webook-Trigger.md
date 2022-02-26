
<details>
<summary>@Jenkinsfile(sample) for deployment</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/155848758-a8696ae7-9ac8-45b2-b180-8cee45fff187.png)

  ![image](https://user-images.githubusercontent.com/75510135/155848796-c771a3cd-dbc6-402d-af22-5e1a451c4cae.png)

  
</details>


<details>
<summary>@Jenkins server </summary>
<br>

  - copy the webhook url - http://142.93.213.194:8080/project/demo-pipeline
   ![image](https://user-images.githubusercontent.com/75510135/155849126-88cc2e86-cccf-441b-a205-a912c73d093a.png)

  - generate token
  ![image](https://user-images.githubusercontent.com/75510135/155849212-5992dec7-0613-4910-8090-ca5dbb412fae.png)

  - save the pipeline changes
  
</details>



<details>
<summary>@Gitlab server</summary>
<br>

  - Login under admin/root , here jondoe then under project click on Settings then click on webhook
  
  ![image](https://user-images.githubusercontent.com/75510135/155849323-b033ae49-acd6-4485-8c8c-8d3411766884.png)

  - paste the url n token , copied from Jenkins in above section , click on Add Webhook
  
  ![image](https://user-images.githubusercontent.com/75510135/155849397-3bd0042b-edba-43d0-82a5-2a884b366646.png)

  ![image](https://user-images.githubusercontent.com/75510135/155849416-ca6ea534-ba2d-48fb-a3f7-1a357d198391.png)

  - then click on Test then push events
  
  ![image](https://user-images.githubusercontent.com/75510135/155849427-57b53ec0-6aaf-45b5-9dcb-6808778df70c.png)


</details>



<details>
<summary>Validate</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/155849443-ad8f48e2-0107-4ee0-8649-52e6b97468d5.png)

  ![image](https://user-images.githubusercontent.com/75510135/155849460-e94aaf53-6826-4726-b897-74aef060238b.png)

  
</details>


