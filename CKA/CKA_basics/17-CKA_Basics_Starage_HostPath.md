<details>
<summary>Introduction</summary>
<br>

  <img width="440" alt="image" src="https://user-images.githubusercontent.com/75510135/166150518-56bfb4f2-4a17-41e9-889a-acfa00258b35.png">

  <img width="846" alt="image" src="https://user-images.githubusercontent.com/75510135/166150617-79f2ecea-9b14-421c-b309-25c43b91cfc7.png">

  <img width="897" alt="image" src="https://user-images.githubusercontent.com/75510135/166150713-4570a963-2c72-4f7c-87cb-d61cef37ccb6.png">

</details>

<details>
<summary>Hostpath - Volume</summary>
<br>

  <img width="808" alt="image" src="https://user-images.githubusercontent.com/75510135/166150774-dde29b77-3e75-4ce0-af39-d07cb00c6d3a.png">

</details>

<details>
<summary>Practice => HostPath - Volume</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/storage/volumes/#hostpath                                   *
* https://kubernetes.io/docs/concepts/storage/volumes/#hostpath-configuration-example             *
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/   *

# 1. HostPath YAML file

apiVersion: v1
kind: Pod
metadata:
  name: nginx-hostpath
spec:
  containers:
    - name: nginx-container
      image: nginx
      volumeMounts:
      - mountPath: /test-mnt
        name: test-vol
  volumes:
  - name: test-vol
    hostPath:
      path: /test-vol


Deploy:
-------
kubectl apply -f nginx-hostpath.yaml


***************************************************************************************************


2. Displaying Pods and Hostpath
--------------------------------

kubectl get pods

kubectl exec nginx-hostpath -- df /test-mnt


***************************************************************************************************

3. Testing: 
-----------

From HOST:
~~~~~~~~~~

a. First, will create the file on the host-path on the worker node where this pod is running.

cd /test-vol

echo "Hello from Host" > from-host.txt

cat from-host.txt


From POD:
~~~~~~~~
b. Next, we will login to the Pod and will create the test file on the host-path directory from inside the Pod.

kubectl exec nginx-hostpath -it -- /bin/sh

cd /test-mnt

echo "Hello from Pod" > from-pod.txt

cat from-pod.txt


From Host:
~~~~~~~~~~
c. Finally, we will validate that file from the worker node.

cd /test-vol

ls

cat from-pod.txt


***************************************************************************************************

5. Clean up

kubectl delete po nginx-hostpath
kubectl get po
ls /test-vol


***************************************************************************************************

MY-OUTPUT:
----------

1. Deploying:
--------------
root@master:~# kubectl apply -f pod-hostpath.yaml
pod/nginx-hostpath created

2. Displaying Pods and Hostpath:
-----------------------------
root@master:~# kubectl get pods -o wide
NAME                                        READY   STATUS    RESTARTS   AGE     IP           NODE     NOMINATED NODE   READINESS GATES
ingress-nginx-controller-7fc74cf778-9vn8d   1/1     Running   0          4h49m   10.44.0.14   worker   <none>           <none>
nginx-hostpath                              1/1     Running   0          18s     10.44.0.1    worker   <none>           <none>

root@master:~# kubectl exec nginx-hostpath -- df /test-mnt
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda1        9983268 4413176   5553708  45% /test-mnt


3. Testing:
-----------

a. First, will create the file on the host-path on the worker node where this pod is running.
---------------------------------------------------------------------------------------------
root@worker:/# cd /test-vol
root@worker:/test-vol# echo "Hello from Host" > from-host.txt
root@worker:/test-vol#
root@worker:/test-vol# cat from-host.txt
Hello from Host
root@worker:/test-vol#

b. Next, we will login to the Pod and will create the test file on the host-path directory from inside the Pod.
--------------------------------------------------------------------------------------------------------------
root@master:~# kubectl exec nginx-hostpath -it -- /bin/sh
#
# cd /test-mnt
#
# echo "Hello from Pod" > from-pod.txt
#
# cat from-pod.txt
Hello from Pod
#
# exit

c. Finally, we will validate that file from the worker node.
root@worker:/test-vol# ls
from-host.txt  from-pod.txt
root@worker:/test-vol#
root@worker:/test-vol# cat from-pod.txt
Hello from Pod
root@worker:/test-vol#

d. Delete the Pod
-----------------
root@master:~# kubcetl delete -f pod-hostpath.yaml
kubcetl: command not found
root@master:~# kubectl delete -f pod-hostpath.yaml                                                                           
pod "nginx-hostpath" deleted
root@master:~# 

e. Files are still there after deleting the Pod
----------------------------------------------
root@worker:/test-vol# ls
from-host.txt  from-pod.txt
root@worker:/test-vol#

f. Recreate the Pod with same host-path
---------------------------------------
root@master:~# kubectl apply -f pod-hostpath.yaml
pod/nginx-hostpath created
root@master:~#

g. Files are still there (if it is deployed on same worker node)
----------------------------------------------------------------
root@master:~# kubectl exec nginx-hostpath -- ls /test-mnt
from-host.txt
from-pod.txt
root@master:~#
```
</details>

<details>
<summary>Exercise</summary>
<br>
  
```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/storage/volumes/#hostpath                                   *
* https://kubernetes.io/docs/concepts/storage/volumes/#hostpath-configuration-example             *
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/   *
*                                                                                                 *
***************************************************************************************************

In this Exercise:
-----------------
You will create a Pod with HostPath volume. And test it!


NOTE:
-----
a. To successfully finish this exercise, It is important to go through HostPath volume Concept and Demo videos in this series.
b. You can refer to Kuberenetes Docs for help when needed.


***************************************************************************************************


TASK-1: Create Pod with HostPath Volume:
----------------------------------------
a. Create a Pod with HostPath volume below Configuration

Pod Name: nginx-pod
Container Image: nginx
Volume Name: hp-vol
Path: /test-vol
Mount Path: /test-mnt


***************************************************************************************************


TASK-2: Display:
----------------
a. Display Pod with Complete details. Ensure to see HostPath volume details in the output
b. Run "df" command on the "nginx-pod" to ensure you see /test-mnt mount path


***************************************************************************************************


TASK-3: Testing:
----------------
a. First, from host, create the file on the host-path on the worker node where this pod is running.
b. Next, login to the Pod and create the test file on the host-path directory from inside the Pod.
c. Finally, from Host, validate the file created in previous step from the worker node.


***************************************************************************************************


TASK-4: Cleanup
---------------
a. Delete the Pod
b. Ensure Pod is deleted.
c. Ensure, the files created in above TASK#3 are still available on the host-Path on the respective worker node

```
  
</details>
  
- https://kubernetes.io/docs/concepts/storage/volumes/
- https://kubernetes.io/docs/concepts/storage/volumes/#volume-types
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-mode
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/
