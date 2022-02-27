<details>
<summary>Architecture</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/155879199-6f91848e-2e73-41cd-a1d4-374fc6f89ef6.png)

  ![image](https://user-images.githubusercontent.com/75510135/155879410-5d5954ce-ec3c-4bd1-adbf-0ed9e9c5d434.png)

  ![image](https://user-images.githubusercontent.com/75510135/155879478-21272919-456d-4600-9955-e89a7ec6c9ad.png)


</details>

<details>
<summary>PKI</summary>
<br>
    
  ![image](https://user-images.githubusercontent.com/75510135/155879512-ce753775-2b65-44f5-b914-f45eaca2c31e.png)

  ![image](https://user-images.githubusercontent.com/75510135/155879533-1fbadde5-494c-40a3-be02-2cfad0c44ad4.png)

  ![image](https://user-images.githubusercontent.com/75510135/155879593-5741e1be-a756-4836-bee4-2adcb2756eb0.png)

</details>


<details>
<summary>Find certificates</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/155879677-4e88b0d0-4efc-46cc-b988-8b80bfef1436.png)

  |Certs | location/command |
  | - | - |
  | CA |  cd /etc/kubernetes/pki/  |
  | API Server Cert | cd /etc/kubernetes/pki/  |
  | Etcd Server cert| etc/kubernetes/pki# ll etcd/ |
  | Api -> Etcd | cd /etc/kubernetes/pki/  |
  | Api -> Kubelet | |
  | Scheduler -> Api | cat /etc/kubernetes/scheduler.conf  |
  | Controller-manager -> Api |  cat /etc/kubernetes/controller-manager.conf |
  | Kubelet -> Api | cat /etc/kubernetes/kubelet.conf ; cd  /var/lib/kubelet/pki/ |
  | Kubelet Server cert |  cat /etc/kubernetes/kubelet.conf |
  
  <img width="634" alt="image" src="https://user-images.githubusercontent.com/75510135/155880270-c2671e50-0497-439d-a8f9-a53184a46a98.png">

  <img width="609" alt="image" src="https://user-images.githubusercontent.com/75510135/155880383-a7782bd2-4d08-45b1-8b2a-50c39d785ea8.png">

  <img width="702" alt="image" src="https://user-images.githubusercontent.com/75510135/155880411-2c1e3f9a-829f-49b3-b9af-ce8816ebe1ae.png">

  <img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/155880461-8afe5daf-0309-49dc-a968-9a4b4197ce80.png">

  <img width="619" alt="image" src="https://user-images.githubusercontent.com/75510135/155880495-9dc90c1d-61e6-4df1-8e8f-fa34a68f5994.png">

  - worker node side certs
  
  <img width="662" alt="image" src="https://user-images.githubusercontent.com/75510135/155880543-5d872870-0c6b-47f0-a032-ac55a1568e03.png">

  <img width="740" alt="image" src="https://user-images.githubusercontent.com/75510135/155880578-5a04bea8-0d27-4709-83ee-5380d212cf15.png">

  
</details>


<details>
<summary>Additional reference</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/155880610-f34976c0-9c5c-4fba-afaa-880c4fac5bb4.png)

  ![image](https://user-images.githubusercontent.com/75510135/155880620-3d796c83-17a0-4956-93f1-e79d1a7f8b7e.png)

  ![image](https://user-images.githubusercontent.com/75510135/155880634-840b26f6-81a4-491d-8c11-77617207deea.png)

</details>

