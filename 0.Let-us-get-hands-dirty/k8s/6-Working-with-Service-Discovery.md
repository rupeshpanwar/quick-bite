<details>
<summary>Introduction</summary>
<br>

<img width="527" alt="image" src="https://user-images.githubusercontent.com/75510135/167252669-34557003-95a9-4915-b429-b9bcc72a3865.png">

Quick background#

Applications run inside of containers, and containers run inside of Pods. Every Kubernetes Pod gets its own unique IP address, and all Pods connect to the same flat network, called the Pod network. However, Pods are ephemeral. This means they come and go and should not be considered reliable. For example, scaling operations, rolling updates, rollbacks, and failures all cause Pods to be added or removed from the network.

To address the unreliable nature of Pods, Kubernetes provides a Service object that sits in front of a set of Pods and provides a reliable name, IP address, and port. Clients connect to the Service object, which, in turn, load balances requests to the target Pods.

    Note: The word “service” has lots of meanings. When we use it with a capital “S” we are referring to the Kubernetes Service object that provides stable networking to a set of Pods.

Modern cloud-native applications are composed of many small independent microservices that work together to create a useful application. For these microservices to work together, they need to be able to discover and connect to each other. This is where service discovery comes into play.

There are two major components to service discovery:

    Service registration
    Service discovery


</details>

<details>
<summary>Service Registration</summary>
<br>

  <img width="549" alt="image" src="https://user-images.githubusercontent.com/75510135/167253091-fe526ab9-bdd4-4aef-8d2f-02ddc0ae17c7.png">

  What is service registration?#

Service registration is the process of a microservice registering its connection details in a service registry so that other microservices can discover it and connect to it.

  <img width="627" alt="image" src="https://user-images.githubusercontent.com/75510135/167254282-e520cfca-5687-4abb-9c96-b5b0a14e6935.png">

  A few important things to note about this in Kubernetes:

    Kubernetes uses an internal DNS service as its service registry.
    Services, not individual Pods, register with DNS.
    The name, IP address, and network port of every Service is registered

For this to work, Kubernetes provides a well known internal DNS service that we usually call the “cluster DNS”. The term well known means that it operates at an address known to every Pod and container in the cluster. It’s implemented in the kube-system Namespace as a set of Pods managed by a Deployment called coredns. These Pods are fronted by a Service called kube-dns. Behind the scenes, it’s based on a DNS technology, called CoreDNS, and runs as a Kubernetes-native application.

The previous sentence contains a lot of detail, so the following commands show how its implemented. You can run these commands on your own Kubernetes clusters.

  <img width="749" alt="image" src="https://user-images.githubusercontent.com/75510135/167254303-2a92e23c-ca14-4b70-8404-179317c4be58.png">

  
</details>

<details>
<summary>Registration with cluster DNS</summary>
<br>

  Every Kubernetes Service is automatically registered with the cluster DNS when it’s created. The registration process looks like this (exact flow might slightly differ):

    You POST a new Service manifest to the API server.
    The request is authenticated, authorized, and subjected to admission policies.
    The Service is allocated a virtual IP address, called a ClusterIP.
    An Endpoints object (or Endpoint slices) is created to hold a list of Pods the Service will load balance traffic to.
    The Pod network is configured to handle traffic sent to the ClusterIP (more on this later).
    The Service’s name and IP are registered with the cluster DNS.

Step 6 is the secret sauce in the service registration process.

We mentioned earlier that the cluster DNS is a Kubernetes-native application. This means it knows it’s running on Kubernetes and implements a controller that watches the API server for new Service objects. Any time it observes a new Service object, it creates the DNS records that allow the Service name to be resolved to its ClusterIP. This means that applications and Services do not need to perform service registration – the cluster DNS is constantly looking for new Services and automatically registers their details.

