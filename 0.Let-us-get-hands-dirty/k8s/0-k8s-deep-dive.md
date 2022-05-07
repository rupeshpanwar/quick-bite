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
svg viewer
  
  
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
