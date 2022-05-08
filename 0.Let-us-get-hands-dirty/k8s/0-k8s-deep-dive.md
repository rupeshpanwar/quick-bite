
<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>


<details>
<summary>The Declarative Model and the Desired State</summary>
<br>

  The declarative model and the concept of desired state are at the very heart of Kubernetes.

In Kubernetes, the declarative model works like this:

    Declare the desired state of an application (microservice) in a manifest file
    POST it to the API server
    Kubernetes stores it in the cluster store as the application’s desired state
    Kubernetes implements the desired state on the cluster
    Kubernetes implements watch loops to make sure the current state of the application doesn’t vary from the desired state

Let’s look at each step in a bit more detail.

Manifest files are written in simple YAML, and they tell Kubernetes how you want an application to look. This is called the desired state. It includes things such as; which image to use, how many replicas to run, which network ports to listen on, and how to perform updates.

Once you’ve created the manifest, you POST it to the API server. The most common way of doing this is with the kubectl command-line utility. This sends the manifest to the control plane as an HTTP POST, usually on port 443.

Once the request is authenticated and authorized, Kubernetes inspects the manifest, identifies which controller to send it to (e.g., the Deployments controller), and records the config in the cluster store as part of the cluster’s overall desired state. Once this is done, the work gets scheduled on the cluster. This includes the hard work of pulling images, starting containers, building networks, and starting the application’s processes.

Finally, Kubernetes utilizes background reconciliation loops that constantly monitor the state of the cluster. If the current state of the cluster varies from the desired state, Kubernetes will perform whatever tasks are necessary to reconcile the issue.
  <img width="773" alt="image" src="https://user-images.githubusercontent.com/75510135/167289950-03e2f94a-ef72-4483-b262-497d25fe0926.png">

  Declarative model vs. imperative model#

It’s important to understand that what we’ve described is the opposite of the traditional imperative model. The imperative model is where you issue long lists of platform-specific commands to build things.

Not only is the declarative model a lot simpler than long scripts with lots of imperative commands, it also enables self-healing, scaling, and lends itself to version control and self-documentation. It does this by telling the cluster how things should look. If they stop looking like this, the cluster notices the discrepancy and does all of the hard work to reconcile the situation.

But the declarative story doesn’t end there – things go wrong, and things change. When they do, the current state of the cluster no longer matches the desired state. As soon as this happens, Kubernetes kicks into action and attempts to bring the two back into harmony.

Let’s consider an example.
Declarative example#

Assume you have an app with a desired state that includes 10 replicas of a web front-end Pod. If a node that was running two replicas fails, the current state will be reduced to 8 replicas, but the desired state will still be 10. This will be observed by a reconciliation loop, and Kubernetes will schedule two new replicas to bring the total back up to 10.

  <img width="559" alt="image" src="https://user-images.githubusercontent.com/75510135/167289961-64c3af54-e4df-4aac-9cca-33f2b02dac27.png">

  <img width="509" alt="image" src="https://user-images.githubusercontent.com/75510135/167289970-85d4079b-1ede-435f-b959-f5e8eb82d9f0.png">

  <img width="472" alt="image" src="https://user-images.githubusercontent.com/75510135/167289975-d4f09578-cc3c-4195-9a6c-e792e7879f0d.png">

  <img width="535" alt="image" src="https://user-images.githubusercontent.com/75510135/167289983-37e8d87d-102c-40f7-9dd5-a03efef04bab.png">

  The same thing will happen if you intentionally scale the desired number of replicas up or down. You could even change the image you want to use. For example, if the app is currently using v2.00 of an image, and you update the desired state to use v2.01, Kubernetes will notice the difference and go through the process of updating all replicas so that they are using the new version specified in the new desired state.

To be clear, instead of writing a long list of commands to go through the process of updating every replica to the new version, you simply tell Kubernetes you want the new version, and Kubernetes does the hard work for you.

Despite how simple this might seem, it’s extremely powerful and at the very heart of how Kubernetes operates. You give Kubernetes a declarative manifest that describes how you want an application to look. This forms the basis of the application’s desired state. The Kubernetes control plane records it, implements it, and runs background reconciliation loops that constantly check that what is running is what you’ve asked for. When the current state matches the desired state, the world is a happy place. When it doesn’t, Kubernetes gets busy fixing it.

  
</details>

<details>
<summary>Kubernetes Principles</summary>
<br>

  <img width="622" alt="image" src="https://user-images.githubusercontent.com/75510135/167289704-d87963fe-7691-4d20-93c4-f0df27a632d1.png">

  <img width="808" alt="image" src="https://user-images.githubusercontent.com/75510135/167289729-f9239d7f-1a06-4bd7-8dda-8501154d675b.png">

  <img width="598" alt="image" src="https://user-images.githubusercontent.com/75510135/167289737-1e3deca9-a178-4cb5-b5d0-f5f4a03a13fd.png">

  <img width="819" alt="image" src="https://user-images.githubusercontent.com/75510135/167289747-c7aedce2-40ee-497c-97f8-b239ea0a644b.png">

  <img width="515" alt="image" src="https://user-images.githubusercontent.com/75510135/167289767-588f97e6-1d15-4b5a-b7c1-029344c5e22f.png">

  <img width="611" alt="image" src="https://user-images.githubusercontent.com/75510135/167289778-bd76c0c5-e9b4-437b-8f5c-bfc98f37de0d.png">

  <img width="656" alt="image" src="https://user-images.githubusercontent.com/75510135/167289782-7321ca88-dcfa-4839-87cb-d21ac42e582d.png">

  <img width="659" alt="image" src="https://user-images.githubusercontent.com/75510135/167289791-86ec8f5d-d538-4527-9210-a5d2e3d769ca.png">

  
