<details>
<summary>Introduction</summary>
<br>

  <img width="910" alt="image" src="https://user-images.githubusercontent.com/75510135/166151883-cd13efa0-4b00-4bd4-adb2-bff3e186a28c.png">

</details>

<details>
<summary>Persistent Storage - GCE</summary>
<br>

  <img width="1021" alt="image" src="https://user-images.githubusercontent.com/75510135/166152111-a1ee5c66-dcab-4f11-bbf4-78c02b5252ba.png">

  <img width="1009" alt="image" src="https://user-images.githubusercontent.com/75510135/166152088-8960e5cb-3aee-4a38-92f0-c60dc2eaaabc.png">

</details>

<details>
<summary>Practice => GCE </summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://cloud.netapp.com/blog/kubernetes-persistent-storage-why-where-and-how                   *
* https://kubernetes.io/docs/concepts/storage/volumes/#regional-persistent-disk-configuration-example

KNOW BEFORE YOU RUN:
--------------------
1. If you are mounting GCE Persistent inside Pod, It might be just two step process or multiple steps.
It depends on where you running your cluster. GKE or Cluster configured with Kubeadm?

First, Due to some bug, when using gcePersistentDisk inside Pod on cluster configured with Kubeadm, we need to perform multiple steps as discussed below. At somepoint it really doesn't make sense and losts its sole purpose.

Second, It works perfectly file when mounting gcePersistentDisk inside Pod on cluster configured with GKE.

First, we will perform with kubeadm, then we will mount it inside the Pod on GKE cluster.


***************************************************************************************************


1. On Cluster Configured with Kubeadm
-------------------------------------

a. First, login and created the disk.

gcloud auth login
gcloud compute disks create --size=10GB --zone=asia-southeast1-a my-data-disk-1


b. Next, create the Pod YAML.
-----------------------------
# gce-pd.yaml
apiVersion: v1
kind: Pod
metadata:
  name: gce-pd
spec:
  containers:
  - image: mongo
    name: mongodb
    volumeMounts:
    - name: mongodb-data
      mountPath: /data/db 
  volumes:
  - name: mongodb-data
    gcePersistentDisk:
      pdName: my-data-disk-1
      fsType: ext4

c. Deploy.
---------
kubectl apply -f gce-pd.yaml


d. Find, the worker node which this Pod is deployed.
----------------------------------------------------
kubectl get pods -o wide


e. Attach the disk to respective "worker" node from Google Cloud Dashboad.
-------------------------------------------------------------------------


f. login to the respective "worker" node and run following commands
-----------------------------------------------------------------

mkfs.ext4 /dev/disk/by-id/scsi-0Google_PersistentDisk_my-data-disk-1

mkdir -p /var/lib/kubelet/plugins/kubernetes.io/gce-pd/mounts/my-data-disk-1 && mount /dev/disk/by-id/scsi-0Google_PersistentDisk_my-data-disk-1 /var/lib/kubelet/plugins/kubernetes.io/gce-pd/mounts/my-data-disk-1


g. Wait few mins. Then, login to the "master" node and display Pods and it status to ensure it is "Running"
---------------------------------------------------------------------------------------------------------
kubectl get pods 


h. Validate:
------------

kubectl exec gce-pd -it -- df /data/db


***************************************************************************************************


2. On GKE:
----------

a. First, create the disk.
--------------------------
gcloud compute disks create --size=10GB --zone=us-central1-c my-data-disk-2


b. Next, create the Pod.
------------------------
Use above file


c. Deploy.
---------
kubectl apply -f gce-pd.yaml



***************************************************************************************************

Cleanup:
--------

kubectl delete pods gce-pd

gcloud compute disks delete --zone=us-central1-a my-data-disk-1

gcloud compute disks delete --zone=us-central1-c my-data-disk-2


  ```
</details>

- https://cloud.netapp.com/blog/kubernetes-persistent-storage-why-where-and-how

- https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

- https://kubernetes.io/docs/concepts/storage/volumes/#regional-persistent-disk-configuration-example
