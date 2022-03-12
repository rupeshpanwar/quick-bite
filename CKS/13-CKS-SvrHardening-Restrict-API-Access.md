
<details>
<summary>Introduction</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/158012898-031ab5e4-42a9-4d7c-a4ed-fe957dbf9002.png)

  ![image](https://user-images.githubusercontent.com/75510135/158012923-d9431fe3-0f30-4a5d-8055-7546db848d8f.png)

  ![image](https://user-images.githubusercontent.com/75510135/158012947-7448d075-d551-41fd-bbe4-05c5f4336518.png)

</details>


<details>
<summary>Anonymous Access</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/158013178-b2d27a02-3a40-4451-8990-3d101dd575be.png)
  
  - enable / disable Anonymous access in below path
  
  >  vi /etc/kubernetes/manifests/kube-apiserver.yaml
  
  <img width="717" alt="image" src="https://user-images.githubusercontent.com/75510135/158013295-d8fda6bd-d0cd-4655-8f21-78933d6cf0df.png">
  
  <img width="810" alt="image" src="https://user-images.githubusercontent.com/75510135/158013429-e6bd4cc3-cb4d-4287-9cb9-aa0ab2cafc62.png">

  <img width="625" alt="image" src="https://user-images.githubusercontent.com/75510135/158013425-fa394585-32ae-4c0a-a176-4c6ca7783fbf.png">

  <img width="655" alt="image" src="https://user-images.githubusercontent.com/75510135/158014088-5e40106c-25a4-44b7-b39c-52534cea9210.png">

  
</details>



<details>
<summary>Insecure Access</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/158014268-885d2a50-7294-4312-a588-37d74f04ea3b.png)

  ![image](https://user-images.githubusercontent.com/75510135/158014282-4e025151-eb04-43f7-94c9-e1d4cf787409.png)

  ![image](https://user-images.githubusercontent.com/75510135/158014292-c191d21c-160c-4399-a8b6-fb6567bdf598.png)

  - set the insecure port to 8080
  
  > vi /etc/kubernetes/manifests/kube-apiserver.yaml
  
  ![image](https://user-images.githubusercontent.com/75510135/158014373-bc95d88e-8f77-4e78-8df2-e5e8927c7910.png)

  > k -n kube-system get pod | grep api
  >  curl http://localhost:8080 -k
  
  ![image](https://user-images.githubusercontent.com/75510135/158014417-21c5ab0f-c5c9-40df-a144-a7a0f3b7f8b7.png)

  
</details>

