<details>
<summary>Service Discovery</summary>
<br>

  <img width="802" alt="image" src="https://user-images.githubusercontent.com/75510135/166141668-e47e6f6b-cd27-4ffb-ba5d-23dacd66f2c9.png">

  <img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/166141679-98cf9668-4cd5-4152-8fd3-d6e6bbc91ae6.png">

</details>

<details>
<summary>Service Discovery via Env Vars</summary>
<br>

  <img width="896" alt="image" src="https://user-images.githubusercontent.com/75510135/166141774-00abad10-bf19-4e1e-9bf4-d8c7610dcdbd.png">

  
</details>


<details>
<summary>Service Discovery via DNS</summary>
<br>

  <img width="1022" alt="image" src="https://user-images.githubusercontent.com/75510135/166141947-c2a7f3f0-f48d-46e2-81ca-39fb874b347d.png">

  <img width="999" alt="image" src="https://user-images.githubusercontent.com/75510135/166141926-bd90dbea-0b2f-491b-8d33-6c0b0e26c2a7.png">

  <img width="1002" alt="image" src="https://user-images.githubusercontent.com/75510135/166141918-3b7a7ca9-16a4-4da9-8e46-1e4d6134b6b4.png">

</details>

<details>
<summary>Practice - Service Discovery</summary>
<br>

  ```
  * Reference:                                                                                    *
* ----------                                                                                      *
* https://cloud.google.com/kubernetes-engine/docs/concepts/service-discovery                      *
* https://platform9.com/blog/kubernetes-service-discovery-principles-in-practice/                 *
* https://github.com/kubernetes/dns/blob/master/docs/specification.md                             *
* https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/                        *
* https://www.digitalocean.com/community/tutorials/an-introduction-to-the-kubernetes-dns-service  *
* https://sysdig.com/blog/understanding-how-kubernetes-services-dns-work/                         *  
* https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns             *

1. Service Discovery through DNS:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Deploy sample POD:
---------------------
kubectl run [POD-NAME] --image=[IMAGE-NAME] --port=80


b. Expose above app by creating ClusterIP service
-------------------------------------------------
kubectl expose pod [POD-NAME]


c. Find the Service created as expected
---------------------------------------
kubectl get svc 
or
kubectl get svc -A


d. Validate Service Discover by deploying sample application
------------------------------------------------------------
kubectl run busybox --image=busybox:1.28 --rm --restart=OnFailure -ti -- /bin/nslookup [SERVICE-NAME]


***************************************************************************************************


2. End-to-End Testing (Example):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[root@master ~]$ kubectl run nginx-pod --image=nginx --port=80
pod/nginx-pod created

[root@master ~]$ kubectl expose pod nginx-pod
service/nginx-pod exposed

[root@master ~]$ kubectl get svc
NAME           TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
kubernetes     ClusterIP   10.8.0.1      <none>        443/TCP   8m24s
nginx-pod      ClusterIP   10.8.13.206   <none>        80/TCP    18s

[root@master ~]$ kubectl get svc -A
NAMESPACE     NAME                   TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)         AGE
default       kubernetes             ClusterIP   10.8.0.1      <none>        443/TCP         8m32s
default       nginx-pod              ClusterIP   10.8.13.206   <none>        80/TCP          26s
kube-system   default-http-backend   NodePort    10.8.13.240   <none>        80:30534/TCP    8m17s
kube-system   kube-dns               ClusterIP   10.8.0.10     <none>        53/UDP,53/TCP   8m17s ****
kube-system   metrics-server         ClusterIP   10.8.14.200   <none>        443/TCP         8m15s

[root@master ~]$ kubectl run busybox --image=busybox:1.28 --rm --restart=OnFailure -ti
If you don't see a command prompt, try pressing enter.
/ # nslookup nginx-pod
Server:    10.8.0.10
Address 1: 10.8.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-pod
Address 1: 10.8.13.206 nginx-pod.default.svc.cluster.local
/ #
/ # exit
pod "busybox" deleted

[root@master ~]$ kubectl run busybox --image=busybox:1.28 --rm --restart=OnFailure -ti -- /bin/nslookup nginx-pod > nginx-svc-out.txt

[root@master ~]$ cat nginx-svc-out.txt
Server:    10.8.0.10
Address 1: 10.8.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-pod
Address 1: 10.8.13.206 nginx-pod.default.svc.cluster.local
pod "busybox" deleted
  ```
</details>

<details>
<summary>Exercise - Service Discovery</summary>
<br>
  
  ```
  In this Exercise:
-----------------
First, you will deploy the sample application and expose it within kubernetes cluster using Cluster Service.
Next, you will deploy testing pod from where we will discover the above Service from inside this test Pod.

NOTE: 
-----
a. To successfully finish this exercise, It is important to go through Service Discovery Concept and Demo videos in this series.
b. You can refer to Kuberenetes Docs for help when needed.


***************************************************************************************************

TASK-1. Deploy Pod and expose it:
---------------------------------
a. Deploy Pod and expose it within the cluster
b. Display Pod and Service to validate it is created as per your requirement.


***************************************************************************************************


TASK-2. Validate:
------------------
a. Validate Service Discover by deploying sample Pod. For example, you can run nslookup the above Service from inside this sample Pod.
b. Ensure Service Name resolves to IP address


***************************************************************************************************


TASK-3. Cleanup:
----------------
a. Delete the Sample Pods and Services
b. Ensuring Pods and Services are deleted successfully

  ```
  
</details>

- https://cloud.google.com/kubernetes-engine/docs/concepts/service-discovery

- https://platform9.com/blog/kubernetes-service-discovery-principles-in-practice/

- https://github.com/kubernetes/dns/blob/master/docs/specification.md
  
  
<details>
<summary>Endpoints</summary>
<br>

  <img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/166142710-de169a21-68c0-433f-9536-3f05a40cc4aa.png">

  <img width="988" alt="image" src="https://user-images.githubusercontent.com/75510135/166142703-97353fe6-a7cf-4f0f-bcb3-ba4e19ffb840.png">

  <img width="1016" alt="image" src="https://user-images.githubusercontent.com/75510135/166142695-123b0e80-6e9e-4936-a52a-3281ff97d3f2.png">

</details>


<details>
<summary>Practice - Endpoint</summary>
<br>

  ```
* Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/          *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/   *
* https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker              *

below deployment will create three replicas of Pod instances.
Each pod will get unique IP address. When we expose this Pod using Service object, it creates EndPoints with this Pod IPs that are back this Service.

***************************************************************************************************

1. Practice Exercise: Deploy sample application, then expose and ensure it creates respetive endpoints
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Create Sample Deployment:
----------------------------
kubectl create deployment [DEPLOYMENT-NAME] --image=nginx --replicas=3 --port=80


b. Expose the Deployment:
-------------------------
kubectl expose deploy [DEPLOYMENT-NAME]


c. Validate the Service:
------------------------
kubectl get svc | grep [DEPLOYMENT-NAME]


d. Validate the Pods:
---------------------
kubectl get pods -o wide | grep [DEPLOYMENT-NAME]


e. Ensure respective EndPoint IPs matches with respective number of Pods and It's IPs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubectl get ep


***************************************************************************************************


2. Solution: Deploy sample application, then expose and ensure it creates respetive endpoints:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

root@master:~# kubectl create deployment test-deploy --image=nginx --replicas=3 --port=80
deployment.apps/test-deploy created
root@master:~#

root@master:~# kubectl expose deploy test-deploy
service/test-deploy exposed
root@master:~#

root@master:~# kubectl get svc | grep test-deploy
test-deploy    ClusterIP   10.105.64.47    <none>        80/TCP         49s
root@master:~#

root@master:~# kubectl get pods -o wide | grep test-deploy
test-deploy-7955784f5c-bq9wz    1/1     Running   0          103s   10.44.0.10   worker   <none>           <none>
test-deploy-7955784f5c-gj98x    1/1     Running   0          103s   10.44.0.12   worker   <none>           <none>
test-deploy-7955784f5c-t7b67    1/1     Running   0          103s   10.44.0.11   worker   <none>           <none>
root@master:~#

root@master:~# kubectl get ep
NAME           ENDPOINTS                                   AGE
kubernetes     10.128.0.4:6443                             8d
nginx-deploy   10.44.0.8:80                                54m
test-deploy    10.44.0.10:80,10.44.0.11:80,10.44.0.12:80   59s
test-svc       10.44.0.5:80,10.44.0.6:80,10.44.0.7:80      94m
root@master:~#

root@master:~# kubectl get ep | grep test-deploy
test-deploy    10.44.0.10:80,10.44.0.11:80,10.44.0.12:80   76s
root@master:~#

  ```
