- https://cloud.google.com/sdk/docs/cheatsheet
-  https://cloud.google.com/sdk/docs/install
- https://cloud.google.com/sdk/auth_success

- github repo for script => https://github.com/rupeshpanwar/cks-demo.git

![image](https://user-images.githubusercontent.com/75510135/155878902-0d5a2dd7-9d5d-482f-b241-d2825f8247a4.png)


<details>
<summary>Cluster Specification</summary>
<br>

  <img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/155874600-65acdf12-49b5-4aa8-9942-3504667d1519.png">

  
</details>

<details>
<summary>Setup a Google  Free account & install Gcloud CLI</summary>
<br>
  
  <img width="1221" alt="image" src="https://user-images.githubusercontent.com/75510135/155875428-e2fc0676-40f7-42ed-a9ac-466584f45817.png">
  
  - install gcloud cli => https://cloud.google.com/sdk/docs/install
  - on mac , first install wget => brew install wget
  - then run => 
  ```
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-374.0.0-darwin-x86_64.tar.gz
  tar xzf google-cloud-sdk-374.0.0-darwin-x86_64.tar.gz
  cd google-cloud-sdk
  ls
  sh install.sh
  ```
  **note , you many need to  supply Y a few times in order to complete the installation** 
  
  <img width="611" alt="image" src="https://user-images.githubusercontent.com/75510135/155876207-72ee0a46-bd2a-42e1-aead-2d8eac3cd874.png">

  - Close terminal , reopen then type => gcloud projects list
  
  <img width="677" alt="image" src="https://user-images.githubusercontent.com/75510135/155876314-3b6d8ca0-b08c-4ec0-bcef-c72cd42974d2.png">

  - authorize
  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/155876341-653b11f5-206b-4424-953b-6669dbabb8b0.png">

  - once authorize, below can be confirmed on shell
  <img width="675" alt="image" src="https://user-images.githubusercontent.com/75510135/155876423-ee8785f5-94c4-4b7d-88b8-5e8afa6af7c2.png">

  - then run below few commands to complete the setup
  
  ```
          ~ $ gcloud projects list
        PROJECT_ID            NAME              PROJECT_NUMBER
        united-option-342608  My First Project  323525197785

          ~ $ gcloud config set project united-option-342608
        Updated property [core/project].

        ~ $ gcloud compute instances list
        API [compute.googleapis.com] not enabled on project [323525197785]. Would you
        like to enable and retry (this will take a few minutes)? (y/N)?  y

        Enabling service [compute.googleapis.com] on project [323525197785]...
        Operation "operations/acf.p2-323525197785-f328c1f7-93f9-465b-9a33-29d401a2ab59" finished successfully.
        Listed 0 items.
        ~ $
  
  ```
  

</details>


<details>
<summary>Now Create K8s Cluster- Master first</summary>
<br>

  - Create 2 VMs , one master , and 2nd worker node
  <img width="875" alt="image" src="https://user-images.githubusercontent.com/75510135/155876782-842548b9-2981-41d7-b595-80662b448d2a.png">
  
  - Create master node (creating in Singapore DC)
  ```
          gcloud compute instances create cks-master --zone=asia-southeast1-a \
        --machine-type=e2-medium \
        --image=ubuntu-1804-bionic-v20201014 \
        --image-project=ubuntu-os-cloud \
        --boot-disk-size=50GB
  
  ```
 
  <img width="701" alt="image" src="https://user-images.githubusercontent.com/75510135/155877556-61987e28-6db7-4980-8ae8-895bb3065721.png">
  
  - login into cks-master machine
  
  > ~ $ gcloud compute ssh cks-master
  <img width="699" alt="image" src="https://user-images.githubusercontent.com/75510135/155877620-59fa5e83-73e9-4aba-b912-1c09b019475e.png">

  <img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/155877630-409c81cc-0d53-4fab-bf13-80c78e42aafb.png">
  
- then login as a root and run below install.sh to install the master node
  
  ```
  sudo -i
  bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)
   
  ```
  
  <img width="700" alt="image" src="https://user-images.githubusercontent.com/75510135/155877714-4e9f370d-99e9-4ad5-b3ce-5c47dea146d1.png">

  - installation status 
  
  <img width="699" alt="image" src="https://user-images.githubusercontent.com/75510135/155877914-51300ab8-9281-4248-8f29-145e37c1c05c.png">

  - keep the command safe to run on Worker node
  

**COMMAND TO ADD A WORKER NODE **
> kubeadm join 10.148.0.2:6443 --token w606fx.q0k1m2t8huvh2oq7 --discovery-token-ca-cert-hash sha256:b53227b599eb66da42e95dd86e783ef6a9407f277ee3857bac6bdf215962681b

  
</details>

<details>
<summary>Setup K8s worker node </summary>
<br>

  - Spin the worker node vm
  
  ```
  ~ $ gcloud compute instances create cks-worker --zone=asia-southeast1-a \
> --machine-type=e2-medium \
> --image=ubuntu-1804-bionic-v20201014 \
> --image-project=ubuntu-os-cloud \
> --boot-disk-size=50GB
  ```
  
  <img width="740" alt="image" src="https://user-images.githubusercontent.com/75510135/155878128-22d7e6ed-55ff-47ce-a492-cc9aa3db2f80.png">

  
  > ~ $ gcloud compute ssh cks-worker
  
  <img width="373" alt="image" src="https://user-images.githubusercontent.com/75510135/155878152-ac8ebcaa-8874-4e3a-a841-978d616e03f2.png">

  - install worker node component now
  
  ```
  sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh)
  ```
  
  - installation status
  
   <img width="733" alt="image" src="https://user-images.githubusercontent.com/75510135/155878270-34f8a8d8-8fdd-40ce-a765-87ff121c37f6.png">

   
  - below command can be run on Master node in order to obtain the token
  
  > kubeadm token create --print-join-command --ttl 0
  
  - to join the cluster n master
  
  ```
  kubeadm join 10.148.0.2:6443 --token hygr4t.59z4r2mmi0741vcp --discovery-token-ca-cert-hash sha256:b53227b599eb66da42e95dd86e783ef6a9407f277ee3857bac6bdf215962681b
  ```
  
  <img width="731" alt="image" src="https://user-images.githubusercontent.com/75510135/155878325-f32a5470-265a-47ca-aee3-5e26b715b5a1.png">

  
</details>



<details>
<summary>Validate </summary>
<br>

 
    > root@cks-master:~# kubectl get nodes
  
  ```
  NAME         STATUS   ROLES                  AGE   VERSION
cks-master   Ready    control-plane,master   15m   v1.23.4
cks-worker   Ready    <none>                 69s   v1.23.4
  ```
  
  > root@cks-master:~# kubectl get po -A
  ```
NAMESPACE     NAME                                 READY   STATUS    RESTARTS      AGE
kube-system   coredns-64897985d-l4pr8              1/1     Running   0             16m
kube-system   coredns-64897985d-ztm99              1/1     Running   0             16m
kube-system   etcd-cks-master                      1/1     Running   0             16m
kube-system   kube-apiserver-cks-master            1/1     Running   0             16m
kube-system   kube-controller-manager-cks-master   1/1     Running   0             16m
kube-system   kube-proxy-fk4bn                     1/1     Running   0             16m
kube-system   kube-proxy-kr82n                     1/1     Running   0             2m30s
kube-system   kube-scheduler-cks-master            1/1     Running   0             16m
kube-system   weave-net-8dtn7                      2/2     Running   0             2m30s
kube-system   weave-net-rtp9r                      2/2     Running   1 (16m ago)   16m
root@cks-master:~#
  
  ```
</details>

<details>
<summary>Expose Nodeport range to outside world</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/155878605-be22b7c0-85f3-4fbd-b9bc-a8fc457e470f.png)
  
  - run below command to create firewall rule
  
  > gcloud compute firewall-rules create nodeports --allow tcp:30000-40000
  
  ```
  Creating firewall...⠹Created [https://www.googleapis.com/compute/v1/projects/united-option-342608/global/firewalls/nodeports].
Creating firewall...done.                                                                                
NAME       NETWORK  DIRECTION  PRIORITY  ALLOW            DENY  DISABLED
nodeports  default  INGRESS    1000      tcp:30000-40000        False
  ```
  
</details>
  

