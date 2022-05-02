<details>
<summary>Introduction</summary>
<br>

  <img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/166152793-485c84b0-f039-4907-9c21-851d4a7b9ec1.png">

</details>

<details>
<summary>PV - Persistent Volume</summary>
<br>

  <img width="914" alt="image" src="https://user-images.githubusercontent.com/75510135/166153009-e47f8c17-968d-4436-ab77-62e81fb5e603.png">

  <img width="1004" alt="image" src="https://user-images.githubusercontent.com/75510135/166152973-28fd0ef5-5889-44ed-a419-4de11c978614.png">

  <img width="997" alt="image" src="https://user-images.githubusercontent.com/75510135/166152990-c03a4e49-d779-45d4-9dd2-d85d029d5687.png">

  
</details>

<details>
<summary>PVC - Persistent Volume Claim</summary>
<br>

  <img width="994" alt="image" src="https://user-images.githubusercontent.com/75510135/166153212-22896678-f258-4ead-9720-0a1b51c86991.png">

  <img width="957" alt="image" src="https://user-images.githubusercontent.com/75510135/166153238-1258d855-a6d8-438f-98dc-9970165e35e4.png">

  
  <img width="1001" alt="image" src="https://user-images.githubusercontent.com/75510135/166153224-cb23bbbb-a2ab-4736-8f33-54c62cdb63bf.png">

  
</details>

<details>
<summary>Volume - Access Modes</summary>
<br>
  
  <img width="916" alt="image" src="https://user-images.githubusercontent.com/75510135/166175600-5cd2d8a7-f549-4fd7-bfd4-2e459bafc044.png">


  <img width="1017" alt="image" src="https://user-images.githubusercontent.com/75510135/166175581-479d547f-bafa-44ba-8ff3-a863a2ba51f9.png">

</details>
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes


<details>
<summary>Volume Modes</summary>
<br>

  <img width="932" alt="image" src="https://user-images.githubusercontent.com/75510135/166175938-c9709fc5-580b-4590-971e-fd801371bd8c.png">

  <img width="996" alt="image" src="https://user-images.githubusercontent.com/75510135/166175917-dd7e52a3-ba25-4853-8990-a353a099e83d.png">

</details>

- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-mode


<details>
<summary>Reclaim Policy</summary>
<br>
  
  <img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/166176853-3d897f88-dcff-4013-ae20-3b854e3e35ea.png">


  <img width="952" alt="image" src="https://user-images.githubusercontent.com/75510135/166176813-010a2d55-fd2b-4c0d-9184-c464bde4cd13.png">

  <img width="1016" alt="image" src="https://user-images.githubusercontent.com/75510135/166176786-1ecaf33a-3da4-44a3-8cef-5efa7094d249.png">

</details>

- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy


<details>
<summary>Configure Pod to use PVC</summary>
<br>
  
  <img width="947" alt="image" src="https://user-images.githubusercontent.com/75510135/166179184-b3105981-2ed7-4502-8221-b6a9cd28d4d7.png">

  <img width="969" alt="image" src="https://user-images.githubusercontent.com/75510135/166179171-56eea4b2-edf0-47fe-a904-258ea369d3c5.png">

  <img width="497" alt="image" src="https://user-images.githubusercontent.com/75510135/166179152-0c17f4d2-162e-48e6-91ca-659e0d377cbf.png">

  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/166179121-ddf66693-befb-48cc-bff7-28c08348b05a.png">

  <img width="998" alt="image" src="https://user-images.githubusercontent.com/75510135/166179091-39830aa4-27aa-4ab0-95a1-e5298fbddeb2.png">

</details>

<details>
<summary>Practice</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/                                 *
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolumeclaim
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes              *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims          *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-mode                     *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes                    *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy                  *


1. Creating Persistent Volume (PV)
----------------------------------
# pv-volume.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"


Deploy and Validate:
-------------------
kubectl apply -f pv-volume.yaml
kubectl get pv task-pv-volume


2. Creating Persistent Volume Claim (PVC)
-----------------------------------------
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi


Deploy and Validate:
-------------------
kubectl apply -f https://k8s.io/examples/pods/storage/pv-claim.yaml
kubectl get pv task-pv-volume
kubectl get pvc task-pv-claim


3. Deploying Pod with PVC
-------------------------
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage


Deploy and Validate:
-------------------
kubectl apply -f https://k8s.io/examples/pods/storage/pv-pod.yaml
kubectl get pod task-pv-pod


4. Testing
-----------

Identify the node where this Pod is deployed:
---------------------------------------------
kubectl get pods -o wide

On above respective node create a sample file:
----------------------------------------------
mkdir /mnt/data
sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html"
cat /mnt/data/index.html


Now get inside the Pod and test it:
------------------------------------

kubectl exec -it task-pv-pod -- /bin/bash

apt update
apt install curl
curl http://localhost/


5. Cleanup
----------

kubectl delete pod task-pv-pod
kubectl delete pvc task-pv-claim
kubectl delete pv task-pv-volume
  ```
</details>

<details>
<summary>Exercise</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/                                 *
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolumeclaim
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes              *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims          *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-mode                     *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes                    *
* https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy                  *
*                                                                                                 *
***************************************************************************************************


In this Exercise:
-----------------
a. You will create the PV with hostPath as volume type
b. Then you will create PVC and use that in Pod.
c. Finall will validate the same.

NOTE:
-----
a. To successfully finish this exercise, It is important to go through GCE Persistent Disk volume Concept and Demo videos in this series.
b. You can refer to Kuberenetes Docs for help when needed.


***************************************************************************************************


TASK-1. Creating Persistent Volume (PV)
----------------------------------------
a. Create the PV with below configuration

Persistent Volume Name: task-pv-volume
Storage Capacity: 10Gi
AccessModes: ReadWriteOnce
HostPath Path: /mnt/data


***************************************************************************************************


TASK-2. Creating Persistent Volume Claim (PVC)
-----------------------------------------------
a. Create the PVC which shall use above PV

PVC Name: task-pvc-volume
Storage Capacity: 10Gi
AccessModes: ReadWriteOnce


***************************************************************************************************


TASK-3. Deploying Pod with PVC:
--------------------------------
a. Create a sample Pod with above PVC


***************************************************************************************************


TASK-4. Display:
----------------
a. Display PV. Ensure it is bounded to task-pvc-volume. And the size is 10Gi
b. Display PVC. Ensure it is bounded to task-pv-volume
c. Display Pods with compelte details. Ensure to see the volume details as per configuration


***************************************************************************************************


TASK-5. Validate:
-----------------

a. Identify the node where this Pod is deployed:
b. On above respective node create a sample file in the hostPath directory
c. Now get inside the Pod, validate the file created in previous step. And create the test file from on this mount-path
d. Identify file created in the previous step (c) from the respective worker node.


***************************************************************************************************


TASK-6. Cleanup:
----------------
a. Delete the Pod, PVC, and PV
b. Ensure respective Pod, PVC, and PV is deleted successfully

```
  
</details>

- https://kubernetes.io/docs/concepts/storage/persistent-volumes/
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolumeclaim
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-mode
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy
