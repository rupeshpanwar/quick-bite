<details>
<summary>Introduction</summary>
<br>
  
  <img width="992" alt="image" src="https://user-images.githubusercontent.com/75510135/166147758-ab29688e-2c88-4164-b1f6-2daf27a866cb.png">

  <img width="731" alt="image" src="https://user-images.githubusercontent.com/75510135/166147742-154d1be4-8b17-4751-bffb-b8405578c353.png">

  <img width="1007" alt="image" src="https://user-images.githubusercontent.com/75510135/166147731-06a9adfe-76bc-4587-a924-1a84bebe7fbe.png">

  
  <img width="1012" alt="image" src="https://user-images.githubusercontent.com/75510135/166147720-7d95ff30-8d64-4913-afa7-602dd9ed9386.png">


  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/166147714-052b75a9-ff5b-4f6c-a94c-f7f91184af63.png">

</details>

<details>
<summary>Ingress Controller</summary>
<br>

  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/166147714-052b75a9-ff5b-4f6c-a94c-f7f91184af63.png">

  <img width="931" alt="image" src="https://user-images.githubusercontent.com/75510135/166147933-d8099cad-7f70-4276-bad6-47c558d5a21f.png">

  <img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/166147924-f211d535-7c66-4d56-b797-5a3b017cc3db.png">

  <img width="899" alt="image" src="https://user-images.githubusercontent.com/75510135/166147913-436a1514-7769-4f6f-afd9-c5a011a57adc.png">

</details>

<details>
<summary>Ingress Controller - Configuration</summary>
<br>
  
  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/166148069-24a86bf5-8ba2-4397-94c0-32d7cb560742.png">


  <img width="1015" alt="image" src="https://user-images.githubusercontent.com/75510135/166148047-40c3f39e-9c1f-46aa-af3e-8041e49a244a.png">

</details>

<details>
<summary>Ingress Resources ( Rules )</summary>
<br>

  <img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/166148246-4cc377f9-cdc9-4546-bfd7-a6718f8ff090.png">

  <img width="584" alt="image" src="https://user-images.githubusercontent.com/75510135/166148222-e2e0400b-ffa6-41fb-823b-45f2e9e0ff1c.png">

  <img width="972" alt="image" src="https://user-images.githubusercontent.com/75510135/166148201-3dfd5c69-5112-4dd3-9eed-121038b546f9.png">

  <img width="961" alt="image" src="https://user-images.githubusercontent.com/75510135/166148188-92015f29-9ec2-4c3c-8237-ebdafe176d43.png">

</details>

<details>
<summary>Ingress Resources - Types - Single Service/Host Name/ Host Paths</summary>
<br>

  <img width="890" alt="image" src="https://user-images.githubusercontent.com/75510135/166148528-490a916c-ad35-4f0e-a3e6-633cc98364d1.png">

  <img width="1019" alt="image" src="https://user-images.githubusercontent.com/75510135/166148517-f62a6dd7-c176-4491-9bad-4543bbb6af8c.png">

  <img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/166148497-944f728c-c481-4c31-8841-35344ff366f1.png">

  <img width="1015" alt="image" src="https://user-images.githubusercontent.com/75510135/166148455-15406ff3-6f2d-4216-9eef-31dccae019c1.png">

</details>

<details>
<summary>Practice</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/services-networking/ingress/                                *
* https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource           *
* https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-rules                  *
* https://kubernetes.io/docs/concepts/services-networking/ingress/#types-of-ingress               *
* https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/                    *



1. Configure Ingress Controller (Using Helm):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a) Install Ingress Controller:
------------------------------
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx


b) Validate Ingress Controller:
------------------------------

kubectl get deploy | grep ingress

kubectl get svc | grep ingress

kubectl get pod | grep ingress

kubectl get configmap | grep ingress

kubetl get events


==================================================================================================


OUTPUTS:
-----------
$ kubectl get deploy | grep ingress
ingress-nginx-controller   1/1     1            1           35m

$ kubectl get svc | grep ingress
ingress-nginx-controller             LoadBalancer   10.8.5.189   34.121.139.23   80:30335/TCP,443:30964/TCP   36m
ingress-nginx-controller-admission   ClusterIP      10.8.15.53   <none>          443/TCP                      36m

$ kubectl get pod | grep ingress
ingress-nginx-controller-f8df76cc4-j9kgg   1/1     Running   0          36m

