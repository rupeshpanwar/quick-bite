- https://github.com/kubernetes/dashboard

<details>
<summary>Introduction</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/156886014-62db020c-083c-4da6-ad82-0b566f7d8ac3.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886042-55cc5422-9000-44ea-9459-366258ef0128.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886058-cce95678-049b-41bf-95e2-d8efa7659605.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886079-06acd8ec-a6aa-434f-a4fd-25f6f736685a.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886106-645d6380-f42f-491a-af3b-ad30dec24bda.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886129-59205bc0-4826-4ec0-8be9-9cf296aebdb3.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886142-779b3488-5923-4a30-a8da-86bf7a4314f7.png)

 
</details>

<details>
<summary>Install Dashboard</summary>
<br>


  root@cks-master:~# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
  
    namespace/kubernetes-dashboard created
    serviceaccount/kubernetes-dashboard created
    service/kubernetes-dashboard created
    secret/kubernetes-dashboard-certs created
    secret/kubernetes-dashboard-csrf created
    secret/kubernetes-dashboard-key-holder created
    configmap/kubernetes-dashboard-settings created
    role.rbac.authorization.k8s.io/kubernetes-dashboard created
    clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
    rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
    clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
    deployment.apps/kubernetes-dashboard created
    service/dashboard-metrics-scraper created
    deployment.apps/dashboard-metrics-scraper created
  
  root@cks-master:~# k get ns
  
    NAME                   STATUS   AGE
    cassandra              Active   178m
    default                Active   6d4h
    kube-node-lease        Active   6d4h
    kube-public            Active   6d4h
    kube-system            Active   6d4h
    kubernetes-dashboard   Active   2m17s

  root@cks-master:~# k get -n kubernetes-dashboard pods,svc

    NAME                                             READY   STATUS    RESTARTS   AGE
    pod/dashboard-metrics-scraper-799d786dbf-vsjbl   1/1     Running   0          2m32s
    pod/kubernetes-dashboard-546cbc58cd-zj45d        1/1     Running   0          2m32s

    NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    service/dashboard-metrics-scraper   ClusterIP   10.101.1.2     <none>           8000/TCP   2m32s
    service/kubernetes-dashboard        ClusterIP   10.103.5.5     <none>          443/TCP    2m32s
  
  
  - to make it INSECURE, edit the deployment
  
  k -n kubernetes-dashboard edit deploy kubernetes-dashboard
  
 - look for the port details
  
  ![image](https://user-images.githubusercontent.com/75510135/156886898-dcbcc0e0-00bd-4875-9c9d-62f2eb5966b0.png)

  ![image](https://user-images.githubusercontent.com/75510135/156886914-28c96203-d6df-44cb-85cf-e57973daa38d.png)

  - add under pod spec
  
  ![image](https://user-images.githubusercontent.com/75510135/156886944-8a80b000-49b7-4295-8c1d-979b739b0563.png)

  - now edit the exposed service 
  
  k -n kubernetes-dashboard edit svc kubernetes-dashboard
  
  ![image](https://user-images.githubusercontent.com/75510135/156887006-25ab81cb-bba1-4cc2-93a5-06cd683741e1.png)

  ![image](https://user-images.githubusercontent.com/75510135/156887024-6850ce6b-f3fb-48ce-be84-3b0f554c08b9.png)

  - now grab  publicip of worker node n nodeport # to access the dashboard
  
  ![image](https://user-images.githubusercontent.com/75510135/156887063-8c4df7bd-9456-43db-9d50-61a8e2a3416b.png)

  
</details>

<details>
<summary>RBAC for K8s-Dashboard</summary>
<br>
  
  - below service account got created during istallation
  
    k -n kubernetes-dashboard get sa

  ![image](https://user-images.githubusercontent.com/75510135/156887507-fe1a79d9-e8f3-442b-9096-c9088d7816a4.png)

  - to find the view 
  
  k get clusterroles | grep view
  
  <img width="746" alt="image" src="https://user-images.githubusercontent.com/75510135/156887833-937d89b9-a179-4085-ac42-01d344fc0436.png">

  - check before creating the resource
  
  k -n kubernetes-dashboard create rolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view -oyaml --dry-run=client
  - create RBAC - rolebinding to map to ns kubernetes-dashboard to view the resource under this ns
  
  k -n kubernetes-dashboard create rolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view
  
  - create RBAC - Cluster rolebinding to map to ns kubernetes-dashboard to view ALL clusterwide resource under this ns

  k -n kubernetes-dashboard create clusterrolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view
  
  ![image](https://user-images.githubusercontent.com/75510135/156887923-eb9b4d07-c047-4160-9bec-38dda2ac2c59.png)

</details>
  
  
 <details>
<summary>Add-on</summary>
<br>

   ![image](https://user-images.githubusercontent.com/75510135/156887976-751071c5-c9c3-4862-8dc1-21fef0b34bd2.png)

   
</details>

  
