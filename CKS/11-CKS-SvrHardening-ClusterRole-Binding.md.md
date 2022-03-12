- https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/


<details>
<summary>Introduction</summary>
<br>
    
  <img width="780" alt="image" src="https://user-images.githubusercontent.com/75510135/156912400-44997752-7be4-4af1-8e7b-e4ca2cdcf49f.png">

  <img width="782" alt="image" src="https://user-images.githubusercontent.com/75510135/156912410-983c6ba5-ce05-439b-8caa-eca5504897f1.png">

  <img width="764" alt="image" src="https://user-images.githubusercontent.com/75510135/156912415-68ea89db-b689-4806-8242-e0408f7f5ed5.png">

  -  RBAC
  <img width="965" alt="image" src="https://user-images.githubusercontent.com/75510135/156912438-808fddae-09bf-4828-b03b-e57d05e52061.png">

  <img width="969" alt="image" src="https://user-images.githubusercontent.com/75510135/156912448-36983ee1-3681-464e-af4f-e6d28399ec3d.png">

  <img width="975" alt="image" src="https://user-images.githubusercontent.com/75510135/156912465-8fc43a2f-6b72-4d61-a95e-fd09e4a92e0d.png">

  <img width="787" alt="image" src="https://user-images.githubusercontent.com/75510135/156912469-b3c59087-844a-462d-b05f-a960557c8f6a.png">

  - RBAC => Role => RoleBinding
  
  <img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/156912484-33a0c70d-e849-4eb3-959a-c91541d7c0e9.png">

  <img width="868" alt="image" src="https://user-images.githubusercontent.com/75510135/156912491-081aae34-3f56-43f1-a516-9de575ef3b01.png">

  <img width="893" alt="image" src="https://user-images.githubusercontent.com/75510135/156912502-a5758101-226a-4613-972b-515e41efc77f.png">

  <img width="805" alt="image" src="https://user-images.githubusercontent.com/75510135/156912508-da5442dd-6bba-40dc-a8ce-3b2cf69535b8.png">

  - Permissions
  
  <img width="892" alt="image" src="https://user-images.githubusercontent.com/75510135/156912519-e907418e-ffa2-4745-80fc-1a3a4d9634f9.png">

  
</details>

<details>
<summary>Create Role n Rolebinding</summary>
<br>

  - Scenario
  
  <img width="981" alt="image" src="https://user-images.githubusercontent.com/75510135/156912687-6d026f1f-46b0-48d0-919d-c4eba5792377.png">

  ```
  root@cks-master:~# k create ns red
namespace/red created
root@cks-master:~# k create ns blue
namespace/blue created
root@cks-master:~# k -n red create role secret-manager --verb=get --resource=secrets -oyaml --dry-run=client
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: null
  name: secret-manager
  namespace: red
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
root@cks-master:~# k -n red create rolebinding secret-manager --role=secret-manager --user=jane -oyaml --dry-run=client
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: null
  name: secret-manager
  namespace: red
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: secret-manager
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: jane
  
root@cks-master:~# k -n red create rolebinding secret-manager --role=secret-manager --user=jane
rolebinding.rbac.authorization.k8s.io/secret-manager created
  
root@cks-master:~# k -n red create role secret-manager --verb=get --resource=secrets
role.rbac.authorization.k8s.io/secret-manager created
root@cks-master:~#
  
  root@cks-master:~# k -n blue create role secret-manager --verb=get --verb=list --resource=secrets
role.rbac.authorization.k8s.io/secret-manager created
  
root@cks-master:~# k -n blue create rolebinding secret-manager --role=secret-manager --user=jane
rolebinding.rbac.authorization.k8s.io/secret-manager created
  
  root@cks-master:~# k -n red auth can-i create pods --as jane
no
root@cks-master:~# k -n red auth can-i create pods --as jane # no
no
root@cks-master:~# k -n red auth can-i get secrets --as jane # yes
yes
root@cks-master:~# k -n red auth can-i list secrets --as jane # no
no
root@cks-master:~#
root@cks-master:~# k -n blue auth can-i list secrets --as jane # yes
yes
root@cks-master:~# k -n blue auth can-i get secrets --as jane # yes
yes

root@cks-master:~# k -n default auth can-i get secrets --as jane #no
no
root@cks-master:~#
  
  ```
  