It’s important to understand that the name registered for the Service is the value stored in its metadata.name property. The ClusterIP is dynamically assigned by Kubernetes.
<img width="530" alt="image" src="https://user-images.githubusercontent.com/75510135/167254344-266c317b-f896-4541-b00c-2d0c3017972a.png">
At this point, the front-end configuration of the Service is registered (name, IP, port), and the Service can be discovered by applications running in other Pods.
</details>

<details>
<summary>The Service back end</summary>
<br>

  Now that the front end of the Service is registered, the back end needs building. This involves creating and maintaining a list of Pod IPs that the Service will load-balance traffic to.

As explained in the previous chapter, every Service has a label selector that determines which Pods the Service will load balance traffic to. See below:
  <img width="586" alt="image" src="https://user-images.githubusercontent.com/75510135/167254371-e5ca5ea3-a4e7-46f1-8eac-625660e66234.png">

  Kubernetes automatically creates an Endpoints object (or Endpoint slices) for every Service. These hold the list of Pods that match the label selector and will receive traffic from the Service. They’re also critical to how traffic is routed from the Service’s ClusterIP to Pod IPs (more on this soon).

The following command shows an Endpoints object for a Service called ent. It has the IP address and port of two Pods that match the label selector.

  <img width="919" alt="image" src="https://user-images.githubusercontent.com/75510135/167254379-3f86b3ce-54c9-4036-b2b3-79fd7a78ca73.png">
The kubelet process on every node is watching the API server for new Endpoints objects. When it sees them, it creates local networking rules that redirect ClusterIP traffic to Pod IPs. In the modern Linux-based Kubernetes cluster the technology used to create these rules is the Linux IP Virtual Server (IPVS). Older versions of Kubernetes used iptables.
  
</details>

<details>
<summary>Summarizing Service registration</summary>
<br>

  At this point, the Service is fully registered and ready to be discovered:

    Its front end configuration is registered with DNS.
    Its back-end configuration is stored in an Endpoints object (or Endpoint slices), and the network is ready to handle traffic.

Let’s summarize the service registration process with the help of a simple flow diagram.
  <img width="905" alt="image" src="https://user-images.githubusercontent.com/75510135/167254404-2fca4563-f985-4f04-afef-7f62ee7da6c1.png">
You POST a new Service configuration to the API server, and the request is authenticated and authorized. The Service is allocated a ClusterIP, and its configuration is persisted to the cluster store. An associated Endpoint object is created to hold the list of Pod IPs that match the label selector. The cluster DNS is running as a Kubernetes-native application and watching the API server for new Service objects. It sees the new Service and registers the appropriate DNS and SRV records. Every node is running a kube-proxy that sees the new Service and Endpoints objects and creates IPVS rules on every node so that traffic to the Service’s ClusterIP is redirected to one of the Pods that match its label selector.
  
</details>

<details>
<summary>Service Discovery</summary>
<br>

  <img width="618" alt="image" src="https://user-images.githubusercontent.com/75510135/167254565-f901c8fd-ba66-49f0-bc8a-19251f9d3a53.png">

  Let’s assume there are two microservices applications on a single Kubernetes cluster – enterprise and voyager. The Pods for the enterprise app sit behind a Kubernetes Service, called ent, and the Pods for the voyager app sit behind another Kubernetes Service, called voy.

Both are registered with DNS as follows:

    ent: 192.168.201.240
    voy: 192.168.200.217


  <img width="719" alt="image" src="https://user-images.githubusercontent.com/75510135/167257883-c4c56c45-9df0-4847-b6a3-adf94d13ae33.png">

  For service discovery to work, every microservice needs to know two things:

    The name of the remote microservice they want to connect to.
    How to convert the name to an IP address.

The application developer is responsible for point 1 – coding the microservice with the names of microservices they connect to. Kubernetes takes care of point 2.
  
</details>

<details>
<summary>Converting names to IP addresses using the cluster DNS</summary>
<br>

  Kubernetes automatically configures every container so that it can find and use the cluster DNS to convert Service names to IPs. It does this by populating every container’s /etc/resolv.conf file with the IP address of a cluster DNS Service as well as any search domains that should be appended to unqualified names.

    Note: An “unqualified name” is a short name, such as ent. Appending a search domain converts an unqualified name into a fully qualified domain name (FQDN), such as ent.default.svc.cluster.local.

