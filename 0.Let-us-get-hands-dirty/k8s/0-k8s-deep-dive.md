
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
<summary>Masters and Nodes: Masters</summary>
<br>

  <img width="517" alt="image" src="https://user-images.githubusercontent.com/75510135/167288228-a7172add-3110-4d42-b7ef-8251f059cd44.png">

  A Kubernetes cluster is made of masters and nodes. These are Linux hosts that can be virtual machines (VM), bare metal servers in your data center, or instances in a private or public cloud.
Masters (control plane)#

A Kubernetes master is a collection of system services that make up the control plane of the cluster.

The simplest setups run all the master services on a single host. However, this is only suitable for labs and test environments. For production environments, multi-master high availability (HA) is a must have. This is why the major cloud providers implement HA masters as part of their hosted Kubernetes platforms, such as Azure Kubernetes Service (AKS), AWS Elastic Kubernetes Service (EKS), and Google Kubernetes Engine (GKE).

Generally speaking, running 3 or 5 replicated masters in an HA configuration is recommended.

It’s also considered a good practice not to run user applications on masters. This allows masters to concentrate entirely on managing the cluster.

Let’s take a quick look at the different master services that make up the control plane.
The API server#

The API server is the Grand Central Station of Kubernetes. All communication, between all components, must go through the API server. We’ll get into the details of this later in the course, but it’s important to understand that internal system components, as well as external user components, all communicate via the same API.

It exposes a RESTful API that you POST YAML configuration files to over HTTPS. These YAML files, which we sometimes call manifests, contain the desired state of your application. This desired state includes things like; which container image to use, which ports to expose, and how many Pod replicas to run.

All requests to the API Server are subject to authentication and authorization checks, but, once these are done, the config in the YAML file is validated, persisted to the cluster store, and deployed to the cluster.
The cluster store#

The cluster store is the only stateful part of the control plane, and it persistently stores the entire configuration and state of the cluster. As such, it’s a vital component of the cluster – no cluster store, no cluster.

The cluster store is currently based on etcd, a popular distributed database. As it’s the single source of truth for the cluster, you should run between 3-5 etcd replicas for high availability, and you should provide adequate ways to recover when things go wrong.

  <img width="903" alt="image" src="https://user-images.githubusercontent.com/75510135/167288244-c10d3a00-8f89-42d8-9df9-e0d69c723ad6.png">

  As with all distributed databases, the consistency of writes to the database is vital. For example, multiple writes to the same value originating from different nodes needs to be handled. etcd uses the popular RAFT consensus algorithm to accomplish this.
The controller manager#

The controller manager implements all of the background control loops that monitor the cluster and respond to events.

It’s a controller of controllers, meaning it spawns all of the independent control loops and monitors them.

Some of the control loops include the node controller, the endpoint controller, and the ReplicaSet controller. Each one runs as a background watch loop that is constantly watching the API server for changes – the aim of the game is to ensure the current state of the cluster matches the desired state (more on this shortly).

The logic implemented by each control loop is effectively this:

    Obtain desired state
    Observe current state
    Determine differences
    Reconcile differences

This logic is at the heart of Kubernetes and declarative design patterns. Each control loop is also extremely specialized and only interested in its own little corner of the Kubernetes cluster. No attempt is made to over complicate things by implementing awareness of other parts of the system - each control loop takes care of its own business and leaves everything else alone. This is key to the distributed design of Kubernetes and adheres to the Unix philosophy of building complex systems from small specialized parts.

    Note: Throughout the course we’ll use terms like control loop, watch loop, and reconciliation loop to mean the same thing.

The scheduler#

At a high level, the scheduler watches the API server for new work tasks and assigns them to the appropriate healthy nodes. Behind the scenes, it implements complex logic that filters out nodes incapable of running the task and then ranks the nodes that are capable. The ranking system is complex, but the node with the highest ranking score is selected to run the task.

When identifying nodes that are capable of running a task, the scheduler performs various predicate checks. These include: Is the node tainted? Are there any affinity or anti-affinity rules? Is the required network port available on the node? Does the node have sufficient free resources? Any node incapable of running the task is ignored, and the remaining nodes are ranked according to things such as: Does the node already have the required image? How much free resource does the node have? How many tasks is the node already running? Each criterion is worth points, and the node with the most points is selected to run the task.

If the scheduler cannot find a suitable node, the task cannot be scheduled and is marked as pending. The scheduler isn’t responsible for running tasks, just picking the nodes a task will run on.
The cloud controller manager#

