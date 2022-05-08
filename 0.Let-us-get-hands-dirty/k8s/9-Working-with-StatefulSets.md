<details>
<summary>Introduction to StatefulSets</summary>
<br>

  In this chapter, you’ll learn how to use StatefulSets to deploy and manage stateful applications on Kubernetes.

For the purposes of this chapter, we’re defining a stateful application as an application that creates and saves valuable data. An example might be an app that saves data about client sessions and uses it for future client sessions. Other examples include databases and other data stores.

We’ll divide the chapter as follows:

    The theory of StatefulSets
    Hands-on with StatefulSets

The theory section will introduce you to the way StatefulSets work and what they bring to the table. But don’t worry if you don’t understand everything at first, we’ll cover most of it again when we walk through the hands-on section.
The theory of StatefulSets#

It’s often useful to compare StatefulSets with Deployments. Both are first-class objects in the Kubernetes API and follow the typical Kubernetes controller architecture. These controllers run as reconciliation loops that watch the state of the cluster, via the API server, and are constantly moving the observed state of the cluster into sync with the desired state. Deployments and StatefulSets also support self-healing, scaling, updates, and more.

However, there are some vital differences. StatefulSets guarantee:

    Predictable and persistent Pod names
    Predictable and persistent DNS hostnames
    Predictable and persistent volume bindings

These three properties form the state of a Pod, sometimes referred to as the Pods sticky ID. This state/sticky ID is persisted across failures, scaling, and other scheduling operations, making StatefulSets ideal for applications where Pods are a little bit unique and not interchangeable.

As a quick example, failed Pods managed by a StatefulSet will be replaced by new Pods with the exact same Pod name, the exact same DNS hostname, and the exact same volumes. This is true even if the replacement Pod is started on a different cluster Node. The same is not true of Pods managed by a Deployment.

The following YAML snippet shows some of the fields in a typical StatefulSet manifest.
  <img width="442" alt="image" src="https://user-images.githubusercontent.com/75510135/167281629-cc07f9fe-fa4b-4488-9a20-2324b5605b9a.png">

  The name of the StatefulSet is tkb-sts and it defines three Pod replicas running the mongo:latest image. You post this to the API server, it’s persisted to the cluster store, the work is assigned to cluster Nodes, and the StatefulSet controller monitors the shared state of the cluster and makes sure the observed state matches the desired state.

That’s the big picture. Let’s take a look at some of the major characteristics of StatefulSets before walking through an example.
StatefulSet Pod naming#

All Pods managed by a StatefulSet get predictable and persistent names. These names are vital and are at the core of how Pods are started, self-healed, scaled, deleted, attached to volumes, and more.

The format of StatefulSet Pod names is <StatefulSetName>-<Integer>. The integer is a zero-based index ordinal, which is just a fancy way of saying “number starting from 0”. The first Pod created by a StatefulSet always gets index ordinal “0”, and each subsequent Pod gets the next highest ordinal. Assuming the previous YAML snippet, the first Pod created will be called tkb-sts-0, the second will be called tkb-sts-1, and the third will be called tkb-sts-2.

Be aware that StatefulSet names need to be valid DNS names, so no exotic characters! 

</details>

<details>
<summary>Ordered Creation and Deletion</summary>
<br>
Creation#

StatefulSets create one Pod at a time and always wait for previous Pods to be running and ready before creating the next. This is different from Deployments that use a ReplicaSet controller to start all Pods at the same time, causing potential race conditions.

  ```
  apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: tkb-sts
spec:
  selector:
    matchLabels:
      app: mongo
  serviceName: "tkb-sts"
  replicas: 3
  template:
    metadata:
      labels:
        app: mongo
    spec:
      containers:
      - name: ctr-mongo
        image: mongo:latest
        ...
  ```
  
  <img width="912" alt="image" src="https://user-images.githubusercontent.com/75510135/167282846-b1a48afe-a183-4785-b5f9-76efc5854344.png">

  
</details>

<details>
<summary>Scaling</summary>
<br>

  

Scaling operations are also governed by the same ordered startup rules. For example, scaling from 3 to 5 replicas will start a new Pod, called tkb-sts-3, and will wait for it to be running and ready before creating tkb-sts-4. Scaling down follows the same rules in reverse – the controller terminates the Pod with the highest index ordinal (number) first and waits for it to fully terminate before terminating the Pod with the next highest ordinal.

