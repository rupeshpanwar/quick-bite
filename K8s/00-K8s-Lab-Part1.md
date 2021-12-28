# Topics covered
1. Setup
2. Visualizer
3. Pods
4. Replica sets



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

# LAB: Attaching a volume to the Pod
Attach a Volume to the Pod

Lets create a pod for database and attach a volume to it. To achieve this we will need to

    create a volumes definition

    attach volume to container using VolumeMounts property

Local host volumes are of two types:
* emptyDir
* hostPath

We will pick hostPath. Refer to this doc to read more about hostPath.

File: db-pod.yaml

    apiVersion: v1
    kind: Pod
    metadata:
      name: db
      labels:
        app: postgres
        role: database
        tier: back
    spec:
      containers:
        - name: db
          image: postgres:9.4
          ports:
            - containerPort: 5432
          volumeMounts:
          - name: db-data
            mountPath: /var/lib/postgresql/data
      volumes:
      - name: db-data
        hostPath:
          path: /var/lib/pgdata
          type: DirectoryOrCreate

To create this pod,

    kubectl apply -f db-pod.yaml
     
    kubectl describe pod db
     
    kubectl get events

Exercise : Examine /var/lib/pgdata on the systems to check if the directory is been created and if the data is present.

# LAB : Multi Container Pods
Creating Multi Container Pods


file: multi_container_pod.yml

    apiVersion: v1
    kind: Pod
    metadata:
      name: web
      labels:
        tier: front
        app: nginx
        role: ui
    spec:
      containers:
        - name: nginx
          image: nginx:stable-alpine
          ports:
            - containerPort: 80
              protocol: TCP
          volumeMounts:
            - name: data
              mountPath: /var/www/html-sample-app
     
        - name: sync
          image: schoolofdevops/sync:v2
          volumeMounts:
            - name: data
              mountPath: /var/www/app
     
      volumes:
        - name: data
          emptyDir: {}

To create this pod

    kubectl apply -f multi_container_pod.yml

Check Status

    root@kube-01:~# kubectl get pods
    NAME      READY     STATUS              RESTARTS   AGE
    nginx     0/2       ContainerCreating   0          7s
    vote      1/1       Running             0          3m

Checking logs, logging in

    kubectl logs  web  -c sync
    kubectl logs  web  -c nginx
     
    kubectl exec -it web  sh  -c nginx
    kubectl exec -it web  sh  -c sync
     

Observe whats common and whats isolated in two containers running inside the same pod using the following commands,

shared

    hostname
    ifconfig

isolated

    cat /etc/issue
    ps aux
    df -h
     


# Exercise
Pods

1. Create a Pod manifest which uses "ghost" image and open port 2368.

    apiVersion: v1
    kind: Pod
    metadata:
      name: ghost
    spec:
      containers:
      - image: xxx
        name: ghost
        ports:
        - containerPort: xxx
          hostPort: xxx

Get the name of the Node in which the Pod is scheduled by running,

    kubectl describe pod <POD_NAME>
     
    [output]
    Name:           <POD_NAME>
    Namespace:      default
    Node:           <NODE_NAME>/<NODE_IP>
    Start Time:     Wed, xx May 201x 15:59:29 +0530

Try to access the application on the host's port 2368.

    curl <NODE_IP>:2368

Reference :Ghost Docker image

2. Create a Pod with ubuntu:trusty image and a command to echo “YOUR_NAME” which overrides the default CMD/ENTRYPOINT of the image.

Reference: Define command argument in a Pod

3. Apply the following Pod manifest and read the error. Fix it by editing it.

    apiVersion: v1apps/beta1
    kind: Pod
    metadata:
      name: mogambo-frontend
      label:
        role: frontend
    spec:
      containers:
        - name: frontend
          image: schoolofdevops/frontend:orange
          ports:
            - containerName: web
              Port: 8079
              protocol: TCP

Reference: Debugging a unscheduled Pod

4. A Pod with the following pod always crashes with CrashLoopBackOff error. How would you fix it?

          image: schoolofdevops/nginx:break
          ports: 80

Reference: Debugging a crashed Pod

5. You are running a Pod with hostPort option. Your Pod status stays “pending”. What could be the issue for the Pod not being scheduled?

Reference: Debugging a unscheduled Pod