</details>


<details>
<summary>Clusterrole and ClusterRoleBinding</summary>
<br>

  <img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/156913064-e5049ccb-a515-46af-8754-631849914d5d.png">

  ```
  k create clusterrole deploy-deleter --verb=delete --resource=deployment

k create clusterrolebinding deploy-deleter --clusterrole=deploy-deleter --user=jane

k -n red create rolebinding deploy-deleter --clusterrole=deploy-deleter --user=jim


# test jane
k auth can-i delete deploy --as jane # yes
k auth can-i delete deploy --as jane -n red # yes
k auth can-i delete deploy --as jane -n blue # yes
k auth can-i delete deploy --as jane -A # yes
k auth can-i create deploy --as jane --all-namespaces # no



# test jim
k auth can-i delete deploy --as jim # no
k auth can-i delete deploy --as jim -A # no
k auth can-i delete deploy --as jim -n red # yes
k auth can-i delete deploy --as jim -n blue # no
  
  ```
</details>

<details>
<summary>Accounts & Users</summary>
<br>
    
   ![image](https://user-images.githubusercontent.com/75510135/157993744-38775167-1320-42b1-910a-e822fa15909b.png)

   ![image](https://user-images.githubusercontent.com/75510135/157993782-30374528-c461-44b8-b3aa-ec376b030547.png)

   ![image](https://user-images.githubusercontent.com/75510135/157993841-64296a0a-5a66-4881-8703-f2f783452b6f.png)

   ![image](https://user-images.githubusercontent.com/75510135/157993897-f31e63aa-d486-419a-a74a-2623c2305e6d.png)

</details>

<details>
<summary>Create Certificate , Key & AUthenticate user</summary>
<br>
    
  ![image](https://user-images.githubusercontent.com/75510135/157995276-e964d9f2-6a89-43dd-95b7-5d351afc872f.png)
   
  - create key n csr
    
  ```
    openssl genrsa -out jane.key 2048
    openssl req -new -key jane.key -out jane.csr # only set Common Name = jane


  ```
    
  <img width="828" alt="image" src="https://user-images.githubusercontent.com/75510135/157995465-684b8d4d-f961-477e-aab0-0f3532b17c56.png">

   - create K8s resource, csr.yml , sample from k8s.io
   
   ![image](https://user-images.githubusercontent.com/75510135/157995568-ec1674bd-3f25-42a6-abc9-04304da6cd77.png)


    
    apiVersion: certificates.k8s.io/v1
    kind: CertificateSigningRequest
    metadata:
      name: jane
    spec:
      groups:
      - system:authenticated
      request: todo
      signerName: kubernetes.io/kube-apiserver-client
      expirationSeconds: 86400  # one day
      usages:
      - client auth
    

    
    - create CertificateSigningRequest with base64 jane.csr
    
   >  cat jane.csr | base64 -w 0

   - copy the content and paste into csr.yaml file , request:
    

    root@cks-master:~# cat csr.yml
        apiVersion: certificates.k8s.io/v1
        kind: CertificateSigningRequest
        metadata:
          name: jane
        spec:
          groups:
          - system:authenticated
          request:
              LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ21UQ0NBWUVDQVFBd1ZERUxNQWtHQTFVRUJoTUNRVlV4RXpBUkJnTlZCQWdNQ2xOdmJXVXRVM1JoZEdVeApJVEFmQmdOVkJBb01HRWx1ZEdWeWJtVjBJRmRwWkdkcGRITWdVSFI1SUV4MFpERU5NQXNHQTFVRUF3d0VhbUZ1ClpUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQU9hcHBwZ3ZValV5T0hKRG9EVnYKa1ZPVmR5UTdNS2t4OEhKQzBFbTJiZkt0bFF5bzFSNzZoT05VYTUvNEF6V01td0JxOUllK3RPNDhDRlk2SmwrYwpNUDVwc2x2VkUyZ0UzUU9lclpvZUZsSTEzaEVwZmtyTENJNW9oWUpBMytuSUIrUlJ3QWI3MzM4QzV3Sk9pZDR5CkpCRFNGU1N5VjlBc1ZrVVJjYTB3bnZiU3hZVEV3Z1MrRTU0SVdzdDB5WWpTRWJzTDN2cGNQL0xyeFliT3BsVmMKanZVaGxSaEpKL3NJWGlJZmhwMHNidFhiZ2RvYUVBVnZrRHhkS21XQlhhenJnbzdZbEZ1YkJQOUg4UkEwbWphVwpWMmlTblRWaUplZS9VYW01VUpmOVpRYkdYdWkrcmxldEVjaU05bVN6QUczNUQ4T1M4bTFTeDVrc2g5cm13b0FPCjc5VUNBd0VBQWFBQU1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQmpGaU5EVGRaYllXZ2F5cDZURk9YU0o1eXcKNmFsUy9lSUtWL0NUUThLNFhHUVl5L0dZVlQ1L2ZldUhsNi8reXVWWGRkek9lU3JiR3RodGgxOHFpaTlHMnU3SgpHcGYyY1k0WkJlczFaaHFIc3QvR01tblBlUU50T0NSczFpYWt4TlZHOWY4NU5nTjRIZCtTQ0ovZlZEdE0xSUU2CnNuT2ZLM2Iwa2R5T3lMNm0zbkVCZDFKZnEwKzdNaWlDV0p1a3pNeXNmWkZmb0pSWC9SSE90bkN4Sk5ldHQyb2kKckkvYU5ZZzNJMGNaTE1qKzVxKy8veFlaTi92MkZvV3c0NTFqVng3SFg5S1hQSlZVUVlTTkgydTU5VGMyNGxiaApqUHZBNWt4WVRGYmNpVWJhWEI1bDMzSy9YT0ZVT05iR25EYjFycUtFMVZZNzI4SDhLYkxuR010UFNHMkQKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
          signerName: kubernetes.io/kube-apiserver-client
          expirationSeconds: 86400  # one day
          usages:
          - client auth
 
    root@cks-master:~# k -f csr.yml create
    certificatesigningrequest.certificates.k8s.io/jane created
    
   >  k get csr
    
        NAME   AGE   SIGNERNAME                            REQUESTOR          REQUESTEDDURATION   CONDITION
        jane   25m   kubernetes.io/kube-apiserver-client   kubernetes-admin   24h                 Pending

    - Now Admin shoud approve the request
    
   > k certficate approve jane
    
  <img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/157997650-59961a33-bdff-45a3-a083-bf42c3f6fee0.png">

    - now to generate the cert for jane
    
    > k get csr jane -oyaml
    
  <img width="846" alt="image" src="https://user-images.githubusercontent.com/75510135/157997799-02846047-2073-4788-9568-c265da298d19.png">

    - copy the certificate: part from yaml then generate the certificate , => cert | base64 -d > jane.crt
    
        root@cks-master:~# echo LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURPVENDQWlHZ0F3SUJBZ0lRZDV2aGZqR01RZkE5Qi83aGtNKy82akFOQmdrcWhraUc5dzBCQVFzRkFEQVYKTVJNd0VRWURWUVFERXdwcmRXSmxjbTVsZEdWek1CNFhEVEl5TURNeE1qQXhNVEF6TTFvWERUSXlNRE14TXpBeApNVEF6TTFvd1ZERUxNQWtHQTFVRUJoTUNRVlV4RXpBUkJnTlZCQWdUQ2xOdmJXVXRVM1JoZEdVeElUQWZCZ05WCkJBb1RHRWx1ZEdWeWJtVjBJRmRwWkdkcGRITWdVSFI1SUV4MFpERU5NQXNHQTFVRUF4TUVhbUZ1WlRDQ0FTSXcKRFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQU9hcHBwZ3ZValV5T0hKRG9EVnZrVk9WZHlRNwpNS2t4OEhKQzBFbTJiZkt0bFF5bzFSNzZoT05VYTUvNEF6V01td0JxOUllK3RPNDhDRlk2SmwrY01QNXBzbHZWCkUyZ0UzUU9lclpvZUZsSTEzaEVwZmtyTENJNW9oWUpBMytuSUIrUlJ3QWI3MzM4QzV3Sk9pZDR5SkJEU0ZTU3kKVjlBc1ZrVVJjYTB3bnZiU3hZVEV3Z1MrRTU0SVdzdDB5WWpTRWJzTDN2cGNQL0xyeFliT3BsVmNqdlVobFJoSgpKL3NJWGlJZmhwMHNidFhiZ2RvYUVBVnZrRHhkS21XQlhhenJnbzdZbEZ1YkJQOUg4UkEwbWphV1YyaVNuVFZpCkplZS9VYW01VUpmOVpRYkdYdWkrcmxldEVjaU05bVN6QUczNUQ4T1M4bTFTeDVrc2g5cm13b0FPNzlVQ0F3RUEKQWFOR01FUXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUhBd0l3REFZRFZSMFRBUUgvQkFJd0FEQWZCZ05WSFNNRQpHREFXZ0JRL0tReHhBUjVPcUJKZGJkTExFeFBsbGEybjlUQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFGaERnCm1STmdGTGVNL2ticWtkdkpabzZIOEdudE1EV2RBNDJlS3V2c25SUnowVk53WU4zdVlBVXMrRnRsbUE4U2JYSEcKOVFOUU40K28xQzlCWkJUUXgzRGF1NWtvVEhXMHBDeHZwa3hzbEQwVGRaaytRRkJucmFVSlQySmlLMUNVN2lPQQorUHRKMUV2aVhIV1UwK1Z1cXBrdGJtS3htSEo0Mk5SVnJ0SEdoc0w2R3ByTEY0L0xxWDFXbE15UTRDZzdxU0NQCllEbXgvY2R3Nkl2bGcxd09jdHdrU2N6Sk00c2wrYTFIZGxKTjV0V0lRNU83U3hrbGQ0UWJlbXRlc1AyTExNYXEKL3pvZ3dxWDZWMTV4NVVtUm5KeWZMNDN2Skx4am0waytkbjE4eFFSTzNyZDU4Y3UzYndTd3RsM0lEd1Y2MXZzdQp2Y3NkZTRkU0kydWNJNS95cFE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg== | base64 -d > jane.crt

    - now use the key n cert to login into k8s
    
   <img width="537" alt="image" src="https://user-images.githubusercontent.com/75510135/157998126-d7059b46-6b46-43e9-a6aa-13fd7ca16925.png">

    - add new KUBECONFIG
     
        k config set-credentials jane --client-key=jane.key --client-certificate=jane.crt --embed-certs

        k config view

        k config set-context jane --cluster=kubernetes --user=jane
    
   <img width="853" alt="image" src="https://user-images.githubusercontent.com/75510135/157998646-e43fad7c-7eee-47cf-b0d5-20e1a513b883.png">

   <img width="480" alt="image" src="https://user-images.githubusercontent.com/75510135/157998666-8f47681c-3be9-4697-8868-f392ae97f5a6.png">

    - change the conteext to user - Jane
    
   <img width="736" alt="image" src="https://user-images.githubusercontent.com/75510135/157998736-d5164bdb-e949-443f-a0b2-2d240fa55767.png">

    - check permission
    
   <img width="472" alt="image" src="https://user-images.githubusercontent.com/75510135/157998816-6ae2e09a-4e44-49d4-ab35-8cfa7533b44d.png">

    
    
</details>


<details>
<summary>Add-on</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/157998856-a5900f7e-9b39-449c-a6c4-5db12251e2fc.png)

</details>

