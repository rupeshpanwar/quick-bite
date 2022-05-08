
<details>
<summary>Role-Based Access Control (RBAC)</summary>
<br>
This is how you dropdown.
</details>

<details>
<summary>Role-Based Access Control (RBAC)</summary>
<br>
This is how you dropdown.
</details>

Kubernetes implements a least-privilege RBAC subsystem. When enabled, it locks down a cluster and allows you to grant permissions based on specific users and groups.

The model is based on three major components:

    Subjects
    Operations
    Resources

Subjects are users and groups, and these must be managed outside of Kubernetes. Operations are what the subject is allowed to do (create, list, delete, etc.). Resources are objects on the cluster, such as Pods. Put the three together, and you have an RBAC rule. For example, Abi (subject) is allowed to create (operation) Pods (resource).

RBAC has been stable (v1) since Kubernetes 1.8 and leverages two objects that are defined in the authorization.rbac.k8s.io API group. The two objects are Roles and RoleBindings. The Role is where you define the resource and the operation that you want to allow, and the RoleBinding connects it with a subject.

<details>
<summary>Autoscaling</summary>
<br>

  The Deployments chapter showed us how to scale the number of Pod replicas manually. However, manually scaling a set of Pods does not scale (excuse the pun). As an example, if demand on your application spikes at 4:20 a.m., it’s far from ideal if you need to page an operator who will then log on to the cluster and manually increase the number of replicas. The same applies if you need to scale the number of nodes to your cluster.

With these challenges in mind, Kubernetes offers several auto-scaling technologies.

The Horizontal Pod Autoscaler (HPA) dynamically increases and decreases the number of Pods in a Deployment based on demand.

The Cluster Autoscaler (CA) dynamically increases and decreases the number of nodes in your cluster based on demand.

The Vertical Pod Autoscaler (VPA) attempts to right-size your Pods, but it’s currently an alpha product.
Horizontal Pod Autoscaler (HPA)#

HPA’s are stable resources in the autoscaling/v1 API group, and their job is to scale the number of replicas in a Deployment based on observed CPU metrics. At the time of writing, the autoscaling/v2 API is being worked on and will allow scaling based on more than just CPU.

It works like this: you define a Deployment that makes use of Pod resource requests – where each container in the Pod requests an amount of CPU. You deploy this to the cluster. You also create an HPA object that targets that Deployment and has a rule that says something like: if any Pod in this Deployment uses more than 60% of its requested CPU, spin up an additional Pod.

Once the Deployment and HPA are deployed to the cluster, scaling operations become automatic.

One thing worth noting is that HPAs update the .spec.replicas field of the targeted Deployment. While this update is recorded against the Deployment object in the cluster store, it can lead to situations where the copy of the Deployment YAML file in your external version control system gets out of sync with what is currently observed on the cluster.
Cluster Autoscaler (CA)#

CAs are all about right-sizing your Kubernetes cluster. At a high level, they increase and decrease the number of nodes in your cluster based on demand.

In more depth, CAs periodically check Kubernetes for any Pods that are in the pending state due to a lack of node resources. If it finds any, it adds nodes to the cluster so that the pending Pod(s) can be scheduled.

This requires integrations with your cluster’s underlying infrastructure platform via a public API that allows Kubernetes to add and remove nodes (cloud instances). The major cloud platforms implement Cluster Autoscaler with varying levels of support. Check your cloud provider documentation for the latest support info.

</details>


<details>
<summary>Jobs and CronJobs</summary>
<br>

  Jobs, a.k.a. batch jobs, are stable resources in the batch/v1 API group. They are useful when you need to run a specific number of a particular Pod, and you need to guarantee that they’ll all successfully complete.

A couple of subtleties worth noting:

    Jobs don’t have the concept of the desired state.
    Pods that are part of a Job are short-lived.

These two concepts separate Jobs from other objects like Deployments, DaemonSets, and StatefulSets. Whereas those objects keep a specified number of a certain Pods running indefinitely, Jobs manage a specified number of a certain Pod and make sure they complete and exit successfully.

The Job object implements the usual controller and watch loop. If a Pod that the Job object spawns fails, the Job will create another in its place. Once all the Pods managed by a Job complete, the Job itself completes.

Use cases include typical batch-type workloads.

Interestingly, Jobs can be useful even if you only need to run a single Pod through to completion. Basically, anytime you need to run one or more short-lived Pods, and you need to guarantee they complete successfully, the Job object is your friend!

CronJobs are just Jobs that run against a time-based schedule.

</details>


<details>
<summary>StatefulSets</summary>
<br>

  StatefulSets are a stable resource in the apps/v1 API group. Their use cases include stateful components for your application, such as Pods that are not intended to be ephemeral and need more order than is provided by something like a Deployment.

Stateful components of a microservices application are usually the hardest to implement, and platforms like Kubernetes have been somewhat slow to implement features to handle them. StatefulSets are a step towards improving this.

In many ways, StatefulSets are like Deployments. For example, we define them in a YAML file that we POST to the API server as the desired state. A controller implements the work on the cluster, and a background watch loop makes sure the current state matches the desired state. However, there are several significant differences. These include:

    StatefulSets give Pods deterministic meaningful names. Deployments do not.
    StatefulSets always start and delete Pods in a specific order. Deployments do not.
    Pods deployed via StatefulSet are not interchangeable. Pods deployed by Deployments are interchangeable.

