- Installing K8s
<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144815774-133e1c70-39e5-47bf-a3a2-389648295f1d.png">
- Docker desktop
<img width="700" alt="image" src="https://user-images.githubusercontent.com/75510135/144816263-a7847bbf-4bfc-4b35-a3b4-f93975df50cd.png">
<img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/144816321-b0c04c74-e89a-4a8b-ad3c-abe60e1ddf61.png">
<img width="778" alt="image" src="https://user-images.githubusercontent.com/75510135/144816360-ace3bc98-1611-453d-bda5-d31147cbbd22.png">
<img width="503" alt="image" src="https://user-images.githubusercontent.com/75510135/144816539-0fba7548-7032-40be-a35e-ee9ec6e970a7.png">
- minikube
<img width="715" alt="image" src="https://user-images.githubusercontent.com/75510135/144816897-ba5cc474-d053-4449-9f57-9e3bc0943cbb.png">
<img width="534" alt="image" src="https://user-images.githubusercontent.com/75510135/144817317-849bffe1-c831-4907-ab05-3636d3689a40.png">
<img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/144817892-6c91d969-0e46-4ff3-b4a4-4d636981f319.png">
<img width="716" alt="image" src="https://user-images.githubusercontent.com/75510135/144818045-b5d998f4-fb5a-4234-93d4-427cecbd29ed.png">

- Installation on Linux machine

<img width="778" alt="image" src="https://user-images.githubusercontent.com/75510135/144819532-9a9477d3-fe00-4150-a7b4-201b6749e0b6.png">
<img width="763" alt="image" src="https://user-images.githubusercontent.com/75510135/144820108-b95306ae-65da-4467-904c-0e26e2a0330f.png">
Install Tips for minikube and MicroK8s
Here are some tips for using minikube or MicroK8s in this course:

Note that in March 2020, Kubernetes 1.18 came out, and kubectl run syntax and functionality changed. This course is designed for 1.14-1.17 which are the prevalent versions used in cloud hosters, Docker Desktop, and enterprise solutions. minikube and MicroK8s now default to 1.18 installs, so it's up to you if you want to force installing version 1.17 (which I would recommend for now) or skip some of the first lectures about kubectl run because they no longer create deployments/jobs/cronjobs/services, etc. They only create pods.
minikube

    minikube defaults to installing the latest Kubernetes release, but you likely don't want that, since it's 6-12 months before many clouds and enterprise solutions update to recent versions. You can look up versions on GitHub, and install a specific version like this minikube start --kubernetes-version='1.17.4'

    Unlike Docker Desktop, which lets you use localhost for your Kubernetes services, minikube runs in VirtualBox (by default) and has its own IP. Find that with minikube ip

    Remember top stop minikube when you're not using it to save resources minikube stop

    Check the status of what is running in minikube with minikube status

MicroK8s

    MicroK8s defaults to installing the latest Kubernetes release, but you likely don't want that, since it's 6-12 months before many clouds and enterprise solutions update to recent versions. You can look up versions on GitHub, and install a specific version like this sudo snap install microk8s --classic --channel=1.17/stable

    Before using it, you'll need to enable the CoreDNS pod so it'll resolve service DNS names later: microk8s.enable dns

    Check the status of what is running in MicroK8s with microk8s.status



<img width="709" alt="image" src="https://user-images.githubusercontent.com/75510135/144820437-64d8738d-03fb-4d45-a0a9-2ce8c9318fc4.png">

<img width="897" alt="image" src="https://user-images.githubusercontent.com/75510135/144821258-329e56fc-3ca7-42a8-8177-b459abc85342.png">

Shpod Tips and Tricks

Be sure to come back to this lecture later if you have shpod issues, as I've thrown in common hiccups as you use it throughout the course!

Tip 1: Namespaces matter!

Once you learn about namespaces, you know that running kubectl commands often only affects the current namespace. Shpod runs in the shpod namespace, so if you mean to do something with the default namesapce, you need to either ensure that shpod config is set to use the default namespace (which it is by default) or add -n default to your commands. So kubectl get pods would turn into kubectl get -n default pods. We've setup the shpod pod to set it's namespace to default though, so this shouldn't be a big issue.

Tip 2: DNS matters with Namespaces!

