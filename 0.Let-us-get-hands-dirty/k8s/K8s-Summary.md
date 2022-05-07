<details>
<summary>Major components of a Kubernetes cluster</summary>
<br>

  The masters are where the control plane components run. Under the hood, there are several system services, including the API server that exposes a public REST interface to the cluster. Masters make all of the deployment and scheduling decisions, and the multi-master HA is important for production-grade environments.

Nodes are where user applications run. Each node runs a service, called the kubelet, that registers the node with the cluster and communicates with the API server. It watches the API for new work tasks and maintains a reporting channel. Nodes also have a container runtime and the kube-proxy service. The container runtime, such as Docker or containerd, is responsible for all container-related operations. The kube-proxy is responsible for networking on the node.

We also talked about some of the major Kubernetes API objects, such as Pods, Deployments, and Services. The Pod is the basic building block. Deployments add self-healing, scaling, and updates. Services add stable networking and load balancing.
  
</details>

<details>
<summary>Pods</summary>
<br>

The atomic unit of deployment in the Kubernetes world is the Pod. Each Pod consists of one or more containers and gets deployed to a single node in the cluster. The deployment operation is an all or nothing atomic operation.

Pods are defined and deployed declaratively using a YAML manifest file, and it’s normal to deploy them via higher-level controllers, such as Deployments. You use the kubectl command-line to POST the manifest to the API server; it gets stored in the cluster store and converted into a PodSpec that is scheduled to a healthy cluster node with enough available resources.

The process on the worker node that accepts the PodSpec is the kubelet. This is the main Kubernetes agent running on every node in the cluster. It takes the PodSpec and is responsible for pulling all images and starting all containers in the Pod.

If you deploy a singleton Pod (a Pod that is not deployed via a controller) to your cluster, and the node it is running on fails, the singleton Pod is not rescheduled on another node. Because of this, you should almost always deploy Pods via higher-level controllers, such as Deployments and DaemonSets. These add capabilities, such as self-healing and rollbacks, which are at the heart of what makes Kubernetes so powerful.

</details>

<details>
<summary>Deployments</summary>
<br>

  Deployments are a great way to manage Kubernetes apps. They build on top of Pods by adding self-healing, scalability, rolling updates, and rollbacks. Behind the scenes, they leverage ReplicaSets for the self-healing and scalability parts.

Like Pods, Deployments are objects in the Kubernetes API, and you should work with them declaratively.

When you perform updates with the kubectl apply command, older versions of ReplicaSets get wound down, but they stick around making it easy to perform rollbacks.
  
</details>

<details>
<summary>Service</summary>
<br>

  Services are all about providing stable networking for Pods. They also provide load balancing and ways to be accessed from outside of the cluster.

The front end of a Service provides a stable IP, DNS name, and port that is guaranteed not to change for the entire life of the Service. The back end of a Service uses labels to load -balance traffic across a potentially dynamic set of application Pods.

  As with all Kubernetes objects, the preferred way of deploying and managing Services is the declarative way. Labels allow them to send traffic to a dynamic set of Pods. This means you can deploy new Services that will work with Pods and Deployments that are already running on the cluster and are already in use. Each Service gets its own Endpoints object that maintains an up-to-date list of matching Pods.
  
  Services bring stable and reliable networking to apps deployed on Kubernetes. They also perform load balancing and allow you to expose elements of your application to the outside world (outside of the Kubernetes cluster).

The front end of a Service is fixed, providing stable networking for the Pods behind it. The back end of a Service is dynamic, allowing Pods to come and go without impacting the ability of the Service to provide load balancing.

Services are first-class objects in the Kubernetes API and can be defined in the standard YAML manifest files. They use label selectors to dynamically match Pods, and the best way to work with them is declaratively.
</details>

<details>
<summary>Service Discovery</summary>
<br>

  <img width="822" alt="image" src="https://user-images.githubusercontent.com/75510135/167258003-940b56b7-53fc-4af0-b3f4-3f0b2a0d8d18.png">

  Assume a microservice, called “enterprise,” needs to send traffic to a microservice called “voyager.” To start this flow, the “enterprise” microservice needs to know the name of the Kubernetes Service object sitting in front of the “voyager” microservice. We’ll assume it’s called “voy,” but it is the responsibility of the application developer to ensure this is known.

An instance of the “enterprise” microservice sends a query to the cluster DNS (defined in the /etc/resolv.conf file of every container) asking it to resolve the name of the “voy” Service to an IP address. The cluster DNS replies with the ClusterIP (virtual IP), and the instance of the “enterprise” microservice sends requests to this ClusterIP. However, there are no routes to the service network that the ClusterIP is on. This means the requests are sent to the container’s default gateway and, eventually, sent to the Node the container is running on.

The Node has no route to the service network, so it sends the traffic to its own default gateway. En-route, the request is processed by the Node’s kernel. A trap is triggered, and the request is redirected to the IP address of a Pod that matches the Service’s label selector. The Node has routes to Pod IPs, and the requests reach a Pod and are processed.

Kubernetes uses the internal cluster DNS for service registration and service discovery.

All new Service objects are automatically registered with the cluster DNS and all containers are configured to know where to find the cluster DNS. This means that all containers will talk to the cluster DNS when they need to resolve a name to an IP address.

The cluster DNS resolves Service names to ClusterIPs. These IP addresses are on a special network, called the service network, and there are no routes to this network. Fortunately, every cluster Node is configured to trap on packets destined for the service network and redirect them to Pod IPs on the Pod network.
</details>

<details>
<summary>Storage</summary>
<br>

  You start out with storage assets on an external storage system. You use a CSI plugin to integrate the external storage system with Kubernetes, and you use Persistent Volume (PV) objects to make the external system’s assets accessible and usable. Each PV is an object on the Kubernetes cluster that maps back to a specific storage asset (LUN, share, blob, etc.) on the external storage system. Finally, for a Pod to use a PV, it needs a PersistentVolumeClaim (PVC). This is like a ticket that grants the Pod to the PV. Once the PV and PVC objects are created and bound, the PVC can be referenced in a PodSpec, and the associated PV can be mounted as a volume in a container.
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