6. The given manifest for multi-container pod is not working as intended. It does not sync the content between containers like expected. What could be the issue? Find the issue just by reading the manifest.

    apiVersion: v1
    kind: Pod
    metadata:
      name: web
      labels:
        tier: front
        app: nginx
        role: ui
    spec:
      containers:
        - name: nginx
          image: nginx:stable-alpine
          ports:
            - containerPort: 80
              protocol: TCP
          volumeMounts:
            - name: data
              mountPath: /var/www/html-sample-app
     
        - name: sync
          image: schoolofdevops/sync:v2
          volumeMounts:
            - name: datanew
              mountPath: /var/www/app
     
      volumes:
        - name: data
          emptyDir: {}

7. For the above given manifest, the following command is not working. What could be the issue?

    kubeclt exec -it web -sh -c synch

8. Try to apply the following manifest. If fails, try to debug.

    apiVersion: v1
    kind: Pod
    metadata:
      name: web
      labels:
        app:
        role: role
    spec:
      containers:
        - name: web
          image: robotshop/rs-web:latest
          ports:
            - containerPort: 8080
              protocol: TCP

9. Fix the following manifest. Don't apply it. Just fix it by reading.

    apiVersion: v1
    kind: pod
    metadata:
      name: web
    labels:
      role: role
    spec:
      containers:
        - name: web
          image: robotshop/rs-web:latest
          ports:
            - containerport: 8080
              protocol: TCP

10. Mount /var/www/html from Pod using the follwing manifest. Fill the missing fields.

    apiVersion: v1
    kind: Pod
    metadata:
      name: web
      labels:
        role: role
    spec:
      containers:
        - name: web
          image: robotshop/rs-web:latest
          ports:
            - containerPort: 8080
              protocol: TCP
      volumes:
        - name: roboshop-storage
          emptyDir: {}

11. Write a Pod manifest with the image nginx which has a volume that mounts /etc/nginx/ directory. Use "hostPath" volume type.

    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
        ports:
        - containerPort: 80
        volumeMounts:
          xxx

# LAB: Creating a Namespace and switching to it
Setting up a Namespace

Check current config

    kubectl config view
    kubectl config get-contexts

You could also examine the current configs in file cat ~/.kube/config
Creating a namespace

Namespaces offers separation of resources running on the same physical infrastructure into virtual clusters. It is typically useful in mid to large scale environments with multiple projects, teams and need separate scopes. It could also be useful to map to your workflow stages e.g. dev, stage, prod.

Lets create a namespace called instavote

    cd projects/instavote
    cat instavote-ns.yaml

[output]

    kind: Namespace
    apiVersion: v1
    metadata:
      name: instavote

Lets create a namespace

    kubectl get ns
    kubectl apply -f instavote-ns.yaml
     
    kubectl get ns

And switch to it

    kubectl config --help
     
    kubectl config get-contexts
     
    kubectl config current-context
     
    kubectl config set-context --current --namespace=instavote
     
    kubectl config view
     
    kubectl config get-contexts
     
# LAB: Writing Replica Set Specs
Writing ReplicaSet Specs


To understand how ReplicaSets works with the selectors lets launch a pod in the new namespace with existing specs.

    cd k8s-code/pods
    kubectl apply -f vote-pod.yaml
     
    kubectl get pods
    cd ../projects/instavote/dev/

Lets now write the spec for the Rplica Set. This is going to mainly contain,

    replicas

    selector

    template (pod spec )

    minReadySeconds

file: vote-rs.yaml

    apiVersion: apps/v1
    kind: ReplicaSet
    metadata:
      name: vote
    spec:
      replicas: 5
      minReadySeconds: 20
      selector:
        matchLabels:
          role: vote
        matchExpressions:
          - {key: version, operator: In, values: [v1, v2, v3]}
      template:

Lets now add the metadata and spec from pod spec defined in vote-pod.yaml. And with that, the Replica Set Spec changes to

file: vote-rs.yaml

    apiVersion: apps/v1
    kind: ReplicaSet
    metadata:
      name: vote
    spec:
      replicas: 5
      minReadySeconds: 20
      selector:
        matchLabels:
          role: vote
        matchExpressions:
          - {key: version, operator: In, values: [v1, v2, v3]}
      template:
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
              ports:
                - containerPort: 80
                  protocol: TCP


# Replica Sets in Action


If you are not running a monitoring screen, start it in a new terminal with the following command.

    watch -n 1 kubectl get  pod,deploy,rs,svc

    kubectl delete pod vote


    kubectl apply -f vote-rs.yaml --dry-run
     
    kubectl apply -f vote-rs.yaml
     
    kubectl get rs
     
    kubectl describe rs vote
     
    kubectl get pods
     
     