</details>


<details>
<summary>Endpoints - Exercise</summary>
<br>
  
  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/          *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/   *
* https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker              *
*                                                                                                 *
***************************************************************************************************

In this Exercise:
-----------------
You will create the sample Deployment with three replicas.Meaning, this deployment will create three replicas of Pod instances.
Each pod will get unique IP address. When we expose this Pod using Service object, it creates EndPoints with this Pod IPs that are back this Service.



TASK-1: Create Sample Deployment:
----------------------------------
a. Create sample deployment with below configuration.

Deployment Name: nginx-deploy
Container Image: nginx
Replicas: 3


***************************************************************************************************


TASK-2: Display:
----------------
a. Display Deployment
b. Display Pods created by this Pods


***************************************************************************************************


TASK-3: Validate:
-----------------
a. Display Endpoints created by this deployment
b. Ensure there are three IPs in the Endpoint object. Match them with three Pod IPs created by this deployment. They should be the same.


***************************************************************************************************


TASK-4: Cleanup:
----------------
a. Delete the Deployment
b. Ensure Deployment is deleted
c. Ensure Pods are deleted
d. Ensure EndPoints related to this Deployment is deleted

  ```
</details>

- https://theithollow.com/2019/02/04/kubernetes-endpoints/

- https://medium.com/@karansingh010/kubernetes-endpoint-object-your-bridge-to-external-services-3fc48263b776
  
  
<details>
<summary>Pod - 2 - Service Communication</summary>
<br>

  <img width="975" alt="image" src="https://user-images.githubusercontent.com/75510135/166145301-972c449e-534b-4fe6-804e-9b0f48967874.png">

  <img width="986" alt="image" src="https://user-images.githubusercontent.com/75510135/166145288-a4c2febf-73cb-44e0-99e6-b926594f47b8.png">

</details>

<details>
<summary>NodePort - Internet - 2 - Service Communication</summary>
<br>
  
  <img width="932" alt="image" src="https://user-images.githubusercontent.com/75510135/166145587-dcb996a5-882f-4e55-b17d-522b31838dd3.png">

  <img width="1015" alt="image" src="https://user-images.githubusercontent.com/75510135/166145570-8cc27340-49b1-4638-a569-247f9c0fe491.png">

 
</details>
  
<details>
<summary>Loadbalancer - Internet - 2 - Service Communication</summary>
<br>

 <img width="998" alt="image" src="https://user-images.githubusercontent.com/75510135/166145541-23a1356c-e251-477f-896e-b9214501cfa9.png">


</details>

  
<details>
<summary>Ingress - Internet - 2 - Service Communication</summary>
<br>

 <img width="1019" alt="image" src="https://user-images.githubusercontent.com/75510135/166145524-fedee7b0-3835-42dc-95c8-ed4ea79cb12c.png">

 <img width="1010" alt="image" src="https://user-images.githubusercontent.com/75510135/166145508-0c8d9b45-fc0c-4c6e-8a17-40ee731adb2a.png">

</details>
