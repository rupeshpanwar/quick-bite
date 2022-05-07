<details>
<summary>Major components of a Kubernetes cluster</summary>
<br>

  The masters are where the control plane components run. Under the hood, there are several system services, including the API server that exposes a public REST interface to the cluster. Masters make all of the deployment and scheduling decisions, and the multi-master HA is important for production-grade environments.

Nodes are where user applications run. Each node runs a service, called the kubelet, that registers the node with the cluster and communicates with the API server. It watches the API for new work tasks and maintains a reporting channel. Nodes also have a container runtime and the kube-proxy service. The container runtime, such as Docker or containerd, is responsible for all container-related operations. The kube-proxy is responsible for networking on the node.

We also talked about some of the major Kubernetes API objects, such as Pods, Deployments, and Services. The Pod is the basic building block. Deployments add self-healing, scaling, and updates. Services add stable networking and load balancing.
  
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
