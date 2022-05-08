




API server: Exposes the features of Kubernetes over an HTTPS REST interface. All communication with Kubernetes goes through the API server – even cluster components communicate via the API server.

Container: Lightweight environment for running modern apps. Each container is a virtual operating system with its own process tree, filesystem, shared memory, and more. One container runs one application process.

Cloud native: This is a loaded term and means different things to different people. I personally consider an application to be cloud-native if it can self-heal, scale on-demand, perform rolling updates, and possibly perform rollbacks. They’re usually microservices apps.

ConfigMap: Kubernetes object used to hold non-sensitive configuration data. A great way to add custom configuration data to a generic application template without editing the template.

Container Network Interface (CNI): Pluggable interface enabling different network topologies and architectures. Third parties provide various CNI plugins that enable overlay networks, BGP networks, and various implementations of each.

Container runtime: Low-level software running on every cluster Node responsible for pulling container images, starting containers, stopping containers, and other low-level container operations. Typically Docker or containerd.

Container Runtime Interface (CRI): Interface that allows container runtimes to be pluggable. With the CRI you can choose the best container runtime for your requirements (Docker, containerd, cri-o, kata, etc.).

Container Storage Interface (CSI): Interface enabling external third party storage systems to integrate with Kubernetes. Storage vendors write a CSI driver/plugin that runs as a set of Pods on a cluster and exposes the storage system’s enhanced features to the cluster and applications.

Controller: Control plane process running as a reconciliation loop monitoring the cluster (via the API server) and making the necessary changes so the observed state of the cluster matches the desired state.

Cluster store: Holds the cluster state, including the desired state and the observed state. Typically based on the etcd distributed data store and runs on the Masters. Can be deployed separately to its own cluster for higher performance and higher availability.

Deployment: Controller that deploys and manages a set of stateless Pods. Performs rolling updates and versioned rollbacks. Uses a ReplicaSet controller to perform scaling and self-healing operations.

Desired state: What the cluster and apps should be like. For example, the desired state of an application microservice might be 5 replicas of xyz container listening on port 8080/tcp.

Endpoints object: Up-to-date list of healthy Pods that match a Service’s label selector. Basically, it’s the list of Pods that a Service will send traffic to. It might eventually be replaced by EndpointSlices.

K8s: Because writing Kubernetes is too hard ;-) The 8 replaces the eight characters in Kubernetes between the “K” and the “s”. Pronounced “Kates”. The reason why people say Kubernetes’ girlfriend is called Kate ¯\_(ツ)_/¯.

kubectl: Kubernetes command-line tool. Sends commands to the API Server and queries state via the API server.

Kubelet: The main Kubernetes agent running on every cluster Node. It watches the API server for new work assignments and maintains a reporting channel back.

Kube proxy: Runs on every cluster node and implements low-level rules that handle routing of traffic from Services to Pods. You send traffic to stable Service names, and kube-proxy makes sure the traffic reaches Pods.

Label: Metadata applied to objects for grouping. For example, Services send traffic to Pods based on matching labels.

Label selector: Used to identify Pods to perform actions on. For example, when a Deployment performs a rolling update, it knows which Pods to update based on its label selector – only Pods with the labels matching the Deployment’s label selector will be replaced and updated.

Manifest file: YAML file that holds the configuration of one or more Kubernetes objects. For example, a Service manifest file is typically a YAML file that holds the configuration of the Service. When you post a manifest file to the API server, its configuration is deployed to the cluster.

Master: The brains of a Kubernetes cluster. A node that hosts control plane features (API server, cluster store, scheduler etc.). Usually deployed in highly available configurations of 3, 5, or 7.

Microservices: A design pattern for modern applications. Application features are broken out into their own small applications (microservices) and can communicate via APIs. They work together to form a useful application experience.

Namespace: A way to partition a single Kubernetes cluster into multiple virtual clusters. Good for applying different quotas and access control policies on a single cluster. Not suitable for strong workload isolation.

Node: The workers of a Kubernetes cluster. A cluster node designed to run user applications. Runs the kubelet process, a container runtime, and kube-proxy service.

Observed state: Also known as current state or actual state. This is the latest view of the cluster and running applications. Controllers are always working to make the observed state match the desired state.

Orchestrator: A piece of software that deploys and manages apps. Modern apps are made from many smaller apps that work together to form a useful application. Kubernetes orchestrates/manages these small apps and keeps them healthy, and scales them up and down.

PersistentVolume (PV): Kubernetes object used to map storage volumes on a cluster. Storage resources must be mapped to PVs before they can be used by applications.

PersistentVolumeClaim (PVC): Like a ticket/voucher that allows an app to use a PV. Without a valid PVC, an app cannot use a PV. Combined with StorageClasses for dynamic volume creation.

Pod: Smallest unit of scheduling on Kubernetes. Every container running on Kubernetes must run inside a Pod. The Pod provides a shared execution environment – IP address, volumes, shared memory etc.

Reconciliation loop: A controller process watching the state of the cluster, via the API server, ensuring the observed state matches the desired state.

ReplicaSet: Runs as a controller and performs self-healing and scaling. Used by Deployments.

Secret: Like a ConfigMap for sensitive configuration data.

Service: Capital “S”. Provides stable networking for a dynamic set of Pods. By placing a Service in front of a set of Pods, the Pods can fail, scale up and down, and be replaced without the network endpoint accessing them changing.

StatefulSet: Controller that deploys and manages stateful Pods. Similar to a Deployment, but for stateful applications.

StorageClass (SC): A way to create different storage tiers/classes on a cluster. You may have an SC, called “fast”, that creates NVMe-based storage, and another SC called “medium-three-site” that creates slower storage replicated across three sites.

Volume: Generic term for persistent storage.
