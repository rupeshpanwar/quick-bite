
<details>
<summary>Introduction</summary>
<br>
  
  | Topic         | Flow        |
| ------------- | ------------- |
| Ingress Service | <img width="420" alt="image" src="https://user-images.githubusercontent.com/75510135/156889242-4425cea1-e613-417c-a8a5-54c9dfea1ec1.png"> |
  | Access via | <img width="648" alt="image" src="https://user-images.githubusercontent.com/75510135/156889270-db52a2ea-d739-4111-a576-5ad18238e5fd.png"> |
  | Different Services | <img width="717" alt="image" src="https://user-images.githubusercontent.com/75510135/156889294-cc1fed1e-5b55-4a3f-bc7b-12a71a46ed2e.png">  |
</details>

<details>
<summary>Create Ingress Service</summary>
<br>
  
  | Topic         | Flow        |
| ------------- | ------------- |
| To be setupup | <img width="904" alt="image" src="https://user-images.githubusercontent.com/75510135/156889820-c909bd40-6178-4ee3-9fc9-01b0a2d8ab7c.png"> |
  | create nginx ingress | k apply -f https://raw.githubusercontent.com/rupeshpanwar/cks-course-environment/master/course-content/cluster-setup/secure-ingress/nginx-ingress-controller.yaml |
  | ------------- | ------------- |

  ```
  namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
  ```
  
  
 - list the resources and ns
   -  k get ns

      k -n ingress-nginx get pods,svc

       NAME                   STATUS   AGE
      default                Active   6d5h
      ingress-nginx          Active   3m45s
      kube-node-lease        Active   6d5h
      kube-public            Active   6d5h
      kube-system            Active   6d5h
      kubernetes-dashboard   Active   101m

      NAME                                            READY   STATUS      RESTARTS   AGE
      pod/ingress-nginx-admission-create-sr6gh        0/1     Completed   0          4m3s
      pod/ingress-nginx-admission-patch-wlg52         0/1     Completed   1          4m3s
      pod/ingress-nginx-controller-65c848c6b5-9sld8   1/1     Running     0          4m3s

      NAME                                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
      service/ingress-nginx-controller             NodePort    10.111.2.1   <none>        80:31902/TCP,443:31485/TCP   4m3s
      service/ingress-nginx-controller-admission   ClusterIP   10.96.20.2     <none>        443/TCP                      4m3s

    -  check the ingress resource 
  
       k get ing
  
    -  curl http://35.240.145.48:31902
  
     <img width="518" alt="image" src="https://user-images.githubusercontent.com/75510135/156890399-2e183521-c201-4d87-b3da-8c64ac066813.png"> 

     - create 2 services for routes 
     
      wget https://github.com/rupeshpanwar/cks-course-environment/raw/master/course-content/cluster-setup/secure-ingress/secure-ingress-step1.yaml

      k -f secure-ingress-step2.yaml create
  
      - let us now create 2 pods and expose to these 2 services created above
  
  ```
        k run pod1 --image=nginx
        k run pod2 --image=httpd

        k expose pod pod1 --port 80 --name service1
        k expose pod pod2 --port 80 --name service2
  ```
  <img width="647" alt="image" src="https://user-images.githubusercontent.com/75510135/156891654-0e4593a8-4351-4d80-bda4-9740dc13012b.png">
       
  <img width="564" alt="image" src="https://user-images.githubusercontent.com/75510135/156891670-5ae60ca1-a600-4b32-9e7b-075ad8ca635d.png">

</details>


<details>
<summary>Secure Ingress via Https</summary>
<br>
  
  <img width="951" alt="image" src="https://user-images.githubusercontent.com/75510135/156891764-89e0a053-fdad-4ed6-ab04-b6dbce3630d8.png">

</details>

