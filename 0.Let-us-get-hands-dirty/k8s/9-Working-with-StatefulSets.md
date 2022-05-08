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
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