$ kubectl get configmap | grep ingress
ingress-controller-leader-nginx   0      36m
ingress-nginx-controller          0      36m


***************************************************************************************************


2. Using Ingress to access Services:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-> First, will create two Pods and exposing these with services. 
-> And then will create Ingress resource, which routes requests to these services.


a). Pod-1 & Service-1 (Cat)
---------------------------

kind: Pod
apiVersion: v1
metadata:
  name: cat-app
  labels:
    app: cat
spec:
  containers:
    - name: cat-app
      image: hashicorp/http-echo
      args:
        - "-text=cat"

---

kind: Service
apiVersion: v1
metadata:
  name: cat-service
spec:
  selector:
    app: cat
  ports:
    - port: 5678  #Default port for image


=================================================================================


b). Pod-2 & Service-2 (Dog)
---------------------------	

kind: Pod
apiVersion: v1
metadata:
  name: dog-app
  labels:
    app: dog
spec:
  containers:
    - name: dog-app
      image: hashicorp/http-echo
      args:
        - "-text=dog"

---

kind: Service
apiVersion: v1
metadata:
  name: dog-service
spec:
  selector:
    app: dog
  ports:
    - port: 5678 # Default port for image
	

=================================================================================


c). Ingress resource:
--------------------

NOTE:
if running Kubernetes version 1.19 and above, use API version as networking.k8s.io/v1


------------------

apiVersion: extensions/v1beta1  
kind: Ingress
metadata:
  name: test-ingress
  annotations:
    ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
        - path: /cat
          backend:
            serviceName: cat-service
            servicePort: 5678
        - path: /dog
          backend:
            serviceName: dog-service
            servicePort: 5678


=================================================================================

Deploying:
---------- 
kubectl apply -f cat.yaml
kubectl apply -f dog.yaml
kubectl apply -f ingress.yaml

Displaing:
----------
kubectl get pods
kubectl get svc
kubectl get ingress

Testing:
--------

NOTE: 
a. You can open any webrowser and start access the putting external IP address of Ingress Controller, followed by path mentioned in the ingress resource.
b. You can also curl as shown below.

curl http://[EXTERNAL-IP-ADDRESS-OF-INGRESS-CONTROLLER]/cat
curl http://[EXTERNAL-IP-ADDRESS-OF-INGRESS-CONTROLLER]/dog
curl http://[EXTERNAL-IP-ADDRESS-OF-INGRESS-CONTROLLER]/wrong-request


***************************************************************************************************


MY OUTPUTS:
-----------

Deploying:
---------- 
$ kubectl apply -f cat.yaml
pod/cat-app created
service/cat-service created

$ kubectl apply -f dog.yaml
pod/dog-app created
service/dog-service created

$ kubectl apply -f ingress.yaml
ingress.extensions/example-ingress created


Displaing:
----------
$ kubectl get pods
NAME                                       READY   STATUS    RESTARTS   AGE
cat-app                                    1/1     Running   0          67s
dog-app                                    1/1     Running   0          56s
ingress-nginx-controller-f8df76cc4-j9kgg   1/1     Running   0          52m


Testing:
--------
$ kubectl get svc
NAME                                 TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)                      AGE
cat-service                          ClusterIP      10.8.9.71    <none>          5678/TCP                     76s
dog-service                          ClusterIP      10.8.1.48    <none>          5678/TCP                     65s
ingress-nginx-controller             LoadBalancer   10.8.5.189   34.121.139.23   80:30335/TCP,443:30964/TCP   53m
ingress-nginx-controller-admission   ClusterIP      10.8.15.53   <none>          443/TCP                      53m
kubernetes                           ClusterIP      10.8.0.1     <none>          443/TCP                      57m

$ kubectl get ingress
NAME           HOSTS   ADDRESS         PORTS   AGE
test-ingress   *       130.211.5.157   80      56s


Testing:
--------
NOTE: You can open any webrowser and start access the putting external IP address of Ingress Controller, followed by path mentioned in the ingress resource.

$ curl http://34.121.139.23/cat
cat

$ curl http://34.121.139.23/dog
dog

$ curl http://34.121.139.23/wrong-request
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

  ```
</details>

- https://kubernetes.io/docs/concepts/services-networking/ingress/

- https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource

- https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-rules

- https://kubernetes.io/docs/concepts/services-networking/ingress/#types-of-ingress

- https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

 
