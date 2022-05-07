<details>
<summary>Introduction</summary>
<br>

  In the previous chapters, we’ve looked at some Kubernetes objects that are used to deploy and run applications. We looked at Pods as the most fundamental unit for deploying microservices applications; then we looked at Deployment controllers that add things like scaling, self-healing, and rolling updates. However, despite all of the benefits of Deployments, we still cannot rely on individual Pod IPs! This is where Kubernetes Service objects come into play – they provide stable and reliable networking for a set of dynamic Pods.
Setting the scene#

Before diving in, we need to remind ourselves that Pod IPs are unreliable. When Pods fail, they get replaced with new Pods that have new IPs. Scaling up a Deployment introduces new Pods with new IP addresses. Scaling down a Deployment removes Pods. This creates a large amount of IP churn and makes the Pod IPs unreliable.

You also need to know 3 fundamental things about Kubernetes Services.

First, let’s clear up some terminology. When talking about Service with a capital “S”, we’re talking about the Service object in Kubernetes that provides stable networking for Pods. Just like a Pod, ReplicaSet, or Deployment, a Kubernetes Service is a REST object in the API that you define in a manifest and POST to the API server.

Second, you need to know that every Service gets its own stable IP address, its own stable DNS name, and its own stable port.

Third, you need to know that Services leverage labels to dynamically select the Pods in the cluster they will send traffic to.
Theory#

The figure below shows a simple Pod-based application deployed via a Kubernetes Deployment. It shows a client (which could be another component of the app) that does not have a reliable network endpoint for accessing the Pods. Remember: it’s a bad idea to talk directly to an individual Pod because that Pod could disappear at any point via scaling operations, updates and rollbacks, and failures.
svg viewer
  
  <img width="630" alt="image" src="https://user-images.githubusercontent.com/75510135/167245265-16fbb2a0-f2cc-42b1-bde4-888ff5e91c9f.png">

  The next figure shows the same application with a Service added into the mix. The Service is associated with the Pods and fronts them with a stable IP, DNS, and port. It also load balances requests across the Pods.
svg viewer
  <img width="640" alt="image" src="https://user-images.githubusercontent.com/75510135/167245280-061c0559-54fb-4b7a-a20b-2cbd874c3947.png">

  With a Service in front of a set of Pods, the Pods can scale up or down, they can fail, and they can be updated, rolled back, etc.; while events like these occur, the Service in front of them observes the changes and updates its list of healthy Pods. But it never changes the stable IP, DNS, or port that it exposes.

Think of Services as having a static front end and a dynamic back end. The front end, consisting of the IP, DNS name, and port, never changes. The back end, consisting of the Pods, can be constantly changing.

  
</details>

<details>
<summary>Labels and Loose Coupling</summary>
<br>

  Services are loosely coupled with Pods via labels and label selectors. This is the same technology that loosely couples Deployments to Pods and is key to the flexibility provided by Kubernetes. The figure below shows an example where 3 Pods are labelled as zone=prod and version=1, and the Service has a label selector that matches.
  <img width="643" alt="image" src="https://user-images.githubusercontent.com/75510135/167245531-5c2e09af-5c66-4404-a7f7-57e1457df7ee.png">

  <img width="491" alt="image" src="https://user-images.githubusercontent.com/75510135/167245535-a4d03803-4638-40d4-87e5-25baa0ad80f5.png">

  <img width="500" alt="image" src="https://user-images.githubusercontent.com/75510135/167245543-bcc6c32c-e18a-4e8a-a6e7-f0ecb6da3dcd.png">

  

    The first one is an example where the Service is providing stable networking to all three Pods – you can send requests to the Service, and it will forward them on to the Pods. It also provides simple load balancing.

    For a Service to match a set of Pods and send traffic to them, the Pods must possess every label in the Services’s label selector. However, the Pod can have additional labels that are not listed in the Service’s label selector. If that’s confusing, the examples in the figures below should help.

    The second one is an example where the Service does not match any of the Pods. This is because the Service is looking for Pods that have two labels, but the Pods only possess one of them. The logic behind this is a Boolean AND.

    The third one shows an example that does work. It works because the Service is looking for two labels, and the Pods in the diagram possess both. It doesn’t matter that the Pods possess additional labels that the Service isn’t looking for. The Service is looking for Pods with two labels, it finds them, and it ignores the fact that the Pods have additional labels – all that is important is that the Pods possess the labels the Service is looking for.

