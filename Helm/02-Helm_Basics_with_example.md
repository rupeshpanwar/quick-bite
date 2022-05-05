- https://github.com/rupeshpanwar/kubernetes-course-helm.git


<details>
<summary>Introduction</summary>
<br>
      

<details>
<summary>Basic Commands</summary>
<br>
      
 <img width="945" alt="image" src="https://user-images.githubusercontent.com/75510135/166863354-fc96da96-6c3c-4bf9-a890-c3a2f5d2d0fa.png">
        
</details>
      


   <img width="959" alt="image" src="https://user-images.githubusercontent.com/75510135/166863380-55201c3a-e31e-4681-b6b5-501492942647.png">

   <img width="919" alt="image" src="https://user-images.githubusercontent.com/75510135/166863404-c8acb759-c1ac-4ca8-a8cf-226176ce803d.png">

   <img width="934" alt="image" src="https://user-images.githubusercontent.com/75510135/166863459-cd4cd7e7-7e8b-427f-97c5-321002fcfff6.png">

<details>
<summary>Example</summary>
<br>
      
 <img width="991" alt="image" src="https://user-images.githubusercontent.com/75510135/166863639-04a51bf4-64be-4a83-9cb7-5fb23ca2fb93.png">
          
</details>
    
</details>

<details>
<summary>Install - Helm</summary>
<br>
      
```
Install helm (helm <3.0)

wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz
tar -xzvf helm-v2.11.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

If you want a more recent helm version (>3.0), use:

wget https://get.helm.sh/helm-v3.2.3-linux-amd64.tar.gz

Make sure to use the correct instructions below for the different helm versions. You can get the latest helm version from https://github.com/helm/helm/releases. If you want to install helm on Windows/MacOS then have a look at https://helm.sh/docs/intro/install/ for instructions.
Initialize helm (only for helm <3.0)

kubectl create -f helm-rbac.yaml
 
# helm-rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system


helm init --service-account tiller

Initialize helm (helm >3.0)

Starting from 3.0, tiller has been removed. There is no need to create a service account for tiller anymore. The only command that is mandatory is the helm repo add command below:

helm repo add stable https://kubernetes-charts.storage.googleapis.com/

Setup S3 helm repository

Make sure to set the default region in setup-s3-helm-repo.sh

./setup-s3-helm-repo.sh

Package and push demo-chart

export AWS_REGION=yourregion # if not set in ~/.aws
helm package demo-chart
helm s3 push ./demo-chart-0.0.1.tgz my-charts

```
      
</details>

<details>
<summary>Helm - Create your own charts</summary>
<br>

  <img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/166865419-240b45bc-f09c-473a-9712-87ab1186ced3.png">

  <img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/166865369-87b671e9-d932-4b3d-a8a3-96e803437136.png">

  ```
      Node demo app Chart
      Download dependencies

      helm dependency update

      Install Chart

      helm install .

      Upgrade Chart

      helm upgrade --set image.tag=v0.0.2,mariadb.db.password=$DB_APP_PASS RELEASE .

  ```
</details>
      
