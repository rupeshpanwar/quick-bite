* Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/                   *
* https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/                     *
* https://kubernetes.io/docs/tasks/administer-cluster/namespaces/                                 *
* https://kubernetes.io/blog/2016/08/kubernetes-namespaces-use-cases-insights/                    *
***************************************************************************************************

***************************************************************************************************

In this Demo:
-------------
We will create the new Namespace and deploy sample Pod in that new Namespace.

***************************************************************************************************

1. Creating NameSpace:
~~~~~~~~~~~~~~~~~~~~~~

1a). Using YAML:
----------------
# dev-ns.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev


1b). Using Imepratively:
-------------------------
kubectl create namespace test


***************************************************************************************************

2. Displaying Namespace
~~~~~~~~~~~~~~~~~~~~~~~
kubectl get ns [NAMESPACE-NAME]
kubectl get ns [NAMESPACE-NAME] -o wide
kubectl get ns [NAMESPACE-NAME] -o yaml
kubectl get pods –-namespace=[NAMESPACE-NAME]

kubectl describe ns [NAMESPACE-NAME]


***************************************************************************************************

3. Creating Pod Object in Specific NameSpace:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

kubectl run nginx --image=nginx --namespace=dev

Validate:
----------
kubectl get pods
kubectl get pods -n dev



***************************************************************************************************

4. Displaying Objects in All Namespace:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

kubectl get pods -A
or
kubectl get [object-name] --all-namespaces


***************************************************************************************************

5. Setting the namespace preference:
------------------------------------

Note: 
-----
1. You can permanently save the namespace for all subsequent kubectl commands in that context.
2. --minify=false: Remove all information not used by current-context from the output

Syntax: 
kubectl config set-context --current --namespace=<insert-namespace-name-here>

-----------

kubectl config view --minify | grep namespace:
kubectl get pods

kubectl config set-context --current --namespace=test
kubectl config view --minify | grep namespace:
kubectl run redis --image=redis 
kubectl get pods

kubectl config set-context --current --namespace=default
kubectl config view --minify | grep namespace:
kubectl run httpd --image=httpd


***************************************************************************************************

6. Deleting Namespaces
~~~~~~~~~~~~~~~~~~~~~~
kubectl delete pods nginx -n dev
kubectl delete pods redis -n test
kubectl delete pods httpd
kubectl get pods -A

kubectl get ns
kubectl delete ns dev
kubectl delete ns test
kubectl get ns
kubectl get pods

In this Exercise:
-----------------
You will create the new Namespace and deploy sample Pod in that new Namespace.


PRE-REQ: 
--------
a. To successfully finish this exercise, It is important to go through Namespace Concept and Demo videos in this series.
b. You can refer to Kuberenetes Docs for help when needed.


***************************************************************************************************


STEP-1: Displaying Existing Namespaces:
---------------------------------------
a. K8s Cluster will have few Namespaces before we create new one. Display the existing Namespaces inside the cluster.


***************************************************************************************************


STEP-2: Create new namespace:
-----------------------------
a. Create new NameSpace imperatively using "kubectl create..." command with below config.

NameSpace Name: dev


***************************************************************************************************


STEP-3: Validate the NameSpace: 
-------------------------------
a. Display all Namespaces inside the K8s Cluster. Ensure "dev" Namespace is part of this output
b. Display complete details of "dev" namespace.
c. Display "dev" namespace and redirect the output to YAML format.
d. Check to see if there are any Pods in "dev" namespace.


***************************************************************************************************


STEP-4: Deploy Pod in "dev" Namespace: 
--------------------------------------
a. Deploy sample "nginx-pod" in "dev" namespace by running "kubectl run..." command
b. Display "nginx-pod" in the "dev" namespace
c. Display the logs of "nginx-pod" in "dev" namespace
d. Display the CPU and Memory usage of Pods in "dev" namespace


***************************************************************************************************


STEP-5: Deploy Pod in ALL Namespaces: 
-------------------------------------
a. Display Pods in ALL namespaces.
b. Display CPU and Memory usages of Pods in ALL namespaces. Then Sort the output by CPU
c. Display CPU and Memory usages of Pods in ALL namespaces. Then Sort the output by Memory


***************************************************************************************************


STEP-6: Setting default namespace:
----------------------------------
a. Set the "dev" namespace as default by running "kubectl config...."
b. Deploy the redis-pod with "redis" image in dev namespace WITHOUT mentioning the "dev" namespace specifically.
c. Display the Pods using "kubectl get pods". Ensure this command display Pods in "dev" namespace.


***************************************************************************************************


STEP-7: Delete the NameSpace:
-----------------------------
a. Delete the "nginx-pod, redis-pod" Pods in "Dev" namespace
b. Delete the "dev" namespace
c. Display all Namespaces. Ensure "dev" namespace is NOT shown in the output.


***************************************************************************************************