</details>

<details>
<summary>Packaging Apps for Kubernetes</summary>
<br>

  For an application to run on a Kubernetes cluster, it needs to tick a few boxes. These include:

    Being packaged as a container
    Being wrapped in a Pod
    Being deployed via a declarative manifest file

It goes like this: you write an application service in a language of your choice. You build it into a container image and store it in a registry. At this point, the application service is containerized.

Next, you define a Kubernetes Pod to run the containerized application. At the kind of high level we’re at, a Pod is just a wrapper that allows a container to run on a Kubernetes cluster. Once you’ve defined the Pod, you’re ready to deploy it on the cluster.
Deployments#

It is possible to run a stand-alone Pod on a Kubernetes cluster, but the preferred model is to deploy all Pods via higher-level controllers. The most common controller is the Deployment. It offers scalability, self-healing, and rolling updates. You define Deployments in YAML manifest files that specify things like which image to use and how many replicas to deploy.

  <img width="874" alt="image" src="https://user-images.githubusercontent.com/75510135/167289660-e0692d48-f991-4185-bed3-c38400ec74f4.png">

  
</details>

<details>
<summary>Kubernetes DNS</summary>
<br>

  As well as the various control plane and node components, every Kubernetes cluster has an internal DNS service that is vital to operations.

The cluster’s DNS service has a static IP address that is hard-coded into every Pod on the cluster, meaning all containers and Pods know how to find it. Every new service is automatically registered with the cluster’s DNS so that all components in the cluster can find every Service by name. Some other components that are registered with the cluster DNS are StatefulSets and the individual Pods that a StatefulSet manages.

  <img width="405" alt="image" src="https://user-images.githubusercontent.com/75510135/167289585-a80f6808-333f-4dca-aaf4-f3e0ac573af6.png">

  Cluster DNS is based on CoreDNS. Now that we understand the fundamentals of masters and nodes, let’s switch gears in the upcoming lessons and look at how we package applications to run on Kubernetes.
  
</details>


<details>
<summary>Masters and Nodes: Nodes</summary>
<br>

  <img width="461" alt="image" src="https://user-images.githubusercontent.com/75510135/167289399-bff20435-0468-4c8e-9e5d-09b956061020.png">

  Nodes#

Nodes are the workers of a Kubernetes cluster. At a high level, they do three things:

    Watch the API Server for new work assignments.
    Execute new work assignments.
    Report back to the control plane (via the API server).

As we can see from the figure below, they’re a bit simpler than masters.

  <img width="506" alt="image" src="https://user-images.githubusercontent.com/75510135/167289507-2d5479e2-7d20-45ce-a6b7-5d2ced62c1bf.png">

  Let’s look at the three major components of a node.
Kubelet#

The kubelet is the star of the show on every node. It’s the main Kubernetes agent, and it runs on every node in the cluster. In fact, it’s common to use the terms node and kubelet interchangeably.

When you join a new node to a cluster, the process installs the kubelet onto the node. The kubelet is then responsible for registering the node with the cluster. Registration effectively pools the node’s CPU, memory, and storage into the wider cluster pool.

One of the main jobs of the kubelet is to watch the API server for new work assignments. Any time it sees one, it executes the task and maintains a reporting channel back to the control plane.

If a kubelet can’t run a particular task, it reports back to the master and lets the control plane decide what actions to take. For example, if a kubelet cannot execute a task, it is not responsible for finding another node to run it on. It simply reports back to the control plane, and the control plane decides what to do.
Container runtime#

The kubelet needs a container runtime to perform container-related tasks – things like pulling images and starting and stopping containers.

In the early days, Kubernetes had native support for a few container runtimes, such as Docker. More recently, it has moved to a plugin model called the Container Runtime Interface (CRI). At a high level, the CRI masks the internal machinery of Kubernetes and exposes a clean documented interface for third-party container runtimes to plug into.

There are many container runtimes available for Kubernetes. One popular example is cri-containerd. This is a community-based, open-source project, porting the CNCF containerd runtime to the CRI interface. It has a lot of support and is replacing Docker as the most popular container runtime used in Kubernetes.

    Note: containerd (pronounced “container-dee”) is the container supervisor and runtime logic stripped out from the Docker Engine. It was donated to the CNCF by Docker, Inc. and has a lot of community support. Other CRI-compliant container runtimes exist as well.

Kube-proxy #

The last piece of the node puzzle is the kube-proxy. This runs on every node in the cluster and is responsible for local cluster networking. For example, it makes sure each node gets its own unique IP address and implements local IPTABLES or IPVS rules to handle routing and load-balancing of traffic on the Pod network.

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