Exercise :

    Switch to monitoring screen, observe how many replicas were created and why

    Compare selectors and labels of the pods created with and without replica sets

    kubectl get pods
     
    kubectl get pods --show-labels

Exercise: Deploying new version of the application

    kubectl edit rs/vote

Update the version of the image from schoolofdevops/vote:v1 to schoolofdevops/vote:v2

Save the file. Observe if application got updated. Note what do you observe. Do you see the new version deployed ??
Exercise: Self Healing Replica Sets

List the pods and kill some of those, see what replica set does.

    kubectl get pods
    kubectl delete pods  vote-xxxx  vote-yyyy

where replace xxxx and yyyy with actual pod ids.

Questions:

    Did replica set replaced the pods ?

    Which version of the application is running now ?

Lets now delete the pod created independent of replica set.

    kubectl get pods
    kubectl delete pods  vote

Observe what happens.

  * Does replica set take any action after deleting the pod created outside of its spec ? Why?

# Exercises

1. The following replication controller manifest has some bugs in it. Fix them.

    apiVersion: v1/beta1
    kind: ReplicationController
    metadata:
      name: loop
    spec:
      replicas: 3
      selecter:
        app: loop
      templates:
        metadata:
          name: loop
          labels:
          app: loop
        specs:
          container:
          - name: loop
              image: schoolofdevops/loop

Reference: Replication Controller

2. Create Pods using following manifests. Each Pod has different values for the Label "platform". You should create a ReplicaSet with 4 replicas, which also selects both Pods based on "platform" Label. Tip: You may have to use matchExpressions attribute in your ReplicaSet.

    file: sync-aws-po.yml
    apiVersion: v1
    kind: Pod
    metadata:
      name: sync-aws
      labels:
        version: 2
        platform: aws
    spec:
      containers:
        - name: sync
          image: schoolofdevops/sync:v2
     
    file: sync-gcp-po.yml
    apiVersion: v1
    kind: Pod
    metadata:
      name: sync-gcp
      labels:
        version: 2
        platforms: gcp
    spec:
      containers:
        - name: sync
          image: schoolofdevops/sync:v2

3. Create a Namespace with the name test and prod.

        - 1. For test create it using kubectl cli
        - 2. For prod, create from a namespace manifest(yaml) file.

4. The following manifest is working as intended. Try to debug.

    apiVersion: v1
    kind: ReplicationController
    metadata:
      name: web
      labels:
        role: role
    spec:
      replicas: 3
      selector:
        app: robotshop
      template:
        metadata:
          name: robotshop
          labels:
            app: robotshop
      containers:
        - name: web
          image: robotshop/rs-web:latest
          ports:
            - containerPort: 8080
              protocol: TCP

5. How do you get the logs from all pods of a Replication Controller?

Reference: logs from all pods in a RC

6. The Pods from a Replication Controller has stuck in Terminating status and doesn't actually get deleted. How do you delete these Pods.?

Reference: Delete Pods forcefully

7. How do you force repulling an image with the same tag?

    apiVersion: v1
    kind: Pod
    metadata:
      name: kuard
    spec:
      containers:
        - image: gcr.io/kuar-demo/kuard-amd64:1
          name: kuard
          ports:
            - containerPort: 8080
              name: http
              protocol: TCP

Reference: Force image pull

8. When I try to apply the following Pod manifest, I am getting image <user/image>:latest not found. How would you fix it?

     `Tip`: This image is in a private registry.

    apiVersion: v1
    kind: ReplicationController
    metadata:
      name: web
      labels:
        role: role
    spec:
      replicas: 3
      selector:
        app: robotshop
      template:
        metadata:
          name: robotshop
          labels:
            app: robotshop
      containers:
        - name: web
          image: my-private-registry/robotshop/rs-web:latest
          ports:
            - containerPort: 8080
              protocol: TCP

Reference: Pulling images from private registry

9. Launch the following Replication Controller in Prod namespace and use kubectl to scale the replicas from 3 to 6.

    apiVersion: v1
    kind: ReplicationController
    metadata:
      name: web
      labels:
        role: role
    spec:
      replicas: 3
      selector:
        app: robotshop
      template:
        metadata:
          name: robotshop
          labels:
            app: robotshop
        spec:
          containers:
            - name: web
              image: robotshop/rs-web:latest
              ports:
                - containerPort: 8080
                  protocol: TCP

