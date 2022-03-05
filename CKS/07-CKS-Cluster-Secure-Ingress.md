
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

  
 k get svc -n ingress-nginx

     NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
    ingress-nginx-controller             NodePort    10.111.232.132   <none>        80:31902/TCP,443:31485/TCP   64m
    ingress-nginx-controller-admission   ClusterIP   10.96.20.220     <none>        443/TCP                      64m

 - curl the https port 

curl https://35.240.145.48:31485/service2 -kv
   
  <img width="790" alt="image" src="https://user-images.githubusercontent.com/75510135/156892320-ac506966-54d7-45bb-9de2-378f900e2352.png">

 - need to create TLS cert
  
  <img width="657" alt="image" src="https://user-images.githubusercontent.com/75510135/156892382-08bebfb6-763a-4bc3-9334-64b238fadf45.png">

  - n bind to host
  
  <img width="598" alt="image" src="https://user-images.githubusercontent.com/75510135/156892396-279ee602-14d8-4807-a826-cddb3a05aa53.png">

  - generate cert & key
   > openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
	- note Common Name: secure-ingress.com
  
  <img width="836" alt="image" src="https://user-images.githubusercontent.com/75510135/156892491-288532a0-7f86-4a08-8e6d-88c195318750.png">

  <img width="739" alt="image" src="https://user-images.githubusercontent.com/75510135/156892564-76a42a79-fc4f-4586-b14c-5baa5fbd928d.png">

  
>  k create secret tls secure-ingress --cert=cert.pem --key=key.pem
   secret/secure-ingress created

> k get ing,secret
  
    NAME                                       CLASS   HOSTS   ADDRESS      PORTS   AGE
    ingress.networking.k8s.io/secure-ingress   nginx   *       10.148.0.3   80      39m

    NAME                         TYPE                                  DATA   AGE
    secret/default-token-vzx4x   kubernetes.io/service-account-token   3      6d6h
    secret/secure-ingress        kubernetes.io/tls                     2      3s

  - edit ingress file and apply 
  
 > k -f secure-ingress-step2.yaml apply
  
  <img width="838" alt="image" src="https://user-images.githubusercontent.com/75510135/156892863-a7726f91-0b02-47c3-93be-a148562c0276.png">

  - curl the site again
  
  > curl https://secure-ingress.com:31485/service2 -kv --resolve secure-ingress.com:31485:35.240.145.48
  
  <img width="592" alt="image" src="https://user-images.githubusercontent.com/75510135/156892992-cb8d8355-9b49-46b9-b1e0-36dfdc3fbeba.png">

  <img width="597" alt="image" src="https://user-images.githubusercontent.com/75510135/156893010-22851590-26c8-4d73-9140-498196961cb5.png">

  
</details>

