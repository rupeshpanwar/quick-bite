<details>
<summary>Logging</summary>
<br>

  <img width="981" alt="image" src="https://user-images.githubusercontent.com/75510135/166439801-92da1fee-553c-4466-a3a8-3bd84b5bcbba.png">

  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/166440314-17b1e7ca-44c4-442e-b91a-a8d55bcbe94a.png">

</details>

<details>
<summary>Logging Architecture</summary>
<br>

  <img width="1017" alt="image" src="https://user-images.githubusercontent.com/75510135/166440750-5a4e34f4-3720-4ae9-9144-d09071331c73.png">

  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/166441254-af2cde5c-5bb9-4cd0-ae47-43ee7b935f3d.png">

  <img width="1005" alt="image" src="https://user-images.githubusercontent.com/75510135/166441226-7f665cfb-2fbe-4f91-a4c5-99e42807ab7a.png">

  <img width="986" alt="image" src="https://user-images.githubusercontent.com/75510135/166441461-cfc7e0f7-cca2-4b05-b536-cab0c25c3063.png">

</details>

<details>
<summary>Practice</summary>
<br>
  
  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/cluster-administration/logging/                             *
* https://kubernetes.io/docs/concepts/cluster-administration/logging/#streaming-sidecar-container *
* https://kubernetes.io/docs/tasks/debug-application-cluster/                                     *
* https://kubernetes.io/docs/tasks/debug-application-cluster/logging-stackdriver/#verifying-your-logging-agent-deployment
* https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs                    *
*                                                                                                 *
***************************************************************************************************

KNOW BEFORE YOU RUN:
--------------------
When it comes to Logging, we all need to familiar with the three commands.
 
a1) kubectl logs
a2) docker logs
a3) journalctl

"kubectl logs ..." user friendly comparatively to docker logs. Also, this command plays cruicial to CKA/CKAD


***************************************************************************************************



1. Deploying sample Pods for "kubectl logs" output purpose:
-----------------------------------------------------------

# counter.yaml
apiVersion: v1
kind: Pod
metadata:
  name: one-counter-pod
spec:
  containers:
  - name: counter-container
    image: busybox
    args: [/bin/sh, -c,
            'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']

---

apiVersion: v1
kind: Pod
metadata:
  name: two-counter-pod
spec:
  containers:
  - name: counter-1
    image: busybox
    args: [/bin/sh, -c,
            'i=0; while true; do echo "From Counter-ONE: $i: $(date)"; i=$((i+1)); sleep 1; done']
  - name: counter-2
    image: busybox
    args: [/bin/sh, -c,
            'i=0; while true; do echo "From Counter-TWO:  $i: $(date)"; i=$((i+1)); sleep 1; done']


***************************************************************************************************


2. Display Container Logs using "kubectl logs" command:
-------------------------------------------------------


kubectl logs [POD-NAME]                        # dump pod logs (stdout)

kubectl logs -f [POD-NAME]                     # stream pod logs (stdout)

kubectl logs [POD-NAME] –-since=5m              # view logs for last 5 mins (h for hours)

kubectl logs [POD-NAME] --tail=20              # Display only more recent 20 lines of output in pod

kubectl logs [POD-NAME] --previous             # dump pod logs (stdout) for a previous instantiation of a container

kubectl logs [POD-NAME] > [FILE-NAME].log      # Save log output to a file

kubectl logs [POD-NAME] -c [CONTAINER-NAME]    # dump pod container logs (stdout, multi-container case)

kubectl logs [POD-NAME] --all-containers=true  # dump logs of all containers inside nginx pod

kubectl logs -l [KEY]=[VALUE]                  # dump pod logs, with label  (stdout)


***************************************************************************************************


3. Using Journalctl:
--------------------

journalctl                      #Display all messages

journalctl -r                   #Display newest log entries first (Latest to Old order)

journalctl -f                   #Enable follow mode & display new messages as they come in

journalctl –n 3                 #Display specific number of RECENT log entries

journalctl –p crit              #Display specific priority – “info”, “warning”, “err”, “crit”, “alert”, “emerg”

journalctl –u docker            #Display log entries of only specific systemd unit

journalctl –o verbose           #Format output in “verbose”, “short”, “json” and more

journalctl –n 3 –p crit         #Combining options

journalctl --since "2019-02-02 20:30:00" --until "2019-03-31 12:00:00"       # Display all messages between specific duration


***************************************************************************************************


4. Display Container Logs using "docker logs" command from respective worker node:
----------------------------------------------------------------------------------

kubectl get pods -o wide

docker ps | grep [KEY-WORD]

docker logs [CONTAINER-ID]


***************************************************************************************************

5. K8s Cluster Component Logs:
------------------------------
journalctl –u docker
journalctl –u kubelet


If K8s Cluster Configured using "kubeadm":
------------------------------------------
kubectl logs kube-apiserver-master -n kube-system | more
kubectl logs kube-controller-manager-master -n kube-system
kubectl logs kube-scheduler-master -n kube-system
kubectl logs etcd-master -n kube-system


If K8s Cluster Configured using "Hard-way (Manual)"
-----------------------------------------
journalctl –u kube-apiserver 
journalctl –u kube-scheduler
journalctl –u etcd
journalctl –u kube-controller-manager 
  ```
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