The following excerpts, from a Service YAML and Deployment YAML, show how selectors and labels are implemented. I’ve added comments to the lines of interest.
  <img width="619" alt="image" src="https://user-images.githubusercontent.com/75510135/167245556-537be489-ee69-4340-8e88-13e21b8429ea.png">

  <img width="567" alt="image" src="https://user-images.githubusercontent.com/75510135/167245569-ffcb6fe2-5409-424b-b724-78d293621d6f.png">

  In the example files, the Service has a label selector (.spec.selector) with a single value, app=hello-world. This is the label that the Service is looking for when it queries the cluster for matching Pods. The Deployment specifies a Pod template with the same app=hello-world label (.spec.template.metadata.labels). This means that any Pods it deploys will have the app=hello-world label. It is these two attributes that loosely couple the Service to the Deployment’s Pods.

When the Deployment and the Service are deployed, the Service will select all 10 Pod replicas and provide them with a stable networking endpoint and load balance traffic to them.

  <img width="602" alt="image" src="https://user-images.githubusercontent.com/75510135/167245690-6a4f2a8d-4324-410b-8c06-1daa15276256.png">

  
</details>

<details>
<summary>Services and Endpoints Objects</summary>
<br>
As Pods come and go (scaling up or down, failures, rolling updates, etc.), the Service dynamically updates its list of healthy matching Pods. It does this through a combination of the label selector and a construct called an Endpoints object.

Each Service that is created automatically gets an associated Endpoints object. All this Endpoints object is, is a dynamic list of all of the healthy Pods on the cluster that match the Service’s label selector.

It works like this:

Kubernetes is constantly evaluating the Service’s label selector against the current list of healthy Pods on the cluster. Any new Pods that match the selector get added to the Endpoints object, and any Pods that disappear get removed. This means the Endpoints object is always up to date. Then, when a Service is sending traffic to Pods, it queries its Endpoints object for the latest list of healthy matching Pods.

When sending traffic to Pods, via a Service, an application will normally query the cluster’s internal DNS for the IP address of a Service. It then sends the traffic to this stable IP address and the Service sends it on to a Pod. However, a Kubernetes-native application (that’s a fancy way of saying an application that understands Kubernetes and can query the Kubernetes API) can query the Endpoints API directly, bypassing the DNS lookup and use of the Service’s IP.

  
</details>

<details>
<summary>Accessing Services From Inside the Cluster</summary>
<br>

  <img width="360" alt="image" src="https://user-images.githubusercontent.com/75510135/167245855-fef20dc6-a32f-4c3a-849e-b8968cc14b2f.png">

  Introduction#

Kubernetes supports several types of Services. The default type is ClusterIP.

A ClusterIP Service has a stable IP address and port that is only accessible from inside the cluster. It’s programmed into the network fabric and guaranteed to be stable for the life of the Service. Programmed into the network fabric is a fancy way of saying the network just knows about it, and you don’t need to bother with the details (stuff like low-level IPTABLES and IPVS rules).

Anyway, the ClusterIP gets registered against the name of the Service on the cluster’s internal DNS service. All Pods in the cluster are pre programmed to know about the cluster’s DNS service, meaning all Pods are able to resolve Service names.
Example of ClusterIP#

Let’s look at a simple example.

Creating a new Service called “magic-sandbox” will trigger the following. 
      Kubernetes will register the name “magic-sandbox”, along with the ClusterIP and port=> with the cluster’s DNS service. 
      The name, ClusterIP, and port are guaranteed to be long-lived and stable, 
      and all Pods in the cluster send service discovery requests to the internal DNS and will, 
  
  therefore, be able to resolve “magic-sandbox” to the ClusterIP. IPTABLES or IPVS rules are distributed across the cluster that ensure traffic sent to the ClusterIP gets routed to Pods on the backend.

Net result: as long as a Pod (application microservice) knows the name of a Service, it can resolve that to its ClusterIP address and connect to the desired Pods.

This only works for Pods and other objects on the cluster, as it requires access to the cluster’s DNS service. It does not work outside of the cluster.

</details>

<details>
<summary>Accessing Services From Outside the Cluster</summary>
<br>

  <img width="393" alt="image" src="https://user-images.githubusercontent.com/75510135/167246143-79be3b32-485f-4247-8d51-b6ecde4bc43d.png">

  Introduction#

Kubernetes has another type of Service called a NodePort Service. This builds on the top of ClusterIP and enables access from outside of the cluster.