The above shpod namespace affects DNS as well. If you need to curl or ping a Service name (which you'll learn later), remember that Kubernetes Service DNS names are namespace-sensitive from inside the cluster. Doing a ping myservice from a pod in one namespace only works if that Service is in the same namespace. In the Shpod, you would need to ping mypod.default if that Service was in the default namespace.

Tip 2: Attach shows you the console (tty) output, even from multiple terminals. You can use exec for additional terminal shells

An attach command will show the virtual console of a pod (like a tty), so multiple attach commands in multiple terminal windows will show the same thing because they are both looking at the console output. For your 2nd terminal, you can use an exec command that will start a new shell process in the existing container. This works exactly the same way as Docker attach and exec commands:

1st window, attach:

kubectl attach --namespace=shpod -ti shpod

2nd window, create a new bash shell:

kubectl exec --namespace=shpod -ti shpod -- bash -l

# LAB: Option 1: Setting up single node kubernetes with Minikube
Single node k8s cluster with Minikube


Minikube offers one of the easiest zero to dev experience to setup a single node kubernetes cluster. Its also the ideal way to create a local dev environment to test kubernetes code on.

This document explains how to setup and work with single node kubernetes cluster with minikube.
Install Minikube

Instructions to install minikube may vary based on the operating system and choice of the hypervisor. This is the official document which explains how to install minikube.
Start all in one single node cluster with minikube

    minikube status

[output]

    minikube:
    cluster:
    kubectl:

    minikube start

[output]

    Starting local Kubernetes v1.8.0 cluster...
    Starting VM...
    Getting VM IP address...
    Moving files into cluster...
    Setting up certs...
    Connecting to cluster...
    Setting up kubeconfig...
    Starting cluster components...
    Kubectl is now configured to use the cluster.
    Loading cached images from config file.

    minikube status
     

[output]

    minikube: Running
    cluster: Running
    kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.100

Launch a kubernetes dashboard

    minikube dashboard

Setting up docker environment

    minikube docker-env
    export DOCKER_TLS_VERIFY="1"
    export DOCKER_HOST="tcp://192.168.99.100:2376"
    export DOCKER_CERT_PATH="/Users/gouravshah/.minikube/certs"
    export DOCKER_API_VERSION="1.23"
    # Run this command to configure your shell:
    # eval $(minikube docker-env)

Run the command given above, e.g.

    eval $(minikube docker-env)

Now your docker client should be able to connect with the minikube cluster

    docker ps

Additional Commands

    minikube ip
    minikube get-k8s-versions
    minikube logs

# LAB: Option 2: Provisioning 3 nodes for Kubernetes with Vagrant and VirtualBox

Install VirtualBox and Vagrant


    VirtualBox: https://www.virtualbox.org/wiki/Downloads

    Vagrant:  https://www.vagrantup.com/downloads.html


Provisioning Vagrant Nodes


Clone repo if not already

    git clone https://github.com/schoolofdevops/lab-setup.git
     
     

Launch environments with Vagrant

    cd lab-setup/kubernetes/vagrant-kube-cluster
     
    vagrant up
     

Login to nodes

Open three different terminals to login to 3 nodes created with above command

Terminal 1

    vagrant ssh kube-01
    sudo su
     

Terminal 2

    vagrant ssh kube-02
    sudo su

Terminal 3

    vagrant ssh kube-03
    sudo su

Once the environment is setup, follow Initialization of Master onwards from the following tutorial


https://schoolofdevops.github.io/kubernetes-labguide/3_install_kubernetes/#initializing-master

# LAB: Setup Kubernetes Cluster with Kubeadm
Kubeadm : Bring Your Own Nodes (BYON)


This documents describes how to setup kubernetes from scratch on your own nodes, without using a managed service. This setup uses kubeadm to install and configure kubernetes cluster.


Compatibility

Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.

The below steps are applicable for the below mentioned OS

    OS: Ubuntu

    Version: 16.04

    Codename: Xenial


Base Setup (Skip if using vagrant)

Skip this step and scroll to Initializing Master if you have setup nodes with vagrant

On all nodes which would be part of this cluster, you need to do the base setup as described in the following steps. To simplify this, you could also download and run this script


Create Kubernetes Repository

We need to create a repository to download Kubernetes.

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

    cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
    EOF


Installation of the packages

We should update the machines before installing so that we can update the repository.

    apt-get update -y

Installing all the packages with dependencies:

    apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni

    rm -rf /var/lib/kubelet/*


Setup sysctl configs

In order for many container networks to work, the following needs to be enabled on each node.

    sysctl net.bridge.bridge-nf-call-iptables=1

The above steps has to be followed in all the nodes.


Initializing Master

This tutorial assumes kube-01 as the master and used kubeadm as a tool to install and setup the cluster. This section also assumes that you are using vagrant based setup provided along with this tutorial. If not, please update the IP address of the master accordingly.

To initialize master, run this on kube-01

    kubeadm init --apiserver-advertise-address 192.168.12.10 --pod-network-cidr=192.168.0.0/16
     


Initialization of the Nodes (Previously Minions)

After master being initialized, it should display the command which could be used on all worker/nodes to join the k8s cluster.

e.g.

    kubeadm join --token c04797.8db60f6b2c0dd078 192.168.12.10:6443 --discovery-token-ca-cert-hash sha256:88ebb5d5f7fdfcbbc3cde98690b1dea9d0f96de4a7e6bf69198172debca74cd0

Copy and paste it on all node.


Troubleshooting Tips

If you lose the join token, you could retrieve it using

    kubeadm token list

On successfully joining the master, you should see output similar to following,

    root@kube-03:~# kubeadm join --token c04797.8db60f6b2c0dd078 159.203.170.84:6443 --discovery-token-ca-cert-hash sha256:88ebb5d5f7fdfcbbc3cde98690b1dea9d0f96de4a7e6bf69198172debca74cd0
    [kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
    [preflight] Running pre-flight checks
    [discovery] Trying to connect to API Server "159.203.170.84:6443"
    [discovery] Created cluster-info discovery client, requesting info from "https://159.203.170.84:6443"
    [discovery] Requesting info from "https://159.203.170.84:6443" again to validate TLS against the pinned public key
    [discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "159.203.170.84:6443"
    [discovery] Successfully established connection with API Server "159.203.170.84:6443"
    [bootstrap] Detected server version: v1.8.2
    [bootstrap] The server supports the Certificates API (certificates.k8s.io/v1beta1)
     
    Node join complete:
    * Certificate signing request sent to master and response
      received.
    * Kubelet informed of new secure connection details.
     
    Run 'kubectl get nodes' on the master to see this machine join.


Setup the admin client - Kubectl

On Master Node

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config


Installing CNI with Weave

Installing overlay network is necessary for the pods to communicate with each other across the hosts. It is necessary to do this before you try to deploy any applications to your cluster.

There are various overlay networking drivers available for kubernetes. We are going to use Weave Net.

    export kubever=$(kubectl version | base64 | tr -d '\n')
    kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"


Validating the Setup

You could validate the status of this cluster, health of pods and whether all the components are up or not by using a few or all of the following commands.

To check if nodes are ready

    kubectl get nodes
    kubectl get cs
     

[ Expected output ]

    root@kube-01:~# kubectl get nodes
    NAME      STATUS    ROLES     AGE       VERSION
    kube-01   Ready     master    m        v1.8.2
    kube-02   Ready     <none>    m        v1.8.2
    kube-03   Ready     <none>    m        v1.8.2

Additional Status Commands

    kubectl version
     
    kubectl cluster-info
     
    kubectl get pods -n kube-system
     
    kubectl get events
     

It will take a few minutes to have the cluster up and running with all the services.


Possible Issues

    Nodes are node in Ready status

    kube-dns is crashing constantly

    Some of the systems services are not up

Most of the times, kubernetes does self heal, unless its a issue with system resources not being adequate. Upgrading resources or launching it on bigger capacity VM/servers solves it. However, if the issues persist, you could try following techniques,

Troubleshooting Tips

Check events

    kubectl get events

Check Logs

    kubectl get pods -n kube-system
     
    [get the name of the pod which has a problem]
     
    kubectl logs <pod> -n kube-system
     

e.g.

    root@kube-01:~# kubectl logs kube-dns-545bc4bfd4-dh994 -n kube-system
    Error from server (BadRequest): a container name must be specified for pod kube-dns-545bc4bfd4-dh994, choose one of:
    [kubedns dnsmasq sidecar]
     
     
    root@kube-01:~# kubectl logs kube-dns-545bc4bfd4-dh994  kubedns  -n kube-system
    I1106 14:41:15.542409       1 dns.go:48] version: 1.14.4-2-g5584e04
    I1106 14:41:15.543487       1 server.go:70] Using
     
    ....
     


Enable Kubernetes Dashboard

(Dashboard setup is broken with kubernetes 1.16 version onwards. I am working on fixing it. )

After the Pod networks is installled, We can install another add-on service which is Kubernetes Dashboard.

Installing Dashboard:

    kubectl apply -f https://gist.githubusercontent.com/initcron/32ff89394c881414ea7ef7f4d3a1d499/raw/4863613585d05f9360321c7141cc32b8aa305605/kube-dashboard.yaml
     

This will create a pod for the Kubernetes Dashboard.

To access the Dashboard in th browser, run the below command

    kubectl describe svc kubernetes-dashboard -n kube-system

Sample output:

    kubectl describe svc kubernetes-dashboard -n kube-system
    Name:                   kubernetes-dashboard
    Namespace:              kube-system
    Labels:                 app=kubernetes-dashboard
    Selector:               app=kubernetes-dashboard
    Type:                   NodePort
    IP:                     10.98.148.82
    Port:                   <unset> 80/TCP
    NodePort:               <unset> 31000/TCP
    Endpoints:              10.40.0.1:9090
    Session Affinity:       None

Now check for the node port, here it is 31000, and go to the browser,

    masterip:32756

The Dashboard Looks like:

alt text
Check out the supporting code

Before we proceed further, please checkout the code from the following git repo. This would offer the supporting code for the exercises that follow.

    git clone https://github.com/initcron/k8s-code.git
    
