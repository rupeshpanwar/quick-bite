<details>
<summary>Troubleshoting</summary>
<br>

  <img width="400" alt="image" src="https://user-images.githubusercontent.com/75510135/166180070-5ee276a9-321f-4a61-abbf-04a51f6a1680.png">

  
</details>

<details>
<summary>Monitoring-Layers-Metrics-Tools</summary>
<br>

  <img width="1017" alt="image" src="https://user-images.githubusercontent.com/75510135/166180262-6d09cc50-7863-4416-9e42-d77e9828592f.png">

  <img width="974" alt="image" src="https://user-images.githubusercontent.com/75510135/166180242-670e2c34-e1e4-4326-800a-a64ff9b87678.png">

  <img width="1007" alt="image" src="https://user-images.githubusercontent.com/75510135/166180421-86476329-d42d-417e-ac5e-3cb5bd2498d4.png">

  <img width="960" alt="image" src="https://user-images.githubusercontent.com/75510135/166180820-fcc36809-f41a-4faa-b9cd-52a63d1fb182.png">

 
</details>

<details>
<summary>Monitoring-Tool-Pipeline-Architecture</summary>
<br>

   <img width="1015" alt="image" src="https://user-images.githubusercontent.com/75510135/166181409-1ca92555-8c2d-4581-8a2c-aa87b8c1fe32.png">

  <img width="1016" alt="image" src="https://user-images.githubusercontent.com/75510135/166181641-c4fd8c8b-8d32-42c2-821c-2f053ddc8b03.png">

  <img width="986" alt="image" src="https://user-images.githubusercontent.com/75510135/166181821-a6b78f5c-0c11-448a-922b-f861703cf29c.png">

</details>

<details>
<summary>Mertics Server-Install</summary>
<br>
  
  <img width="978" alt="image" src="https://user-images.githubusercontent.com/75510135/166182127-022d9158-2e59-47fb-9e1b-0cb3c86b2e27.png">

  <img width="842" alt="image" src="https://user-images.githubusercontent.com/75510135/166182107-fe825d59-354e-4ebf-bdc5-8e6e3e966f39.png">

  <img width="750" alt="image" src="https://user-images.githubusercontent.com/75510135/166182064-978449a7-e566-43be-bcee-d4c9fa47ccd1.png">

  <img width="1012" alt="image" src="https://user-images.githubusercontent.com/75510135/166182045-f162e69c-7cb9-4b49-b661-550f2d184c28.png">

</details>

<details>
<summary>Practice - installation</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/#metrics-server
* https://github.com/kubernetes-sigs/metrics-server                                               *

0. Pre-Req:
-----------
Check if your cluster is running with MetricsServer by running following commands

kubectl top nodes

kubectl top pods

kubectl get pods -n kube-system | grep -i metrics

If not, go ahead with below steps. 


***************************************************************************************************

1. Download:
------------

git clone https://github.com/kubernetes-sigs/metrics-server.git


***************************************************************************************************

2. Installing Metrics Server:
-----------------------------

kubectl apply -k metrics-server/manifests/test

Give it a minute to gather the data and run this command.

kubectl get pods -n kube-system | grep -i metrics

-----------------
# Troubleshooting:

If you encounter any Image error, try updating imagePullPolicy from "Never" to "Always
in metrics-server/manifests/test/patch.yaml

kubectl delete -k metrics-server/manifests/test

vim metrics-server/manifests/test/patch.yaml
#Then update "imagePullPolicy" from "Never" to "Always" - imagePullPolicy: Always  

kubectl apply -k metrics-server/manifests/test

kubectl get pods -n kube-system | grep -i metrics


***************************************************************************************************

3. Validate:
------------

kubectl get deployment metrics-server -n kube-system 
kubectl get apiservices | grep metrics
kubectl get apiservices | grep metrics
kubectl top pods
kubectl top nodes

  ```
</details>
