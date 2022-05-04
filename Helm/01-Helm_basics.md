<details>
<summary>Helm - Introduction</summary>
<br>

  <img width="811" alt="image" src="https://user-images.githubusercontent.com/75510135/166689345-525d316a-c962-4085-86ff-a30bb2e54ab9.png">

  <img width="804" alt="image" src="https://user-images.githubusercontent.com/75510135/166689401-e2277986-26d0-43a3-9a4f-4c7312c0a949.png">

  
</details>

<details>
<summary>Helm - CLI</summary>
<br>

  <img width="805" alt="image" src="https://user-images.githubusercontent.com/75510135/166689481-cbc0c576-b3ec-4ae3-b5a7-56f347712861.png">

</details>

<details>
<summary>helm - Charts - packages</summary>
<br>

  <img width="819" alt="image" src="https://user-images.githubusercontent.com/75510135/166689599-b2e2c4ff-bb05-4643-9259-5472310e4f22.png">

  <img width="806" alt="image" src="https://user-images.githubusercontent.com/75510135/166689688-79620c45-ffaa-4c7b-bf32-ecee7c937b65.png">

</details>

<details>
<summary>Helm Repo and Releases</summary>
<br>

  <img width="822" alt="image" src="https://user-images.githubusercontent.com/75510135/166689790-aa2eb901-826d-441f-83aa-f83eabd0eb85.png">

  
</details>

- https://helm.sh/docs/intro/quickstart/

<details>
<summary>Installation of Helm</summary>
<br>

  ```
  Installing and Running HELM on Kubernetes

## Install helm

    wget https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz
    tar -xzvf helm-v3.8.2-linux-amd64.tar.gz
    mv linux-amd64/helm /usr/local/bin/helm


##Verify Helm Package

helm -h


## Initialize helm

    kubectl create -f helm-rbac.yml
   
apiVersion: v1
kind: ServiceAccount
metadata:
name: helm-tiller
namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
name: helm-tiller
roleRef:
apiGroup: rbac.authorization.k8s.io
kind: ClusterRole
name: cluster-admin
subjects:
- kind: ServiceAccount
name: helm-tiller
namespace: kube-system
  
   helm init --service-account helm-tiller


##Verify Where it deployed

kubectl get pods -n kube-system


##Serch for some application like

helm search <Application Name>


##Install Application via Helm

helm install <Application Name>

- Each installation of a Helm chart to your cluster is referred to as a release.

- With Helm it’s easy to have multiple releases installed to a single cluster, each with its own specific configuration.


    helm install --name <releasename> <ApplicationName>
  ```
</details>

<details>
<summary>Create & Deploy Helm Charts</summary>
<br>

  ```
  Create & Deploy HELM Chart on Cluster

##Create HELM Chart

- helm create <chart-name>

- Name of the chart provided here will be the name of the directory where the chart is created and stored.


```

Let's understand the relevance of these files and folders created for us:


Chart.yaml: This is the main file that contains the description of our chart

values.yaml: this is the file that contains the default values for our chart

templates: This is the directory where Kubernetes resources are defined as templates

charts: This is an optional directory that may contain sub-charts

```


##HELM Commands for Chart

- helm lint <chart-full-path>

#This is a simple command that takes the path to a chart and runs a battery of tests to ensure that the chart is well-formed


- helm template <chart-full-path>

#This will generate all templates with variables without a Tiller Server, for quick feedback, and show the output. Now that we know everything is OK, we can deploy the chart:



- helm install --name <release-name> <chart-full-path>

#Run this command to install the chart into the Kubernetes cluster:


- helm ls --all

#We would like to see which charts are installed as what release.


- helm upgrade <release-name> <chart-full-path>

#This command helps us to upgrade a release to a specified or current version of the chart or configuration:


- helm rollback <release-name> <release-version>

#This is the command to rollback a release to the previous version:


- helm delete --purge <release-name>

#We can use this command to delete a release from Kubernetes:
  ```
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
