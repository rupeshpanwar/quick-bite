<details>
<summary>Kubernetes Playgrounds</summary>
<br>

  Test playgrounds are the simplest ways to get Kubernetes, but they’re not intended for production. Common examples include Magic Sandbox, Play with Kubernetes, and Docker Desktop.

With Magic Sandbox, you register for an account and login. That’s it; you’ve instantly got a fully working multi-node private cluster that’s ready to go. You also get curated lessons and hands-on labs.

Play with Kubernetes requires you to login with a GitHub or Docker Hub account and follow a few simple steps to build a cluster that lasts for four hours.

Docker Desktop is a free desktop application from Docker, Inc. You download and run the installer, and after a few clicks, you’ve got a single-node development cluster on your laptop.

    ⚠️ Note: Kubernetes is a fast-developing technology; due to that, version changes, and different cluster names, the output might a bit different from what is mentioned in this course.

The course’s GitHub repo#
  > https://github.com/rupeshpanwar/TheK8sBook.git
  
</details>

<details>
<summary>Hosted Kubernetes</summary>
<br>

  Most of the major cloud platforms now offer their own hosted Kubernetes services. In this model, the control plane (masters) components are managed by your cloud platform. For example, your cloud provider makes sure the control plane is highly available, performant, and handles all control plane upgrades. On the flip side, you have less control over versions and have limited options to customize.

Irrespective of pros and cons, hosted Kubernetes services are as close to zero-effort production-grade Kubernetes as you will get. In fact, the Google Kubernetes Engine (GKE) lets you deploy a production-grade Kubernetes cluster and the Istio service mesh with just a few simple clicks. Other clouds offer similar services:

    AWS: Elastic Kubernetes Service (EKS)
    Azure: Azure Kubernetes Service (AKS)
    Linode: Linode Kubernetes Engine (LKE)
    DigitalOcean: DigitalOcean Kubernetes
    IBM Cloud: IBM Cloud Kubernetes Service
    Google Cloud Platform: Google Kubernetes Engine (GKE)
  
With these offerings in mind, ask yourself the following question before building your own Kubernetes cluster: Is building and managing your own Kubernetes cluster the best use of your time and other resources? If the answer isn’t “Hell yes”, I strongly suggest you consider a hosted service.
DIY Kubernetes clusters#

By far the hardest way to get a Kubernetes cluster is to build one yourself.

Yes, DIY installations are a lot easier than they used to be, but they’re still hard. However, they provide the most flexibility and give you ultimate control over your configuration, which can be a good thing and a bad thing.

  
</details>


<details>
<summary>Installing Kubernetes</summary>
<br>

  There are a ridiculous number of different ways to get a Kubernetes cluster, and we’re not trying to show them all (there are probably hundreds). The methods shown here are simple, and I’ve chosen them because they’re quick and easy ways to get a Kubernetes cluster that you can follow most of the examples with.

All of the examples will work on Magic Sandbox and GKE, and most of them will work on other installations. Ingress examples and volumes may not work on platforms like Docker Desktop and Play with Kubernetes.

In this course, we’ll look at the following:

    Play with Kubernetes (PWK)
    Docker Desktop: local development cluster on your laptop
    Google Kubernetes Engine (GKE): production-grade hosted cluster


</details>

<details>
<summary>Play With Kubernetes</summary>
<br>

  Play with Kubernetes (PWK) is a quick and simple way to get your hands on a development Kubernetes cluster. All you need is a computer, an internet connection, and an account on Docker Hub or GitHub.

However, it has a few limitations to be aware of.

    It’s time-limited – you get a cluster that lasts for four hours.
    It lacks some integrations with external services, such as cloud-based load balancers and volumes.
    It often suffers from capacity issues (it’s offered as a free service).

Let’s see what it looks like.

    Go to https://labs.play-with-k8s.com/

    Login with your GitHub or Docker Hub account and click Start

    Click + ADD NEW INSTANCE from the navigation pane on the left of your browser. You will be presented with a terminal window in the right of your browser. This is a Kubernetes node (node1).

    Run a few commands to see some of the components pre-installed on the node.

Run the following:
$ docker version

The output will look like:
 Docker version 19.03.11-ce...

Run the following:
$ kubectl version --output=yaml

The output will be something like the following:
clientVersion:
...
     major: "1"
     minor: "18"

As the output shows, the node already has Docker and kubectl (the Kubernetes client) pre-installed. Other tools, including kubeadm, are also pre-installed. More on these tools later.

