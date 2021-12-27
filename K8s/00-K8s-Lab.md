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
    
    

# LAB: Setting up Kubernetes Visualiser
Kubernetes Visualizer

In this chapter we will see how to set up kubernetes visualizer that will show us the changes in our cluster in real time.
Set up

Fork the repository and deploy the visualizer on kubernetes

    git clone  https://github.com/schoolofdevops/kube-ops-view
    kubectl apply -f kube-ops-view/deploy/
     

[Sample Output]

    serviceaccount "kube-ops-view" created
    clusterrole "kube-ops-view" created
    clusterrolebinding "kube-ops-view" created
    deployment "kube-ops-view" created
    ingress "kube-ops-view" created
    deployment "kube-ops-view-redis" created
    service "kube-ops-view-redis" created
    service "kube-ops-view" created

Get the nodeport for the service.

    kubectl get svc
     
    [output]
    NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    kube-ops-view         NodePort    10.107.204.74   <none>        80:**30073**/TCP   1m
    kube-ops-view-redis   ClusterIP   10.104.50.176   <none>        6379/TCP       1m
    kubernetes            ClusterIP   10.96.0.1       <none>        443/TCP        8m

In my case, port 30073 is the nodeport.

Visit the port from the browser. You could add /#scale=2.0 or similar option where 2.0 = 200% the scale.

    http://<NODE_IP:NODE_PORT>/#scale=2.0





# LAB: Writing Pod Spec, Launching and Operating a Pod
Deploying Pods


Life of a pod

    Pending : in progress

    Running

    Succeeded : successfully exited

    Failed

    Unknown


Launching pods without YAML

You could use generators to launch a pod by specifying just the image.

For example, if you would like to launch a pod for redis, with image redis:alpine, the following command would work,

    kubectl run redis --generator=run-pod/v1 --image=redis


To list  and operate the pod 

    kubectl get pods
     
    kubectl get pod -o wide
     
    kubectl describe pod redis 
     
    kubectl delete pod redis

Resource Configs

Each entity created with kubernetes is a resource including pod, service, deployments, replication controller etc. Resources can be defined as YAML or JSON. Here is the syntax to create a YAML specification.

AKMS => Resource Configs Specs

    apiVersion: v1
    kind:
    metadata:
    spec:

Spec Schema: https://kubernetes.io/docs/user-guide/pods/multi-container/

To list supported version of apis

    kubectl api-versions

Writing Pod Spec

Lets now create the Pod config by adding the kind and specs to scheme given in the file vote-pod.yaml as follows.

Filename: k8s-code/pods/vote-pod.yaml

    apiVersion:
    kind: Pod
    metadata:
    spec:

Lets edit this and add the pod specs

Filename: k8s-code/pods/vote-pod.yaml

    apiVersion: v1
    kind: Pod
    metadata:
      name: vote
      labels:
        app: python
        role: vote
        version: v1
    spec:
      containers:
        - name: app
          image: schoolofdevops/vote:v1
     

Use this link to refer to pod spec
Launching and operating a Pod

To launch a monitoring screen to see whats being launched, use the following command in a new terminal window where kubectl is configured.

    watch -n 1  kubectl get pods,deploy,rs,svc
     

kubectl Syntax:

    kubectl
    kubectl apply --help
    kubectl apply -f FILE

To Launch pod using configs above,

    kubectl apply -f vote-pod.yaml
     

To view pods

    kubectl get pods
     
    kubectl get po -o wide
     
    kubectl get pods vote

To get detailed info

    kubectl describe pods vote

[Output:]

    Name:           vote
    Namespace:      default
    Node:           kube-3/192.168.0.80
    Start Time:     Tue, 07 Feb 2017 16:16:40 +0000
    Labels:         app=voting
    Status:         Running
    IP:             10.40.0.2
    Controllers:    <none>
    Containers:
      vote:
        Container ID:       docker://48304b35b9457d627b341e424228a725d05c2ed97cc9970bbff32a1b365d9a5d
        Image:              schoolofdevops/vote:latest
        Image ID:           docker-pullable://schoolofdevops/vote@sha256:3d89bfc1993d4630a58b831a6d44ef73d2be76a7862153e02e7a7c0cf2936731
        Port:               80/TCP
        State:              Running
          Started:          Tue, 07 Feb 2017 16:16:52 +0000
        Ready:              True
        Restart Count:      0
        Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-2n6j1 (ro)
        Environment Variables:      <none>
    Conditions:
      Type          Status
      Initialized   True
      Ready         True
      PodScheduled  True
    Volumes:
      default-token-2n6j1:
        Type:       Secret (a volume populated by a Secret)
        SecretName: default-token-2n6j1
    QoS Class:      BestEffort
    Tolerations:    <none>
    Events:
      FirstSeen     LastSeen        Count   From                    SubObjectPath           Type            Reason          Message
      ---------     --------        -----   ----                    -------------           --------        ------          -------
      21s           21s             1       {default-scheduler }                            Normal          Scheduled       Successfully assigned vote to kube-3
      20s           20s             1       {kubelet kube-3}        spec.containers{vote}   Normal          Pulling         pulling image "schoolofdevops/vote:latest"
      10s           10s             1       {kubelet kube-3}        spec.containers{vote}   Normal          Pulled          Successfully pulled image "schoolofdevops/vote:latest"
      9s            9s              1       {kubelet kube-3}        spec.containers{vote}   Normal          Created         Created container with docker id 48304b35b945; Security:[seccomp=unconfined]
      9s            9s              1       {kubelet kube-3}        spec.containers{vote}   Normal          Started         Started container with docker id 48304b35b945

Commands to operate the pod

    kubectl logs vote
     
    kubectl exec -it vote  sh
     
     

Inside the container in a pod

    ifconfig
    cat /etc/issue
    hostname
    cat /proc/cpuinfo
    ps aux

Port Forwarding

This works if you have setup kubectl on a local laptop.

    kubectl port-forward --help
    kubectl port-forward vote 8000:80
# LAB: Troubleshooting Pod Issues
Troubleshooting Tip


If you would like to know whats the current status of the pod, and if its in a error state, find out the cause of the error, following command could be very handy.

    kubectl get pod vote -o yaml

Lets learn by example. Update pod spec and change the image to something that does not exist.

    kubectl edit pod vote

This will open a editor. Go to the line which defines image and change it to a tag that does not exist

e.g.

    spec:
      containers:
      - image: schoolofdevops/vote:srgwegew
        imagePullPolicy: Always

where tag srgwegew does not exist. As soon as you save this file, kubernetes will apply the change.

Now check the status,

    kubectl get pods  
     
    NAME      READY     STATUS             RESTARTS   AGE
    vote      0/1       ImagePullBackOff   0          7m

The above output will only show the status, with a vague error. To find the exact error, lets get the stauts of the pod.

Observe the status field.

    kubectl get pod vote -o yaml

Now the status field shows a detailed information, including what the exact error. Observe the following snippet...

    status:
    ...
    containerStatuses:
    ....
    state:
      waiting:
        message: 'rpc error: code = Unknown desc = Error response from daemon: manifest
          for schoolofdevops/vote:latst not found'
        reason: ErrImagePull
    hostIP: 139.59.232.248

This will help you to pinpoint to the exact cause and fix it quickly.

Now that you are done experimenting with pod, delete it with the following command,

    kubectl delete pod vote
     
    kubectl get pods

