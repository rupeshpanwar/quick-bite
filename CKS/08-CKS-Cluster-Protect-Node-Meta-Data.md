- https://cloud.google.com/kubernetes-engine/docs/how-to/protecting-cluster-metadata
- https://cloud.google.com/compute/docs/storing-retrieving-metadata

<details>
<summary>Introduction</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156903975-93cd4648-f026-4d39-9479-34c4ceba34cd.png)

  ![image](https://user-images.githubusercontent.com/75510135/156903985-92f1b06c-5435-4b0f-8270-b6dc25936cfe.png)

  ![image](https://user-images.githubusercontent.com/75510135/156903999-4fc5aa41-65a1-487d-a716-34358f078a71.png)

  ![image](https://user-images.githubusercontent.com/75510135/156904062-befe896f-2e64-4276-b100-63ad2017d5d7.png)

  
</details>

<details>
<summary>Access metadata</summary>
<br>
  
  - access directly or via container 
  
  curl "http://metadata.google.internal/computeMetadata/v1/instance/disks/0" -H "Metadata-Flavor: Google"
  
  <img width="848" alt="image" src="https://user-images.githubusercontent.com/75510135/156904210-977f6cb1-3c43-4ab7-b32d-0e193bbd714d.png">

</details>


<details>
<summary>Create Networl Policy to allow or deny traffic to endpoint matadata</summary>
<br>

  - get the IP of meta data endpoint
  
  ping metadata.google.internal
  
  - create deny policy
  
  ```
  # all pods in namespace cannot access metadata endpoint
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cloud-metadata-deny
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
        - 169.254.169.254/32
  ```
 > root@cks-master:~# k -f deny.yml create
        
      networkpolicy.networking.k8s.io/cloud-metadata-deny created
  
  - try to access the endpoint again
  
  > root@cks-master:~# k exec nginx -it -- bash

 >  root@nginx:/# curl "http://metadata.google.internal/computeMetadata/v1/instance/disks/" -H "Metadata-Flavor: Google"
  
  curl: (6) Could not resolve host: metadata.google.internal
  
  - create allow policy
  
  ```
  # only pods with label are allowed to access metadata endpoint
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cloud-metadata-allow
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: metadata-accessor
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 169.254.169.254/32
  ```
  - now attach the label to pod and try to access the metadata
  
  <img width="840" alt="image" src="https://user-images.githubusercontent.com/75510135/156904616-55e8bff5-d8e2-4902-b272-0421959b16f3.png">

  
</details>

<details>
<summary>Command Summary</summary>
<br>
  
  ```
  237  vi allow.yml
  238  k -f allow.yaml create
  239  k -f allow.yml create
  240  vi deny.yml
  241  k -f deny.yml create
  242  k exec nginx -it -- bash
  243  k get pod --show-labels
  244  k label pod nginx role=metadata-accessor
  245  k get pod --show-labels
  246  k exec nginx -it -- bash
  ```
  
</details>
  