It’s also worth noting that although the command prompt is a $, you’re actually running as root. You can confirm this by running whoami or id.

    Run the provided kubeadm init command to initialize a new cluster.

    When you added a new instance in step 3, PWK gave you a short list of commands to initialize a new Kubernetes cluster. One of these was kubeadm init.... Running this command will initialize a new cluster and configure the API server to listen on the correct IP interface.

    You may be able to specify the version of Kubernetes to install by adding the --kubernetes-version flag to the command. The latest versions can be seen here. Not all versions work with PWK.

$ kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr...

    Please be patient after the kubeadm init command as it takes a while.

You will get the following output:
[kubeadm] WARNING: kubeadm is in beta, do not use it for prod...
[init] Using Kubernetes version: v1.18.8
[init] Using Authorization modes: [Node RBAC]
<Snip>
Your Kubernetes master has initialized successfully!
<Snip>
  
Congratulations! You have a brand new single-node Kubernetes cluster. The node that you executed the command from (node1) is initialized as the master.

The output of the kubeadm init gives you a short list of commands it wants you to run. These will copy the Kubernetes config file and set permissions. You can ignore these, as PWK has already configured them for you. Feel free to poke around inside of $HOME/.kube.

    Verify the cluster with the following kubectl command:

$ kubectl get nodes

The output will be:
NAME      STATUS     ROLES   AGE       VERSION
node1     NotReady   master  1m        v1.18.4

The output shows a single-node Kubernetes cluster. However, the status of the node is NotReady. This is because you haven’t configured the Pod network yet. When you first logged on to the PWK node, you were given three commands to configure the cluster. So far, you’ve only executed the first one (kubeadm init...).

    Initialize the Pod network (cluster networking).

    Copy the second command from the list of three commands that were printed on the screen when you first created node1 (it will be a kubectl apply command). Paste it onto a new line in the terminal.

$ kubectl apply -f https://raw.githubusercontent.com...

You will get the following output:
configmap/kube-router-cfg created
daemonset.apps/kube-router created
serviceaccount/kube-router created
clusterrole.rbac.authorization.k8s.io/kube-router created
clusterrolebinding.rbac.authorization.k8s.io/kube-router created
    Verify the cluster again to see if node1 has changed to Ready (it may take a few seconds to transition to ready).

$ kubectl get nodes

You will get the following output:
NAME      STATUS    ROLES     AGE       VERSION
node1     Ready     master  2m        v1.18.4

Now that the Pod network has been initialized and the control plane is Ready, you’re ready to add some worker nodes.

    Copy the long kubeadm join that was displayed as part of the output from the kubeadm init command.

    When you initialized the new cluster with kubeadm init, the final output of the command listed a kubeadm join command to use when adding nodes. This command includes the cluster join-token, the IP socket that the API server is listening on, and other bits required to join a new node to the cluster. Copy this command and be ready to paste it into the terminal of a new node (node2).

    Click the + ADD NEW INSTANCE button in the left pane of the PWK window.

You will be given a new node called node2.

    Paste the kubeadm join command into the terminal of node2.

The join-token and IP address will be different in your environment.
$ kubeadm join --token 948f32.79bd6c8e951cf122 10.0.29.3:6443...

The output will be:

Initializing machine ID from random generator.
[preflight] running pre-flight checks
<Snip>
This node has joined the cluster:
* Certificate signing request was sent to master and a response
  was received.
* The Kubelet was informed of the new secure connection details.
  
  
    Switch back to node1 and run another kubectl get nodes
NAME      STATUS    ROLES    AGE       VERSION
node1     Ready     master   5m        v1.18.4
node2     Ready     <none>   1m        v1.18.4


Your Kubernetes cluster now has two nodes – one master and one worker node.

Feel free to add more nodes.

Congratulations! You have a fully working Kubernetes cluster that you can use as a test lab.

It’s worth pointing out that node1 was initialized as the Kubernetes master, and additional nodes will join the cluster as worker nodes. PWK usually puts a blue icon next to masters and a transparent one next to nodes. This helps you identify which is which.
</details>

<details>
<summary>Installation screenshots</summary>
<br>
  
Prequisites
  - docker
  - kubectl
  - kubeadm

   completely the user's responsibilites.

 You can bootstrap a cluster as follows:

 1. Initializes cluster master node:

 kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16
    

 2. Initialize cluster networking:

kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml


 3. (Optional) Create an nginx deployment:

 kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml
</details>

<details>
<summary>Kubeadm output</summary>
<br>
  
