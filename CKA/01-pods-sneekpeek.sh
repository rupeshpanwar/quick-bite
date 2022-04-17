

1. Pod YAML with Environment Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# nginx-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
    tier: dev
spec:
  containers:
  - name: nginx-container
    image: nginx:1.18
    env:
    - name: DEMO_GREETING
      value: "Hello from the environment"
    - name: DEMO_FAREWELL
      value: "Such a sweet sorrow"



***************************************************************************************************


# 2. Deploy Pods
~~~~~~~~~~~~~~~~~
kubectl apply -f <FILENAME.YAML>
(or) 
kubectl create -f <FILENAME.YAML>


***************************************************************************************************


# 3. Display Pods
~~~~~~~~~~~~~~~~~
kubectl get pods
kubectl get pods -o wide  # Print wide output of the Pod

kubectl get pods -n <NAME-SPACE>     # Print Pods in particular NameSpace
kubectl get pods -A                  # Print Pods in all namespace

kubectl get pods <POD-NAME>
kubectl get pods <POD-NAME> -o yaml  
kubectl get pods <POD-NAME> -o json

kubectl get pods --show-labels
kubectl get pods -l app=nginx        # Print Pods with particular label


***************************************************************************************************


# 4. Print Details of Pod
~~~~~~~~~~~~~~~~~~~~~~~~~~
kubectl describe pods <POD-NAME>     


***************************************************************************************************


# 5. Editing Pod which is running
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubectl edit pods <POD-NAME>
kubectl describe pods nginx-pod | grep Image

***************************************************************************************************


# 6. Print Pod Logs
~~~~~~~~~~~~~~~~~~~
kubectl logs <POD-NAME>
kubectl logs <POD-NAME> -n <NAME-SPACE>

***************************************************************************************************


# 7. Displaying Pods by Resource Usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NOTE: Metrics-Server
~~~~~~~~~~~~~~~~~~~~
a. To run below top commands, you need to have "Metrics-Server" Installed. 
b. For step-by-step demo and instructions please refer to the "Installing Metrics Server" lecture & demos that you find in "Troubleshooting" section in this series.
https://www.udemy.com/course/ultimate-cka-certified-kubernetes-administrator/learn/lecture/26854680#questions
c. Again, below are the high-level steps.

Installing Metrics-Server:
--------------------------
git clone https://github.com/kubernetes-sigs/metrics-server.git

kubectl apply -k metrics-server/manifests/test/

NOTE: If you encounter any Image error, try updating imagePullPolicy: Always 
in metrics-server/manifests/test/patch.yaml

Give it a minute to gather the data and then run below Top Commands:

Top Command to find the CPU and Memory Usage of Pods, Nodes and Containers:
---------------------------------------------------------------------------
kubectl top pods
kubectl top pods -A
kubectl top pods -A --sort-by memory
kubectl top pods -A --sort-by cpu
kubectl top pods -n [name-space]  --sort-by cpu 
kubectl top pods -n [name-space]  --sort-by memory
kubectl top pods -n [name-space]  --sort-by memory > mem-usage.txt

***************************************************************************************************


# 8. Running operations directly on the YAML file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SYNTAX: kubectl [OPERATION] –f [FILE-NAME.yaml]

kubectl get –f [FILE-NAME.yaml]
kubectl describe –f [FILE-NAME.yaml]
kubectl edit –f [FILE-NAME.yaml]
kubectl delete –f [FILE-NAME.yaml]
kubectl apply –f [FILE-NAME.yaml]


***************************************************************************************************


# 9. Deleting Pod
~~~~~~~~~~~~~~~~~
kubectl delete pods <POD-NAME>


***************************************************************************************************



STEP-1: Deploying POD:
----------------------
Deploy sample Pod with below configuration using "kubectl run .." command.

Container Image: nginx:1.18
Pod Name: nginx-pod


***************************************************************************************************


STEP-2: Display the POD
----------------------

a. Ensure "nginx-pod" is in "Running" state.
b. Display the complete details of nginx-pod by running "..describe pod.." command
c. Identify on which node this Pod is currently running. (HINT: Run get pods with wide option).


***************************************************************************************************

STEP-3: Redirect the output:
---------------------------

a. Display "nginx-pod" using "..get pod.." and redirect the output to "YAML" format.
b. Display "nginx-pod" using "..get pod.." and redirect the output to "JSON" format.


***************************************************************************************************

STEP-4: Pod Labels & Selectors:
-------------------------------

a. Display labels of nginx-pod
b. Display Pod with label "component=kube-apiserver" in kube-system namespace.


***************************************************************************************************


STEP-5: Pod Editing:
--------------------
a. Edit the "nginx-pod" using "kubectl edit.." command and update the container image version from 1.18 to 1.19
b. Ensure the "nginx-pod" is running successfully with container image 1.19


***************************************************************************************************

STEP-6: Pod Logs:
-----------------
a. Display the "nginx-pod" logs
b. Display logs of "kube-scheduler-master" Pod. This Pod runs in "kube-system" namespace.


***************************************************************************************************

STEP-7: Resource Usage:
-----------------------
a. Ensure Metrics-Server is running inside your cluster.
b. Display the CPU and Memory usage of "nginx-pod"
c. Display resource usage of Pods in ALL namespaces
d. Display resource usage of Pods in "kube-system" namespace and sort the output by cpu usage
e. Display resource usage of Pods in "kube-system" namespace and sort the output by memory usage
f. Display resource usage of Pods in "kube-system" namespace. Sort the output by memory usage and save the o/p to a file


***************************************************************************************************

STEP-8: Delete the Pod:
-----------------------
a. Delete the "nginx-pod"
b. Ensure there are no Pods running (in the default namespace).


***************************************************************************************************
