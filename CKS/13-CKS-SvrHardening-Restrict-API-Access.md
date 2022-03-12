
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

    k -n kube-system get pod | grep api
    curl http://localhost:8080 -k
  
  ![image](https://user-images.githubusercontent.com/75510135/158014417-21c5ab0f-c5c9-40df-a144-a7a0f3b7f8b7.png)

  
</details>


<details>
<summary>Maual API Request</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/158015934-b31b03c2-967f-43df-9d43-2488d8f930cb.png)

  <img width="543" alt="image" src="https://user-images.githubusercontent.com/75510135/158015993-fc1ac15a-267d-43ff-8a94-04835888ad76.png">

  - k config view --raw
  <img width="815" alt="image" src="https://user-images.githubusercontent.com/75510135/158016042-397be926-dc72-4ddb-bd0a-ce100818d5f6.png">

  - covert to base64 > cert | base64 -d then store in a file say "ca"
  
  <img width="552" alt="image" src="https://user-images.githubusercontent.com/75510135/158016094-48ef5802-7602-4b55-8f08-4503942a37bf.png">

  <img width="815" alt="image" src="https://user-images.githubusercontent.com/75510135/158016124-2f3dcd45-0ef2-4910-9a2c-1d79d202407c.png">

  - do the same step for client cert , say crt && client key say 'key'
  <img width="814" alt="image" src="https://user-images.githubusercontent.com/75510135/158016163-40c6ef30-82a4-48ef-be69-a31335655d6e.png">

  <img width="807" alt="image" src="https://user-images.githubusercontent.com/75510135/158016177-e8576562-9e53-44d8-b0a1-3677fc4c0160.png">

  - now curl the k8s site using above 
  
 > curl https://10.148.0.2:6443 --cacert ca --cert crt --key key
  
  
  
</details>


<details>
<summary>External APIserver access</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/158017086-9f0b8877-8f8b-435d-aec3-e41e0fb6493c.png)

  - change k8s service from clusterip to nodeport
  
     k get svc
     k edit svc kubernetes
  
  ![image](https://user-images.githubusercontent.com/75510135/158017448-d8ce24a1-b76a-4a5f-956e-d884d72aaaf8.png)

  - on local laptop, try to access worker-node-public-ip:nodeport
  
  ![image](https://user-images.githubusercontent.com/75510135/158017489-420ee9fe-0177-4bae-9c73-86f8ea47796b.png)

  ![image](https://user-images.githubusercontent.com/75510135/158017493-caa7785a-9bd9-40e9-bff5-36d33689c198.png)

  - copy config from master node to laptop n create a conf file 
    
    k config view --raw
  
  ![image](https://user-images.githubusercontent.com/75510135/158017586-b1288a9c-5bc9-49f8-9174-d6c2050fccd6.png)

  ![image](https://user-images.githubusercontent.com/75510135/158017596-929a052b-af86-4342-b832-5d7b5e02431d.png)

  - change server ip in conf file to worker-node-public-ip
  
  ![image](https://user-images.githubusercontent.com/75510135/158021613-6fa1495f-7942-4124-999e-104151ea6be8.png)

  - switch back to master node pki crt location
  
  ![image](https://user-images.githubusercontent.com/75510135/158021655-2fd88e56-3065-4f07-b93e-9257178477f6.png)

  > openssl x509 -in apiserver.crt -text
  
  ![image](https://user-images.githubusercontent.com/75510135/158021704-68944b7a-e4d0-49c4-adce-9e76bd9d2236.png)

  - it got only master n worker node ip added
  
  - head back to local machine , change the host enteries
  
  > sudo vim /etc/hosts
  
  ![image](https://user-images.githubusercontent.com/75510135/158021763-216fe989-fcf7-4755-84ac-2e3b95b07e34.png)

  - now test the command at local machine
  
  ![image](https://user-images.githubusercontent.com/75510135/158021813-55203935-7b2e-4a71-b9e7-917bdad9ae66.png)

  
  
  
</details>



<details>
<summary>Node Restriction-AdmissionController</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/158021946-4e30d156-2d46-4b38-a61a-032cdc219b13.png)

  ![image](https://user-images.githubusercontent.com/75510135/158021977-c9a12886-e5d4-4f1a-b4db-ae27acd3a44e.png)

  - try for worker node
  
  ![image](https://user-images.githubusercontent.com/75510135/158022216-a2ac1047-a010-4fc1-b392-5230758f2bb0.png)

  - open kube-apiserver yaml to check NodeRestriction
  ![image](https://user-images.githubusercontent.com/75510135/158022262-0e55f890-6c8b-4b1a-9955-f93a5ae54b7b.png)

  ![image](https://user-images.githubusercontent.com/75510135/158022280-c2a6bccd-1a13-4c0f-8604-60dadec0e1cf.png)

  - hop over worker node
  ![image](https://user-images.githubusercontent.com/75510135/158022301-236dac97-1481-4577-b317-becf4073ba66.png)

  - look into kubelet.conf, check its reporting to master
  
  ![image](https://user-images.githubusercontent.com/75510135/158022362-94636657-6a51-47f5-9eef-3c4cc5d24e5d.png)

  - export the path 
  > export KUBECONFIG=/etc/kubernetes/kubelet.conf
  
  ![image](https://user-images.githubusercontent.com/75510135/158022413-f810158a-d4d9-458a-a004-a4257f4a5918.png)

  - test by labeling the node
  ![image](https://user-images.githubusercontent.com/75510135/158022500-1e1dceff-0f8f-46f0-80b7-929425de425e.png)

  ![image](https://user-images.githubusercontent.com/75510135/158022537-973910ea-dd6e-4efc-a96b-661ca4585733.png)

  
  
  
</details>



<details>
<summary>Add-on</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/158022570-693c4f3c-c9a1-48ad-b934-1042d0899194.png)

  
</details>