You already know that the default Service type is ClusterIP, and it registers a DNS name, virtual IP, and port with the cluster’s DNS. A different type of Service, called a NodePort, Service builds on this by adding another port that can be used to reach the Service from outside the cluster. This additional port is called the NodePort.

The following example represents a NodePort Service:

    name: magic-sandbox
    clusterIP: 172.12.5.17
    port: 8080
    nodePort: 30050

This magic-sandbox Service can be accessed from inside the cluster via magic-sandbox on port 8080, or 172.12.5.17 on port 8080. It can also be accessed from outside of the cluster by sending a request to the IP address of any cluster node on port 30050.

At the bottom of the stack are cluster nodes that host Pods. You add a Service and use labels to associate it with Pods. The Service object has a reliable NodePort mapped to every node in the cluster –- the NodePort value is the same on every node. This means that traffic from outside of the cluster can hit any node in the cluster on the NodePort and get through to the application (Pods).
Example of a NodePort Service#

The figure below shows a NodePort Service where 3 Pods are exposed externally on port 30050 on every node in the cluster.

    In step 1, an external client hits Node2 on port 30050.
    In step 2 it is red

    irected to the Service object (this happens even though Node2 isn’t running a Pod from the Service).
    Step 3 shows that the Service has an associated Endpoint object with an always-up-to-date list of Pods matching the label selector.
    Step 4 shows the client being directed to pod1 on Node1.

<img width="719" alt="image" src="https://user-images.githubusercontent.com/75510135/167246432-6bfd41b5-d601-41e3-b90b-c9d0f4699eb8.png">

  The Service could just as easily have directed the client to pod2 or pod3. In fact, future requests may go to other Pods as the Service performs basic load balancing.
Other types of Services#

There are other types of Services, such as LoadBalancer and ExternalName.

LoadBalancer Services integrate with load balancers from your cloud provider, such as AWS, Azure, DO, IBM Cloud, and GCP. They build on top of NodePort Services (which in turn build on top of ClusterIP Services) and allow clients on the internet to reach your Pods via one of your cloud’s load balancers. They’re extremely easy to set up. However, they only work if you’re running your Kubernetes cluster on a supported cloud platform, e.g., you cannot leverage an ELB load balancer on AWS if your Kubernetes cluster is running on Microsoft Azure. ExternalName Services route traffic to systems outside of your Kubernetes cluster (all other Service types route traffic to Pods in your cluster).

ExternalName Services route traffic to systems outside of your Kubernetes cluster (all other Service types route traffic to Pods in your cluster).

  
</details>

<details>
<summary>Service Discovery</summary>
<br>

  <img width="504" alt="image" src="https://user-images.githubusercontent.com/75510135/167246459-6baf4829-2529-447b-afa0-e6dfcc2ec0c3.png">

  Kubernetes implements Service discovery in a couple of ways:

    DNS (preferred)
    Environment variables (definitely not preferred)

Method I: DNS#

DNS-based Service discovery requires the DNS cluster-add-on – this is just a fancy name for the native Kubernetes DNS service. I can’t remember ever seeing a cluster without it, and if you followed the installation methods from the “Installing Kubernetes” chapter, you’ll already have this. Behind the scenes, it implements:

    Control plane Pods running a DNS service
    A Service object, called kube-dns that sits in front of the Pods
    Kubelets program every container with the knowledge of the DNS (via /etc/resolv.conf)

The DNS add-on constantly watches the API server for new Services and automatically registers them in the DNS. This means every Service gets a DNS name that is resolvable across the entire cluster.
Method II: environment variables#

The alternative form of service discovery is through environment variables. Every Pod gets a set of environment variables that resolve every Service currently on the cluster. However, this is an extremely limited fallback in case you’re not using DNS in your cluster.

A major problem with environment variables is that they’re only inserted into Pods when the Pod is initially created. This means that Pods have no way of learning about new Services added to the cluster after the Pod itself is created. This is far from ideal and a major reason why DNS is the preferred method. Another limitation can be in clusters with a lot of Services.

</details>

<details>
<summary>The Imperative Way</summary>
<br>

  Warning! The imperative way is not the Kubernetes way. It introduces the risk that you make imperative changes and never update your declarative manifests, rendering the manifests incorrect and out-of-date. This introduces the risk that stale manifests are subsequently used to update the cluster at a later date, unintentionally overwriting important changes that were made imperatively.

Use kubectl to declaratively deploy the following Deployment (later steps will be done imperatively).

