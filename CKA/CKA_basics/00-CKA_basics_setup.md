<details>
<summary>Introduction & Architecture</summary>
<br>

  <img width="807" alt="image" src="https://user-images.githubusercontent.com/75510135/163704481-e4a73cf9-34da-4e87-9ac3-88096212c7f7.png">

  <img width="825" alt="image" src="https://user-images.githubusercontent.com/75510135/163704509-f654c766-b898-4bbd-8bab-e77b8ce9c8c6.png">

  <img width="740" alt="image" src="https://user-images.githubusercontent.com/75510135/163705108-af20c6e8-7fbe-4ccf-8ce8-afb1bfb5c8f0.png">

  <img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/163705170-7ec41d55-d7cc-455c-8490-a7acf150f0b6.png">

  <img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/163705200-95181ebe-030d-404b-94d4-db67100abc5e.png">

  <img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/163705224-08c636b2-c864-4a36-a22d-edadf7718c45.png">

  <img width="665" alt="image" src="https://user-images.githubusercontent.com/75510135/163705236-69e0dd47-f12f-42e6-8035-594710996322.png">

  - Architecture
  <img width="622" alt="image" src="https://user-images.githubusercontent.com/75510135/163705290-9a7fc331-33c2-4e4c-8d74-f4b4386ea4a9.png">

  <img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/163705369-a2d80f7e-c90f-4ec5-b50c-1c7d0ab437e7.png">

  <img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/163705448-d984b439-88c3-4333-a3ce-81f4f0739a5a.png">

  <img width="735" alt="image" src="https://user-images.githubusercontent.com/75510135/163705479-b0914021-5b1d-4140-bc1d-c727e96ba630.png">

  <img width="756" alt="image" src="https://user-images.githubusercontent.com/75510135/163705501-b3e8419b-f3ff-44fe-9afa-dbf558d3cb02.png">

  <img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/163705529-054044dd-72d0-4189-9b71-2802b8963cd6.png">

  <img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/163705577-7beeaf29-87f6-49b2-90f8-971f97a95ad3.png">

  <img width="751" alt="image" src="https://user-images.githubusercontent.com/75510135/163705586-ad6d5a3e-44f6-4435-a3e3-afce7dbffea9.png">

</details>

<details>
<summary>Setup K8s</summary>
<br>

  <img width="658" alt="image" src="https://user-images.githubusercontent.com/75510135/163705649-02547edf-0192-420d-88d7-2f731cd36379.png">

  - after VM setup is done(min 4GB Ram => it directly map to Number of IPAddress for PODS)
  ```
          ********** Install Docker CE Edition **********
        1. Uninstall old versions
        sudo apt-get remove docker docker-engine docker.io containerd runc

        2. Update the apt package index 
        sudo apt-get update

        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release

        3. Add Docker’s official GPG key:
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

        4. Use the following command to set up the stable repository
        echo \
          "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        5. Install Docker Engine
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io

        6. verify Docker version
        docker --version


        ********** Install KubeCtl **********
        1. Download the latest release
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

        2. Install kubectl
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

        3. Test to ensure the version you installed is up-to-date:
        kubectl version --client


        ********** Install MiniKube **********
        1. Download Binay
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        chmod +x minikube-linux-amd64

        2. Install Minikube
        sudo install minikube-linux-amd64 /usr/local/bin/minikube

        3. Verify Installation
        minikube version

        4. Start Kubernetes Cluser
        sudo apt install conntrack
        sudo minikube start --vm-driver=none

        5. Get Cluster Information
        kubectl config view
  ```
</details>

<details>
<summary>Verify & namespace</summary>
<br>

  ```
        ********** Interact Cluster Using KubeCtl **********
      1. Use the kubectl create command to create a Deployment that manages a Pod. The Pod runs a Container based on the provided Docker image.
      kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4

      2. View the Deployment:
      kubectl get deployments

      3. View the Pod:
      kubectl get pods

      4. Expose the Pod to the public internet using the kubectl expose command:
      kubectl expose deployment hello-node --type=LoadBalancer --port=8080

      **The --type=LoadBalancer flag indicates that you want to expose your Service outside of the cluster.

      5. View the Service you created:
      minikube service hello-node

      CleanUP -
      1. Remove service
      kubectl delete service hello-node

      2. Remove Deployments-
      kubectl delete deployment hello-node
  ```
  
  - namespace
  
  <img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/163707088-37fe1f47-4894-4699-a586-41fe748d234d.png">

  <img width="722" alt="image" src="https://user-images.githubusercontent.com/75510135/163706982-21b58bb0-f863-4f87-afa3-71024e96e043.png">

  <img width="724" alt="image" src="https://user-images.githubusercontent.com/75510135/163707024-41e486a0-2109-4842-b070-09cedb5ade2c.png">

  <img width="702" alt="image" src="https://user-images.githubusercontent.com/75510135/163707073-c59a9e7b-c702-4957-883a-ef90ef21bee4.png">

  
</details>


<details>
<summary>Setup via KubeAdm</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/          *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/   *
* https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker              *
*                                                                                                 *
***************************************************************************************************


***************************************************************************************************


0. Provisioning Nodes and Firewalls:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

