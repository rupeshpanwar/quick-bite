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