The YAML file is called deploy.yml.

  <img width="389" alt="image" src="https://user-images.githubusercontent.com/75510135/167247121-8f6ae86d-0f21-499a-8f81-8283cfe8d01e.png">

  <img width="731" alt="image" src="https://user-images.githubusercontent.com/75510135/167247132-ee95956f-df8a-4abf-8843-b212f21e078a.png">

  Imperatively create a Kubernetes Service#

The command to imperatively create a Kubernetes Service is kubectl expose. Run the following command to create a new Service that will provide networking and load balancing for the Pods deployed in the previous step.
  
  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/167247151-2e09cc69-5204-457f-954d-53f7c9b6e7d5.png">

  <img width="847" alt="image" src="https://user-images.githubusercontent.com/75510135/167247162-9bed2d97-e8e3-4ce3-b343-8c006e9ac10f.png">

  <img width="912" alt="image" src="https://user-images.githubusercontent.com/75510135/167247180-47f4c5cb-fdd0-4ec7-a44c-a50cf7372354.png">

  <img width="896" alt="image" src="https://user-images.githubusercontent.com/75510135/167247187-b90b99b6-dec1-4b54-b8ff-694ec7d10ce4.png">

  
</details>

<details>
<summary>The Declarative Way</summary>
<br>

  <img width="384" alt="image" src="https://user-images.githubusercontent.com/75510135/167247463-825690bb-32d8-446a-9405-ffa828b319ce.png">

  Time to do things the proper way: the Kubernetes way.
Looking into the Service YAML#

You’ll use the following Service manifest file to deploy the same Service that you deployed in the previous section. However, this time, you’ll specify a value for the cluster-wide port.

  <img width="896" alt="image" src="https://user-images.githubusercontent.com/75510135/167247613-16d51d3d-575d-4e85-98dd-741040b360e7.png">

  Finally, .spec.selector tells the Service to send traffic to all Pods in the cluster that have the app=hello-world label. This means it will provide stable networking and load balancing across all Pods with that label.

Before deploying and testing the Service, let’s remind ourselves of the major Service types.
Common Service types#

The three common ServiceTypes are:

    ClusterIP. This is the default option and gives the Service a stable IP address internally within the cluster. It will not make the Service available outside of the cluster.
    NodePort. This builds on top of the ClusterIP and adds a cluster-wide TCP or UDP port. It makes the Service available outside of the cluster on a stable port.
    LoadBalancer. This builds on top of the NodePort and integrates with cloud-based load-balancers.

There’s another Service type called ExternalName. This is used to direct traffic to services that exist outside of the Kubernetes cluster.
Creating the Service#

The manifest needs POSTing to the API server. The simplest way to do this is with kubectl apply.

The YAML file is called svc.yml.

  <img width="892" alt="image" src="https://user-images.githubusercontent.com/75510135/167247629-c571f8fb-6d73-42da-ab57-c26ab04dc52e.png">

  
</details>

<details>
<summary>Introspecting Services and Endpoint Objects</summary>
<br>

  <img width="437" alt="image" src="https://user-images.githubusercontent.com/75510135/167247677-8f13965d-1ed5-4dad-9827-42a22a28944e.png">

  Introspecting Services #

Now that the Service is deployed, you can inspect it with the usual kubectl get and kubectl describe commands.

  <img width="734" alt="image" src="https://user-images.githubusercontent.com/75510135/167247803-61fd69d0-869d-425c-9171-b2403853871d.png">

  In the previous example, you exposed the Service as a NodePort on port 30001 across the entire cluster. This means you can point a web browser to that port on any node and reach the Service and the Pods it’s proxying. You will need to use the IP address of a node you can reach, and you will need to make sure that any firewall and security rules allow the traffic to flow.

The figure below shows a web browser accessing the app via a cluster node with an IP address of 54.246.255.52 on the cluster-wide port 30001.
  <img width="668" alt="image" src="https://user-images.githubusercontent.com/75510135/167247815-aaed101b-7749-4721-b5b5-57bb0ab86dd2.png">

</details>

<details>
<summary>Endpoints objects</summary>
<br>

  Earlier in the chapter, we said that every Service gets its own Endpoints object with the same name as the Service. This object holds a list of all the Pods the Service matches and is dynamically updated as matching Pods come and go. You can see Endpoints with the normal kubectl commands.

In the following command, you use the Endpoint controller’s ep shortname.
  <img width="664" alt="image" src="https://user-images.githubusercontent.com/75510135/167247838-58fe58dc-36b3-41ac-87ff-959e0daab278.png">

  
</details>