0a. Kubernetes Cluster Nodes(3):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cloud: Google Compute Engine (GCE)
Master(1): 2 vCPUs - 4GB Ram  
Worker(2): 2 vCPUs - 2GB RAM
OS:     Ubuntu 16.04 or CentOS/RHEL 7


0b. Firewall Rules (Ingress): 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Master Node: 2379,6443,10250,10251,10252 
Worker Node: 10250,30000-32767


0c. NOT Mandatory. For better visibility.
-----------------------------------------
Add below lines to ~/.bashrc
Master Node:
PS1="\e[0;33m[\u@\h \W]\$ \e[m "

Worker Node:
PS1="\e[0;36m[\u@\h \W]\$ \e[m "

***************************************************************************************************


1. PRE-Reqs: Disable Swap | Bridge Traffic (Run it on MASTER & WORKER Nodes):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1a) Disable SWAP:
~~~~~~~~~~~~~~~~~
swapoff -a
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab


1b) Bridge Traffic:
~~~~~~~~~~~~~~~~~~~
lsmod | grep br_netfilter 
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system


***************************************************************************************************


2. Installing Docker (Run it on MASTER & WORKER Nodes):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
apt-get update  
apt-get install -y  apt-transport-https ca-certificates curl software-properties-common gnupg2

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"


2a) Installing Docker:
~~~~~~~~~~~~~~~~~~~~~
apt-get update && sudo apt-get install -y \
  containerd.io=1.2.13-2 \
  docker-ce=5:19.03.11~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.11~3-0~ubuntu-$(lsb_release -cs)


2b) Setting up the Docker "daemon":
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d


2c) Start and enable docker:
~~~~~~~~~~~~~~~~~~~~~~~~~~~
systemctl daemon-reload
systemctl enable docker
systemctl restart docker
systemctl status docker


***************************************************************************************************


3. Installing KUBEADM   - KUBELET -  KUBECTL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

apt-get update && sudo apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF


3a) Installing Kubeadm, Kubelet, Kubectl:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
apt-get update
apt-get install -y kubelet kubeadm kubectl

apt-mark hold kubelet kubeadm kubectl


3b) Start and enable Kubelet:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
systemctl daemon-reload
systemctl enable kubelet
systemctl restart kubelet
systemctl status kubelet


***************************************************************************************************


4. Initializing CONTROL-PLANE (Run it on MASTER Node only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

kubeadm init


***************************************************************************************************


5. Installing POD-NETWORK add-on (Run it on MASTER Node only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5a) "kubectl":
~~~~~~~~~~~~~~
# for kubectl
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config


5b) Installing "Weave CNI" (Pod-Network add-on):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

NOTE: There are multiple CNI Plug-ins available. You can install choice of yours. Incase above commands doesn't work, try checking below link for more info.


***************************************************************************************************


6. Joining Worker Nodes (Run it on WORKER Node only):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Past the Join command from above kubeadm init output
kubeadm join <...>


# Run this command IF you do not have above join command and/or to create NEW one.
kubeadm token create --print-join-command
  ```
</details>

<details>
<summary>Validating</summary>
<br>
  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/          *
* https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/   *
* https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker              *
*                                                                                                 *
***************************************************************************************************

In this demo:
~~~~~~~~~~~~~

a. We will validate the K8s cluster configured using kubeadm in the previous lecture.

b. At the end, we will deploy same deployment and will ensure everything is working as it should be.


***************************************************************************************************

1. Validating CMD Tools:  kubeadm & kubectl:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure kubeadm and kubectl version is as per your cluster setup

1a). Checking "kubeadm" version:
--------------------------------
kubeadm version

1b). Checking "kubectl" version:
--------------------------------
kubectl version


***************************************************************************************************


2. Validating Cluster Nodes:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure all nodes including Master and Worker nodes are "Ready":
---------------------------------------------------------------
kubectl get nodes 
kubectl get nodes –o wide


***************************************************************************************************


3. Validating Kubernetes Components:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure all K8s Master node components are in "Running" status:
--------------------------------------------------------------
kubectl get pods –n kube-system
kubectl get pods –n kube-system -o wide


***************************************************************************************************


4. Validating Services:  Docker & Kubelet:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure Docker and Kubelet Services are "Active(Running) and Enabled on all nodes

4a). Checking Docker Service Status:
------------------------------------
systemctl status docker

4b). Checking Docker Kubelet Status:
------------------------------------
systemctl status kubelet


***************************************************************************************************


5. Deploying Test Deployment:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5a). Deploying the sample "nginx" deployment:
----------------------------------------
kubectl apply -f https://k8s.io/examples/controllers/nginx-deployment.yaml

5b). Validate Deployment:
-------------------------
kubectl get deploy
kubectl get deploy –o wide

5c). Validating Pods are in "Running" status:
---------------------------------------------
kubectl get pods 
kubectl get pods –o wide

5d). Validate containers are running on respective worker nodes:
----------------------------------------------------------------
docker ps

5e). Delete Deployment:
-----------------------
kubectl delete -f https://k8s.io/examples/controllers/nginx-deployment.yaml
  ```
</details>