```
[node1 ~]$  kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16
I0507 02:53:56.170352    1622 version.go:251] remote version is much newer: v1.24.0; falling back to: stable-1.20
[init] Using Kubernetes version: v1.20.15
[preflight] Running pre-flight checks
        [WARNING Service-Docker]: docker service is not active, please run 'systemctl start docker.service'
        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
        [WARNING FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
        [WARNING Swap]: running with swap on is not supported. Please disable swap
[preflight] The system verification failed. Printing the output from the verification:
KERNEL_VERSION: 4.4.0-210-generic
DOCKER_VERSION: 20.10.1
OS: Linux
CGROUPS_CPU: enabled
CGROUPS_CPUACCT: enabled
CGROUPS_CPUSET: enabled
CGROUPS_DEVICES: enabled
CGROUPS_FREEZER: enabled
CGROUPS_MEMORY: enabled
CGROUPS_PIDS: enabled
CGROUPS_HUGETLB: enabled
        [WARNING SystemVerification]: this Docker version is not on the list of validated versions: 20.10.1. Latest validated version: 19.03
        [WARNING SystemVerification]: failed to parse kernel config: unable to load kernel module: "configs", output: "", err: exit status 1
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local node1] and IPs [10.96.0.1 192.168.0.23]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [localhost node1] and IPs [192.168.0.23 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [localhost node1] and IPs [192.168.0.23 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 12.004769 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.20" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node node1 as control-plane by adding the labels "node-role.kubernetes.io/master=''" and "node-role.kubernetes.io/control-plane='' (deprecated)"
[mark-control-plane] Marking the node node1 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: stv4f6.l9fpk299jbvnfili
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.0.23:6443 --token stv4f6.l9fpk299jbvnfili \
    --discovery-token-ca-cert-hash sha256:e44ff7b87ffb2d25570cb980808d07fd7965114a0550fef1cb7ca1c93b8a1ab6 
Waiting for api server to startup
Warning: resource daemonsets/kube-proxy is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
daemonset.apps/kube-proxy configured
No resources found
```  

</details>

<details>
<summary>worker node- kubeadm join</summary>
<br>

``` 
node2 ~]$ kubeadm join 192.168.0.23:6443 --token stv4f6.l9fpk299jbvnfili \
>     --discovery-token-ca-cert-hash sha256:e44ff7b87ffb2d25570cb980808d07fd7965114a0550fef1cb7ca1c93b8a1ab6 
Initializing machine ID from random generator.
[preflight] Running pre-flight checks
        [WARNING Service-Docker]: docker service is not active, please run 'systemctl start docker.service'
        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
        [WARNING FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
        [WARNING Swap]: running with swap on is not supported. Please disable swap
[preflight] The system verification failed. Printing the output from the verification:
KERNEL_VERSION: 4.4.0-210-generic
DOCKER_VERSION: 20.10.1
OS: Linux
CGROUPS_CPU: enabled
CGROUPS_CPUACCT: enabled
CGROUPS_CPUSET: enabled
CGROUPS_DEVICES: enabled
CGROUPS_FREEZER: enabled
CGROUPS_MEMORY: enabled
CGROUPS_PIDS: enabled
CGROUPS_HUGETLB: enabled
        [WARNING SystemVerification]: this Docker version is not on the list of validated versions: 20.10.1. Latest validated version: 19.03
        [WARNING SystemVerification]: failed to parse kernel config: unable to load kernel module: "configs", output: "", err: exit status 1
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

[node2 ~]$
```
</details>

<details>
<summary>Commands summary </summary>
<br>

```
    1  docker
    2  kubeadm
    4  kubectl version --output=yaml
    5   kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16
    7  kubectl get nodes
    8  ls $HOME/.kube
    9  ls $HOME/.kube/config
   10  cat $HOME/.kube/config
   12  alias k='kubectl'
   13  alias kg='kubectl get'
   14  alias kd='kubectl delete'
   15  kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml
   16  kg nodes
   18  export KUBECONFIG=/etc/kubernetes/admin.conf
  node2 ~]$ kubeadm join 192.168.0.23:6443 --token stv4f6.l9fpk299jbvnfili \
>     --discovery-token-ca-cert-hash sha256:e44ff7b87ffb2d25570cb980808d07fd7965114a0550fef1cb7ca1c93b8a1ab6
   19  kg nodes
  
```
</details>
  
<details>
<summary>GKE- optional installation</summary>
<br>

 gcloud beta container --project "united-option-342608" clusters create "cluster-cka" --zone "asia-east1-b" --no-enable-basic-auth --cluster-version "1.21.10-gke.2000" --release-channel "regular" --machine-type "e2-medium" --image-type "COS_CONTAINERD" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --max-pods-per-node "110" --num-nodes "2" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM --enable-ip-alias --network "projects/united-option-342608/global/networks/default" --subnetwork "projects/united-option-342608/regions/asia-east1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations "asia-east1-b"

</details>

