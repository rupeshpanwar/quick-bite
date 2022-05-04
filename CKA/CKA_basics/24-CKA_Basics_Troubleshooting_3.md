<details>
<summary>Troubleshooting Application Failure</summary>
<br>

  <img width="1000" alt="image" src="https://user-images.githubusercontent.com/75510135/166632190-85ee2dcd-ae8c-4eab-bf75-16e83abed2c0.png">

  <img width="916" alt="image" src="https://user-images.githubusercontent.com/75510135/166632151-053ddc2d-bbc0-4f67-a415-6b0f4ad4beee.png">

</details>

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-running-pod/
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-replication-controllers


<details>
<summary>Troubleshooting - Cluster Failure</summary>
<br>
  
  <img width="1004" alt="image" src="https://user-images.githubusercontent.com/75510135/166632707-5e628306-da21-4848-b27a-3b97f4f857d8.png">


  <img width="793" alt="image" src="https://user-images.githubusercontent.com/75510135/166632665-e51952bd-b461-4080-a0cd-d740d7a61732.png">

</details>

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/
- https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/08-bootstrapping-kubernetes-controllers.md

<details>
<summary>Worker Node Failure</summary>
<br>

  <img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/166633099-d49e8f39-0512-4584-b5dd-a125b7a7916f.png">

  <img width="1002" alt="image" src="https://user-images.githubusercontent.com/75510135/166633058-4b7ca20b-58e9-4a78-a5a9-3f1f8e416304.png">

  <img width="1001" alt="image" src="https://user-images.githubusercontent.com/75510135/166633033-b02d7d1b-3f7d-4baa-ad52-d790f466a23b.png">

</details>

<details>
<summary>Practice</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/                       *
* https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/                       *
* https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/08-bootstrapping-kubernetes-controllers.md

1. Troubleshooting Cluster and Nodes:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check:
------
kubectl get nodes
kubectl top node 




2. Troubleshooting Components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2a. If cluster configured with "kubeadm"
-------------------------------------------

Check:
------
kubectl get pods -n kube-system
systemctl status kubelet
systemctl status docker

Troubleshoot:
-------------
kubectl logs kube-apiserver-master -n kube-system
kubectl logs kube-scheduler-master -n kube-system
kubectl logs kube-controller-manager-master -n kube-system
kubectl logs etcd-master -n kube-system

Possible Solutions(NOTE: Does not covered all):
-----------------------------------------------
Kubelet:
systemctl enable kubelet  #Run it on all nodes (Including worker nodes)
systemctl start kubelet   #Run it on all nodes (Including worker nodes)

Docker:
systemctl enable docker   #Run it on all nodes (Including worker nodes)
systemctl start docker    #Run it on all nodes (Including worker nodes)


===================================================================================================


2b. If cluster configured with "Manual (Hard-way)"
-----------------------------------------------

Check
-----
systemctl status kube-apiserver
systemctl status kube-controller-manager 
systemctl status kube-scheduler 
systemctl status etcd

systemctl status kubelet # Run it on all nodes (Including worker nodes)
systemctl status docker  # Run it on all nodes (Including worker nodes)


Troubleshoot
------------
journalctl –u kube-apiserver 
journalctl –u kube-scheduler
journalctl –u etcd
journalctl –u kube-controller-manager 
journalctl –u kube-proxy
journalctl –u docker
journalctl –u kubelet


Possible Solutions(NOTE: Does not covered all):
------------------------------------------------
systemctl enable kube-apiserver kube-controller-manager kube-scheduler etcd
systemctl start kube-apiserver kube-controller-manager kube-scheduler etcd

Kubelet:
systemctl enable kubelet  #Run it on all nodes (Including worker nodes)
systemctl start kubelet   #Run it on all nodes (Including worker nodes)

Docker:
systemctl enable docker   #Run it on all nodes (Including worker nodes)
systemctl start docker    #Run it on all nodes (Including worker nodes)

  ```
</details>

- https://kubernetes.io/docs/concepts/cluster-administration/logging/

- https://kubernetes.io/docs/concepts/cluster-administration/logging/#logging-at-the-node-level

- https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/

- https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#troubleshooting

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/

- https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/

- https://kubernetes.io/docs/tasks/debug-application-cluster/determine-reason-pod-failure/

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application-introspection/

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/

- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-running-pod/