Let’s quickly look at each point a bit closer.

When a Pod is created by a Deployment, its name is a combination of the name of the Deployment plus a hash. When a Pod is created by a StatefulSet, its name is a combination of the name of the StatefulSet plus an integer. The first Pod deployed by a StatefulSet gets integer 1, the second gets integer 2, and so on. This effectively names Pods according to the order they were created. Scaling up a StatefulSet will cause the new Pod to get the next integer in the list, and scaling down a StatefulSet will start by deleting the highest-numbered Pod. Finally, when a Pod managed by a StatefulSet fails, it is replaced by another Pod with the same name, ID, and IP address.

Potential use cases for StatefulSets are any services in your application that maintain state. These can include:

    Pods that require access to specific named volumes.
    Pods that require a persistent network identity.
    Pods that must come online in a particular order.

A StatefulSet guarantees all of these will be maintained across Pod failures and subsequent rescheduling operations.

Due to the more complex nature of stateful applications, StatefulSets can be complex to configure.

In summary, StatefulSets ensure a deterministic order for Pod creation and deletion based on the meaningful name of each managed Pod.

</details>

<details>
<summary>DaemonSets</summary>
<br>

  DaemonSets manage Pods and are a resource in the apps API group. They’re useful when you need a replica of a particular Pod running on every node in the cluster. Some examples include monitoring Pods and logging Pods that you need to run on every node in the cluster.

As you’d expect, it implements a controller and a watch loop. This means that you can dynamically add and remove nodes from the cluster, and the DaemonSet will ensure you always have one Pod replica on each of them.

The following command shows two DaemonSets in the kube-system namespace that exist on a newly installed 3-node cluster.

The output is trimmed so that it fits the page.

  <img width="745" alt="image" src="https://user-images.githubusercontent.com/75510135/167286580-807a573b-98a7-4965-9ebc-d5d58ead1e7d.png">

  Notice that the desired state for each DaemonSet is 3 replicas. You do not need to specify this in the DaemonSet YAML file, as it is automatically implied based on the number of nodes in the cluster.

As well as the default behavior of running one Pod replica on every cluster node, you can also run DaemonSets against subsets of nodes.

DaemonSets are stable in the apps/v1 API group and can be managed with the usual kubectl get, and kubectl describe commands. If you already understand Pods and Deployments, you will find DaemonSets really simple.

</details>


<details>
<summary>Service Meshes</summary>
<br>

  
Cloud-native applications running on Kubernetes can be complex beasts and present challenges that didn’t previously exist.

Consider the following.

We used to build and deploy complex applications as a single large monolith. This meant that most of the application components and logic shipped as a single program, and all communication between the different components was internal over sockets and named pipes. Cloud-native applications are different, as they break application components and logic into many individual components (microservices) that have to communicate over the network.

With this in mind, we have several new and important considerations:

    How do we secure the traffic between all of the application microservices?
    How to we get telemetry and visibility?
    How do we effectively control traffic?

Kubernetes is not designed or equipped to handle these but service meshes are!

At the highest level, a service mesh is a form of an intelligent network that can do things like:

    Automatically encrypt traffic between microservices
    Provide extensive application network telemetry and observability
    Provide advanced traffic control, such as, circuit breaking, latency-aware loa balancing, fault injection, retries, etc.

There are many service mesh implementations, but the two leading technologies are Istio and Linkerd. They both build on top of something called an envoy proxy and are implemented in a similar way. However, they have slightly different scopes. Istio has a broader scope, at the expense of complexity. Linkerd has a smaller scope and is arguably easier to implement and run. Both are popular, but, at the time of writing, Istio seems to be gaining more community support and uptake.

Both are implemented as Kubernetes-native applications and run their own control plane on your Kubernetes cluster.

Once deployed to your cluster, they are injected into your applications as sidecar containers. This involves injecting a service mesh container into any application Pod that you want to be “on the service mesh”.

The service mesh sidecar container is based on the envoy proxy and sets up rules to intercept all network traffic entering and exiting the Pod. This allows the service mesh sidecar container to do things such as:

    Automatically encrypt all Pod-to-Pod communication
    Send detailed telemetry to a central location
    Implement circuit breaking, A/B loading, fault injection, etc.

There can be a small performance overhead, but the cost is usually worth it.

The way a service mesh sidecar container is injected into Pods is via an admission controller. Admission controllers inspect all objects being deployed to the cluster and can implement policies such as injecting service mesh sidecars. A simple example might be a policy that injects a service mesh sidecar into every Pod being deployed to the production Namespace.

Service mesh technologies are relatively new and can sometimes be hard to configure and work with. However, many of the public clouds that offer hosted Kubernetes services allow you to deploy a service mesh as part of the hosted service. These options give you a very simple way to deploy a service mesh, but they only work on the hosted platform.

Considering the benefits, a service mesh should be a top priority when deploying important production business applications. Nobody wants to be responsible for insecure applications with limited visibility into the network traffic flow and limited options for influencing traffic.


</details>