Knowing the order in which Pods will be scaled down, as well as knowing that Pods will not be terminated in parallel, is a game changer for many stateful apps. For example, clustered apps that store data are usually at high risk of losing data if multiple replicas go down at the same time. StatefulSets guarantee this will never happen, and you can insert other delays via things like terminationGracePeriodSeconds to further control the scaling down process. All in all, StatefulSets bring a lot to the table for clustered apps that store data.

Finally, it’s worth noting that StatefulSet controllers do their own self-healing and scaling. This is architecturally different from Deployments, which use a separate ReplicaSet controller for these operations.
</details>

<details>
<summary>Deleting StatefulSets</summary>
<br>

  There are two major things to consider when deleting StatefulSets.

First, deleting a StatefulSet does not terminate Pods in order. With this in mind, you may want to scale a StatefulSet to 0 replicas before deleting it.

You can also use terminationGracePeriodSeconds to further control the way Pods are terminated. It’s common to set this to at least 10 seconds to give applications running in Pods a chance to flush local buffers and safely commit any writes that are still in flight.
</details>
  
<details>
<summary>Volumes and Handling Failures</summary>
<br>

  <img width="884" alt="image" src="https://user-images.githubusercontent.com/75510135/167283006-774f364d-ae99-4b3e-a946-b158adbb5b7c.png">

  You can see how each Pod and volume (PVC) is created and how the names connect volumes to Pods.

Volumes are appropriately decoupled from Pods via the normal Kubernetes persistent volume subsystem constructs (PersistentVolumes and PersistentVolumeClaims). This means volumes have separate lifecycles to Pods and allows volumes to survive Pod failures and termination operations. For example, any time a StatefulSet Pod fails or is terminated, the associated volumes are unaffected. This allows replacement Pods to attach to the same storage as the Pods they’re replacing. This is true, even if the replacement Pod is scheduled to a different cluster Node.

The same is true for scaling operations. If a StatefulSet Pod is deleted as part of a scale down operation, subsequent scale up operations will attach new Pods to the existing volumes that match their names.

This behavior can be a lifesaver if you accidentally delete a StatefulSet Pod, especially if it’s the last replica!
Handling failures#

The StatefulSet controller observes the state of the cluster and attempts to keep the observed state in sync with the desired state. The simplest example is a Pod failure. If you have a StatefulSet, called tkb-sts with 5 replicas, and tkb-sts-3 fails, the controller will start a replacement Pod with the same name and attach it to the same volumes.

However, if a failed Pod recovers after Kubernetes has replaced it, you’ll have two identical Pods on the network writing to the same volumes. This can result in data corruption. With this in mind, the StatefulSet controller is extremely careful with how it handles failures.

Potential Node failures are especially difficult to deal with. For example, if Kubernetes loses contact with a Node, how does it know if the Node is down and will never recover, or if it’s a temporary glitch such as a network partition or a crashed kubelet, or if the Node is simply rebooting? To complicate matters further, the controller can’t even force the Pod to terminate, as the kubelet may never receive the instruction. With these things in mind, manual intervention is needed before Kubernetes will replace Pods on failed Nodes.


</details>
 
<details>
<summary>Network and Headless Services</summary>
<br>

  We’ve already said that StatefulSets are for applications that need Pods to be predictable and longer-lived. As a result, other parts of the application, as well as other applications, may need to connect directly to individual Pods. To make this possible, StatefulSets use a headless Service to create predictable DNS hostnames for every Pod replica. Other apps can then query DNS for the full list of Pod replicas and use these details to connect directly to Pods.
Example#

The following YAML snippet shows a headless Service, called “mongo-prod”, that is listed in the StatefulSet YAML as the governing Service.

  <img width="593" alt="image" src="https://user-images.githubusercontent.com/75510135/167283176-8d8d8a6f-23bf-4d1d-9ffb-fdf436aa01da.png">

  Let’s explain the terms headless Service and governing Service.

A headless Service is just a regular Kubernetes Service object with spec.clusterIP set to None. It becomes a StatefulSets governing Service when you list it in the StatefulSet manifest under spec.serviceName.

When the two objects are combined like this, the Service will create DNS SRV records for each Pod replica matching the label selector of the headless Service. Other Pods can then find members of the StatefulSet by performing DNS lookups against the name of the headless Service. You’ll see this in action later since applications will need to know to do this.



  
</details>
  

  
  