If you’re running your cluster on a supported public cloud platform, such as AWS, Azure, GCP, DO, IBM Cloud, etc., your control plane will be running a cloud controller manager. Its job is to manage integrations with underlying cloud technologies and services, such as instances, load balancers, and storage. For example, if your application asks for an internet facing load balancer, the cloud controller manager is involved in provisioning an appropriate load balancer on your cloud platform.
Control plane summary#

Kubernetes’s masters run all of the cluster’s control plane services. Think of it as the brains of the cluster, where all the control and scheduling decisions are made. Behind the scenes, a master is made up of many small specialized control loops and services. These include the API server, the cluster store, the controller manager, and the scheduler.

The API server is the front end into the control plane, and all instructions and communication must go through it. By default, it exposes a RESTful endpoint on port 443.

  <img width="503" alt="image" src="https://user-images.githubusercontent.com/75510135/167288270-b6a8df4d-fcd5-414e-9fef-2024263dccdb.png">

</details>


<details>
<summary>Kubernetes From 40K Feet</summary>
<br>

  <img width="443" alt="image" src="https://user-images.githubusercontent.com/75510135/167234015-995e2827-6ce9-472e-899c-ea31c27c1e46.png">

  At the highest level, Kubernetes is two things:

    A cluster for running applications.
    An orchestrator of cloud-native microservices apps.

Kubernetes as a cluster#

Kubernetes is like any other cluster – a bunch of nodes and a control plane. The control plane exposes an API and records the state in a persistent store; it also has a scheduler for assigning work to nodes. Nodes are where application services run.

It can be useful to think of the control plane as the brains of the cluster and the nodes as the muscle. In this analogy, the control plane is the brain because it implements all of the important features, such as auto-scaling and zero-downtime rolling updates. The nodes are the muscle because they do the every-day hard work of executing application code.
Kubernetes as an orchestrator#

Orchestrator is just a fancy word for a system that takes care of deploying and managing applications.

Let’s look at a quick analogy.

In the real world, a football (soccer) team is made of individuals. No two individuals are the same, and each has a different role to play in the team – some defend, some attack, some are great at passing, some tackle, and some shoot. Along comes the coach, and he or she gives everyone a position and organizes them into a team with a purpose.
svg viewer
  
  <img width="567" alt="image" src="https://user-images.githubusercontent.com/75510135/167234031-74abef20-39fa-45cf-819a-a426602a257b.png">

  The coach also makes sure the team maintains its formation, sticks to the game plan, and deals with any injuries and other changes in circumstance.

Well, guess what? Microservices apps on Kubernetes are the same. Stick with me on this.

We start out with lots of individually specialized services – some serve web pages, some perform authentication, some perform searches, others persist data. Kubernetes comes along – a bit like the coach in the football analogy – and organizes everything into a useful app and keeps things running smoothly. It even responds to events and other changes.

In the sports world, we call this coaching. In the application world, we call it orchestration. Kubernetes orchestrates cloud-native microservices applications.
  
How it works#

To make this happen, you start out with an app; you package it up and give it to the cluster (Kubernetes). The cluster is made up of one or more masters and a bunch of nodes.

The masters, sometimes called heads or head nodes, are in charge of the cluster. This means they make scheduling decisions, perform monitoring, implement changes, respond to events, and more. For these reasons, we often refer to the masters as the control plane.

The nodes are where application services run, and we sometimes call them the data plane. Each node has a reporting line back to the masters and constantly watches for new work assignments.

  <img width="492" alt="image" src="https://user-images.githubusercontent.com/75510135/167288203-e543830b-b661-4957-9e98-7187ce64ac92.png">

  To run applications on a Kubernetes cluster, we follow this simple pattern:

    Write the application as small independent microservices in our favorite languages.
    Package each microservice in its own container.
    Wrap each container in its own Pod.
    Deploy Pods to the cluster via higher-level controllers, such as, Deployments, DaemonSets, StatefulSets, CronJobs etc.

We’re still near the beginning of the course, and you’re not expected to know what all of this means yet. However, at a high level, Deployments offer scalability and rolling updates; DaemonSets run one instance of a service on every node in the cluster; StatefulSets are for stateful application components, and CronJobs are for short-lived tasks that need to run at set times. There are more than these, but these will do for now.

Kubernetes likes to manage applications declaratively. This is a pattern where you describe how you want your application to look and feel in a set of YAML files. You POST these files to Kubernetes, then sit back while Kubernetes makes it all happen.

But it doesn’t stop there. Because the declarative pattern tells Kubernetes how an application should look, Kubernetes can watch it and make sure things don’t stray from what you asked for. If something isn’t as it should be, Kubernetes tries to fix it.

  
  
</details>
