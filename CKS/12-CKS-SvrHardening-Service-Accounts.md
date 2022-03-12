- https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/1205-bound-service-account-tokens/README.md
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
- https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin


<details>
<summary>Introduction</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/157999076-b1b7f772-ddfd-4034-b56a-2cf034ad4e0e.png)

  ![image](https://user-images.githubusercontent.com/75510135/157999087-626d403e-0df6-4a07-9088-ea091fcd0d57.png)

</details>



<details>
<summary>Create Service Account - use with Pod</summary>
<br>
  
  <img width="688" alt="image" src="https://user-images.githubusercontent.com/75510135/158001517-9e8a9358-85c5-4203-a36c-172dc176c3b7.png">

  - list sa,secret n mapped token
  
    k get sa,secrets
    k describe sa default
  
  - create new service account n list the token
  
    k create sa accessor
    k describe sa accessor
    k describe secret accessor-token-vqbhz
  
  <img width="843" alt="image" src="https://user-images.githubusercontent.com/75510135/158001790-ec996aed-15f5-4ed9-a5c8-8e8d70950b62.png">

  - now create a pod under this secret
  
   k run accessor --image=nginx --dry-run=client -oyaml > accessor.yml
  
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: accessor
        name: accessor
      spec:
        containers:
        - image: nginx
          name: accessor
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
  
  
  <img width="354" alt="image" src="https://user-images.githubusercontent.com/75510135/158001900-9547c7f4-1ded-4c38-9b56-f198faf5baf6.png">

  - create pod now
  
   k -f accessor.yml create
  
  - login into pod n grep the secret
  
   k exec -it accessor -- bash
  
  - mount the secret n then curl the k8s website
   
   mount | grep sec
  
   cd 
   cat /run/secrets/kubernetes.io/serviceaccount/token

   curl https://kubernetes.default -k -H "Authorization: Bearer SA_TOKEN"
  
  <img width="549" alt="image" src="https://user-images.githubusercontent.com/75510135/158002214-7e86fca8-00c5-4e47-b582-94bd09ed5ae9.png">

  
</details>



<details>
<summary>Disable Service account mounting</summary>
<br>

  <img width="599" alt="image" src="https://user-images.githubusercontent.com/75510135/158002486-e5aa8fef-ff7a-424a-a0d9-05253534e690.png">

  - edit the yml file for accessor created above
  
  <img width="405" alt="image" src="https://user-images.githubusercontent.com/75510135/158002604-c99398c2-10c1-4421-b0ff-9dc1f9d5cbc6.png">

  >  k -f accessor.yml replace --force
  
  - grep the secret now 
  
  <img width="419" alt="image" src="https://user-images.githubusercontent.com/75510135/158002682-f97a780e-788f-478c-913a-dbdeb976b879.png">

  - inspect the pod now
  
  > k edit pod accessor
  
  
</details>



<details>
<summary>Limit the service account via RBAC</summary>
<br>
  
  <img width="905" alt="image" src="https://user-images.githubusercontent.com/75510135/158003076-6b20201c-0592-4d3f-99e0-e68cbe4efc5d.png">

  <img width="807" alt="image" src="https://user-images.githubusercontent.com/75510135/158003153-9adde5ed-7703-4ca4-a225-5b75e51098bb.png">

      k auth can-i delete secrets --as system:serviceaccount:default:accessor
      k create clusterrolebinding accessor --clusterrole edit --serviceaccount default:accessor
      k auth can-i delete secrets --as system:serviceaccount:default:accessor
</details>
