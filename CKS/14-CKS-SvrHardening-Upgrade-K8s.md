- https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/


<details>
<summary>Introduction</summary>
<br>

  <img width="564" alt="image" src="https://user-images.githubusercontent.com/75510135/158041867-8756c3cb-e277-49bd-98be-8b8378cf17c9.png">

  <img width="793" alt="image" src="https://user-images.githubusercontent.com/75510135/158041888-6230996d-b320-4b88-8487-e5ea9adf2e06.png">

  <img width="908" alt="image" src="https://user-images.githubusercontent.com/75510135/158041897-1a86750b-7be7-491d-b6b3-f5f04ac56941.png">

  <img width="707" alt="image" src="https://user-images.githubusercontent.com/75510135/158041902-6f07b989-a09b-4ab6-9fb5-0542eb9456e0.png">

  <img width="653" alt="image" src="https://user-images.githubusercontent.com/75510135/158041910-61afb2cb-df36-43e9-98af-89e7eee89101.png">

  <img width="682" alt="image" src="https://user-images.githubusercontent.com/75510135/158041921-7591c407-fba5-4eb6-b1ba-07d3b91e8a06.png">

  <img width="929" alt="image" src="https://user-images.githubusercontent.com/75510135/158041929-6132e6df-5cbf-4e6b-bdb7-a1b613f4a15b.png">

  <img width="919" alt="image" src="https://user-images.githubusercontent.com/75510135/158041938-ef662585-658b-43a0-b8e9-5e14df0fd7b1.png">

  <img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/158041977-519ece8b-13b7-41a5-a5a0-650c4f714c56.png">

  <img width="601" alt="image" src="https://user-images.githubusercontent.com/75510135/158041984-383641ca-6261-464c-94df-dbdc60e5e9d8.png">

</details>


<details>
<summary>Create Outdated cluster</summary>
<br>
 
  - run below script on Master node
  > bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/previous/install_master.sh)
                
  - run below script on Worker node
  > bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/previous/install_worker.sh)
  
  - steps to perform upgrade
   ```
                

# drain
kubectl drain cks-master

# upgrade kubeadm
apt-get update
apt-cache show kubeadm | grep 1.22
apt-mark unhold kubeadm
apt-mark hold kubectl kubelet
apt-get install kubeadm=1.22.5-00
apt-mark hold kubeadm

# kubeadm upgrade
kubeadm version # correct version?
kubeadm upgrade plan
kubeadm upgrade apply 1.22.5

# kubelet and kubectl
apt-mark unhold kubelet kubectl
apt-get install kubelet=1.22.5-00 kubectl=1.22.5-00
apt-mark hold kubelet kubectl

# restart kubelet
service kubelet restart
service kubelet status

# show result
kubeadm upgrade plan
kubectl version

# uncordon
kubectl uncordon cks-controlplane




# on worker node 
# drain
kubectl drain cks-worker

# upgrade kubeadm
apt-get update
apt-cache show kubeadm | grep 1.22
apt-mark unhold kubeadm
apt-mark hold kubectl kubelet
apt-get install kubeadm=1.22.5-00
apt-mark hold kubeadm

# kubeadm upgrade
kubeadm version # correct version?
kubeadm upgrade node

# kubelet and kubectl
apt-mark unhold kubelet kubectl
apt-get install kubelet=1.22.5-00 kubectl=1.22.5-00
apt-mark hold kubelet kubectl

# restart kubelet
service kubelet restart
service kubelet status

# uncordon
kubectl uncordon cks-node
```
      
  
</details>

