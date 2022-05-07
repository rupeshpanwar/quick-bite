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
