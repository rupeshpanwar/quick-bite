<details>
<summary>Introduction</summary>
<br>
  
  <img width="997" alt="image" src="https://user-images.githubusercontent.com/75510135/166106312-99691961-50f1-4478-a28f-5f5afa3f840c.png">


  <img width="832" alt="image" src="https://user-images.githubusercontent.com/75510135/166106295-14e5dba4-7fc8-4905-b4c9-b49e7673ca63.png">

</details>

<details>
<summary>Practice</summary>
<br>

  ```
* Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/                        *
*                                                                                                 *

1. Labeling Node:
-----------------

kubectl get nodes --show-labels
kubectl label nodes worker-1 disktype=ssd

kubectl get nodes --show-labels
kubectl get pods -o wide

***************************************************************************************************

2. Deploying Node-Selector YAML:
--------------------------------

# nodeSelector-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nodeselector-pod
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    disktype: ssd

-------

kubectl apply -f ns.yaml


***************************************************************************************************

3. Testing:
-----------

kubectl get pods -o wide
kubectl get nodes --show-labels

# Let's Delete and Deploy "again" to ensure Pod is deployed on the same node which is lablelled above.
kubectl delete -f ns.yaml
kubectl apply -f ns.yaml

kubectl get pods -o wide
kubectl get nodes --show-labels


***************************************************************************************************

4. Cleanup:
-----------
kubectl label nodes worker-1 disktype-
kubectl delete pods nodeselector-pod
  ```
</details>

- https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

- https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/


<details>
<summary>Resource Limits- Requests/Limits</summary>
<br>
  
  <img width="952" alt="image" src="https://user-images.githubusercontent.com/75510135/166106769-25afae77-2c81-49d2-af27-caf9a649c047.png">

  <img width="902" alt="image" src="https://user-images.githubusercontent.com/75510135/166106750-5d3adba4-bfbb-4f4c-9e88-cf0e13f2853c.png">

</details>

<details>
<summary>Resource - Yaml - Tasks</summary>
<br>

  
  <img width="949" alt="image" src="https://user-images.githubusercontent.com/75510135/166107052-d0d72928-2483-44f5-b564-f90a6ac44edc.png">

</details>

<summary>Practice - Resource Limit</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/configuration/manage-resources-containers                   *
* https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/                *
* https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/                   *
* https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits
* https://cloud.google.com/blog/products/gcp/kubernetes-best-practices-resource-requests-and-limits
* https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-memory-6b41e9a955f9   *
* https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-cpu-time-9eff74d3161b *

1. Configuring Container with "Memory" Requests and Limits:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. First, get the output of kubectl top command to find resources that are "currently consumed".
-----------------------------------------------------------------------------------------------
kubectl top nodes

===================================================================================================

b. Then, deploy this Pod with memory requests and limits as mentioned below
----------------------------------------------------------------------------
#memory-demo.yaml
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo
spec:
  containers:
  - name: memory-demo-ctr
    image: polinux/stress
    resources:
      requests:
        memory: "100Mi"
      limits:
        memory: "200Mi"
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"]



# The args section in the configuration file provides arguments for the Container when it starts. 
# The "--vm-bytes", "150M" arguments tell the Container to attempt to allocate 150 MiB of memory.

===================================================================================================

c. Deploy:
----------
kubectl apply -f memory-demo.yaml

===================================================================================================

d. Validate
-----------

kubectl get pods -o wide

kubectl top nodes

If the respective worker node has morethan 150Mi memory, then Pod should be running successfully.
Requests - specify, Pod should be scheduled on node which can minimum gurantee this Pod with 100Mi
Limits - If the node has morethan 100Mi memory free space, it can use remaining space upto 200Mi Max.
Exercise: Try scheduling the same Pod with too big for any of node in your cluster.


***************************************************************************************************


2. Configuring Container with "CPU" Requests and Limits:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can follow below link. It should be straight forward.

https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/
  ```
</details>

- https://kubernetes.io/docs/concepts/configuration/manage-resources-containers

- https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/

- https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits

- https://cloud.google.com/blog/products/gcp/kubernetes-best-practices-resource-requests-and-limits

- https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-memory-6b41e9a955f9

https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-cpu-time-9eff74d3161b