The following snippet shows a container that is configured to send DNS queries to the cluster DNS at 192.168.200.10. It also lists the search domains to append to unqualified names.
  
  $ cat /etc/resolv.conf 
search svc.cluster.local cluster.local default.svc.cluster.local
nameserver 192.168.200.10
options ndots:5
  
  <img width="936" alt="image" src="https://user-images.githubusercontent.com/75510135/167257920-f1183910-3772-459d-b6c3-2422d8117e9a.png">

  
</details>

<details>
<summary>Some network magic</summary>
<br>

  Once a Pod has the ClusterIP of a Service, it sends traffic to that IP address. However, the address is on a special network, called the service network, and there are no routes to it! This means the apps container doesn’t know where to send the traffic, so it sends it to its default gateway.

    Note: A default gateway is where a device sends traffic that it doesn’t have a specific route for. The default gateway will normally forward traffic to another device, with a larger routing table, that might have a route for the traffic. A simple analogy might be driving from City A to City B. The local roads in City A probably don’t have signposts to City B, so you follow signs to the major highway/motorway. Once on the highway/motorway, there is more of a chance that you will find directions to City B. If the first signpost doesn’t have directions to City B, you keep driving until you see a signpost for City B. Routing is similar, if a device doesn’t have a route for the destination network, the traffic is routed from one default gateway to the next until, hopefully, a device has a route to the required network.

The container’s default gateway sends the traffic to the Node it is running on.

The Node doesn’t have a route to the service network either, so it sends the traffic to its own default gateway. Doing this causes the traffic to be processed by the Node’s kernel, which is where the magic happens!

Every Kubernetes Node runs a system service called kube-proxy. At a high level, kube-proxy is responsible for capturing traffic destined for ClusterIPs and redirecting it to the IP addresses of Pods that match the Service’s label selector. Let’s look a bit closer:

kube-proxy is a Pod-based Kubernetes-native app that implements a controller that watches the API server for new Service and Endpoints objects. When it sees them, it creates local IPVS rules that tell the Node to intercept traffic destined for the Service’s ClusterIP and forward it to individual Pod IPs.

This means that every time a Node’s kernel processes traffic headed for an address on the service network, a trap occurs, and the traffic is redirected to the IP of a healthy Pod matching the Service’s label selector

    Kubernetes originally used iptables to do this trapping and load-balancing. However, it was replaced by IPVS in Kubernetes 1.11. This is because IPVS is a high-performance kernel-based L4 load balancer that scales better than iptables and implements better load balancing algorithms.


</details>

<details>
<summary>Summarizing service discovery</summary>
<br>

  <img width="899" alt="image" src="https://user-images.githubusercontent.com/75510135/167257965-6a9fe721-f533-4ec8-8cea-583e1b6df3d3.png">

  Assume a microservice, called “enterprise,” needs to send traffic to a microservice called “voyager.” To start this flow, the “enterprise” microservice needs to know the name of the Kubernetes Service object sitting in front of the “voyager” microservice. We’ll assume it’s called “voy,” but it is the responsibility of the application developer to ensure this is known.

An instance of the “enterprise” microservice sends a query to the cluster DNS (defined in the /etc/resolv.conf file of every container) asking it to resolve the name of the “voy” Service to an IP address. The cluster DNS replies with the ClusterIP (virtual IP), and the instance of the “enterprise” microservice sends requests to this ClusterIP. However, there are no routes to the service network that the ClusterIP is on. This means the requests are sent to the container’s default gateway and, eventually, sent to the Node the container is running on.

The Node has no route to the service network, so it sends the traffic to its own default gateway. En-route, the request is processed by the Node’s kernel. A trap is triggered, and the request is redirected to the IP address of a Pod that matches the Service’s label selector. The Node has routes to Pod IPs, and the requests reach a Pod and are processed.

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
