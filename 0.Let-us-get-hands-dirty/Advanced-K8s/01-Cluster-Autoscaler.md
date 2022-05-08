<details>
<summary>Introduction</summary>
<br>

  <img width="439" alt="image" src="https://user-images.githubusercontent.com/75510135/167290391-2c2155a6-32ad-43fc-96f4-8ec18c3be977.png">

  <img width="944" alt="image" src="https://user-images.githubusercontent.com/75510135/167290499-f0a2258e-c81a-4d44-bc83-96ee2c547262.png">

  <img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/167290512-395a0175-61fb-41ad-aa3c-06a1683bff79.png">

  
</details>

<details>
<summary>Create a Cluster</summary>
<br>

  <img width="568" alt="image" src="https://user-images.githubusercontent.com/75510135/167294344-51d68070-d696-406e-98ee-50ea4f8ae38c.png">

  Pulling the code #

We’ll continue using definitions from the vfarcic/k8s-specs repository. To be on the safe side, we’ll pull the latest version first.

    🔍 All the commands from this chapter are available in the 02-ca.sh Gist.


  - https://gist.github.com/37fd39d50fdee43a098575389fb7e435
  - https://github.com/vfarcic/k8s-specs
  
  - connect to cluster
  > gcloud container clusters get-credentials devops25 --zone asia-east1-a --project united-option-342608
  
  - on gke
  ```
  ######################
# Create The Cluster #
######################

gcloud auth login

REGION=asia-east1-a

MACHINE_TYPE=n1-standard-1

gcloud container clusters \
    create devops25 \
    --region $REGION \
    --machine-type $MACHINE_TYPE \
    --enable-autoscaling \
    --num-nodes 1 \
    --max-nodes 3 \
    --min-nodes 1

kubectl create clusterrolebinding \
    cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $(gcloud config get-value account)

#######################
# Destroy the cluster #
#######################

gcloud container clusters \
    delete devops25 \
    --region $REGION \
    --quiet
  ```
  
  - on eks
  ```
  # Source: https://gist.github.com/f96aaf28940529b2e88c901c29faebe1

######################
# Create The Cluster #
######################

# Make sure that you're using eksctl v0.1.5+.

# Follow the instructions from https://github.com/weaveworks/eksctl to intall eksctl.

export AWS_ACCESS_KEY_ID=[...] # Replace [...] with AWS access key ID

export AWS_SECRET_ACCESS_KEY=[...] # Replace [...] with AWS secret access key

export AWS_DEFAULT_REGION=us-west-2

export NAME=devops25

mkdir -p cluster

eksctl create cluster \
    -n $NAME \
    -r $AWS_DEFAULT_REGION \
    --kubeconfig cluster/kubecfg-eks \
    --node-type t2.small \
    --nodes-max 9 \
    --nodes-min 3 \
    --asg-access \
    --managed

export KUBECONFIG=$PWD/cluster/kubecfg-eks

##################
# Metrics Server #
##################

kubectl create namespace metrics

helm install metrics-server \
    stable/metrics-server \
    --version 2.0.2 \
    --namespace metrics

kubectl -n metrics \
    rollout status \
    deployment metrics-server

#######################
# Destroy the cluster #
#######################

IAM_ROLE=$(aws iam list-roles \
    | jq -r ".Roles[] \
    | select(.RoleName \
    | startswith(\"eksctl-$NAME-nodegroup\")) \
    .RoleName")

echo $IAM_ROLE

aws iam delete-role-policy \
    --role-name $IAM_ROLE \
    --policy-name $NAME-AutoScaling

eksctl delete cluster -n $NAME
  ```
  
  - on aks
  ```
  # Source: https://gist.github.com/473ae1856998bdbe9a8adc9ccf63b545

######################
# Create The Cluster #
######################

az login

az provider register -n Microsoft.Network

az provider register -n Microsoft.Storage

az provider register -n Microsoft.Compute

az provider register -n Microsoft.ContainerService

az group create \
    --name devops25-group \
    --location eastus

export VM_SIZE=Standard_B2s

export NAME=devops25

rm -f $PWD/cluster/kubecfg-aks

az aks create \
    --resource-group $NAME-group \
    --name $NAME-cluster \
    --node-count 3 \
    --node-vm-size $VM_SIZE \
    --generate-ssh-keys

az aks get-credentials \
    --resource-group devops25-group \
    --name devops25-cluster \
    -f cluster/kubecfg-aks

export KUBECONFIG=$PWD/cluster/kubecfg-aks

#######################
# Destroy the cluster #
#######################

az group delete \
    --name devops25-group \
    --yes
  ```
  
  Gists and specifications #

Choose the flavor you want and run the commands from its .sh file to create the cluster and the required specifications needed in this chapter.

    NOTE: In the end, you will see a command to DELETE the cluster too. Don’t execute that command. Use the DELETE command only when you need to delete the cluster, preferably at the end of the chapter.

GKE

    gke-scale.sh: GKE with 3 n1-standard-1 worker nodes, and with the --enable-autoscaling argument


  
</details>


<details>
<summary>Set up Cluster Autoscaler</summary>
<br>

  <img width="568" alt="image" src="https://user-images.githubusercontent.com/75510135/167294899-95bd3f66-cbba-4cc7-a9d4-d03a8a2ea95a.png">

  <img width="930" alt="image" src="https://user-images.githubusercontent.com/75510135/167295029-6cda7945-f6ab-4d76-8e0b-b6a6a2ce0f47.png">

  <img width="927" alt="image" src="https://user-images.githubusercontent.com/75510135/167295041-a9f2ce43-9e76-4261-b06e-7f7eb9d694e0.png">

  <img width="890" alt="image" src="https://user-images.githubusercontent.com/75510135/167295059-00057ece-ba23-4cf2-8fd1-ee6cb9c8e9a9.png">

  <img width="918" alt="image" src="https://user-images.githubusercontent.com/75510135/167295073-f265badb-f07c-4ff6-861b-acc6d1578e64.png">

  <img width="906" alt="image" src="https://user-images.githubusercontent.com/75510135/167295077-c0f97aa3-6a8f-4bb9-8aa5-30731403e93a.png">

  <img width="913" alt="image" src="https://user-images.githubusercontent.com/75510135/167295087-cc3b9d38-f608-4328-b1a3-303a158550b7.png">

  
</details>

<details>
<summary>Scale up the Cluster</summary>
<br>
  
<img width="573" alt="image" src="https://user-images.githubusercontent.com/75510135/167295123-eefa942a-5b67-400e-aad5-f8ca2846a69a.png">
  
  Scale up the nodes #

The objective is to scale the nodes of our cluster to meet the demand of our Pods. We want not only to increase the number of worker nodes when we need additional capacity, but also to remove them when they are underused. For now, we’ll focus on the former, and explore the latter afterward.

Let’s start by taking a look at how many nodes we have in the cluster.
  > kubectl get nodes
  <img width="884" alt="image" src="https://user-images.githubusercontent.com/75510135/167295459-531d3a4a-5a98-45cb-8045-ca45865179a7.png">

  <img width="879" alt="image" src="https://user-images.githubusercontent.com/75510135/167295538-654b1cd6-b96b-4dc3-a887-7d3bd2d05cd8.png">

  ```
  apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: api
  namespace: go-demo-5
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api
  minReplicas: 15
  maxReplicas: 30
  metrics:
  - type: Resource
    resource:
      name: cpu
      targetAverageUtilization: 80
  - type: Resource
    resource:
      name: memory
      targetAverageUtilization: 80
  ```
  
  <img width="901" alt="image" src="https://user-images.githubusercontent.com/75510135/167295608-f28071c2-c3eb-4f99-9faf-0d1218e61b08.png">

  <img width="939" alt="image" src="https://user-images.githubusercontent.com/75510135/167295615-14547842-746c-4112-bde9-411f1b92ed18.png">

  <img width="866" alt="image" src="https://user-images.githubusercontent.com/75510135/167295623-240730f0-7743-455d-8bd5-29a89d40dad2.png">

  <img width="898" alt="image" src="https://user-images.githubusercontent.com/75510135/167295630-2a29814b-cffb-4996-9daf-c9a3fef7473d.png">

  <img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/167295637-e4c517d2-a269-49e6-a944-b1a2d7d39a80.png">

  <img width="903" alt="image" src="https://user-images.githubusercontent.com/75510135/167295648-973449c6-aa1e-48be-abc1-e75745ef6c83.png">

  <img width="903" alt="image" src="https://user-images.githubusercontent.com/75510135/167295658-7aec77e5-e7b4-42fa-bbbe-101397daefe2.png">

  <img width="715" alt="image" src="https://user-images.githubusercontent.com/75510135/167296031-aa60e54e-ae3d-4b99-ac64-3c0cbf673488.png">

  <img width="995" alt="image" src="https://user-images.githubusercontent.com/75510135/167296048-51624f97-674b-4fbc-8f5a-32f5234cbf1a.png">

</details>

<details>
<summary>Scale down the Cluster</summary>
<br>

  <img width="457" alt="image" src="https://user-images.githubusercontent.com/75510135/167296074-367a2738-06fa-458d-ae62-ebafdca80651.png">

  <img width="1017" alt="image" src="https://user-images.githubusercontent.com/75510135/167296582-bb3e314d-0dbf-4d30-84a9-f967c5402389.png">

  <img width="1032" alt="image" src="https://user-images.githubusercontent.com/75510135/167296597-fbce1f45-7991-48f8-9ec4-0acb841c9170.png">

  <img width="1008" alt="image" src="https://user-images.githubusercontent.com/75510135/167296610-fe9e478f-d197-4524-b424-dd72cdb81704.png">

  <img width="988" alt="image" src="https://user-images.githubusercontent.com/75510135/167296619-20f9a260-cb5c-41ad-a439-5e6dec9d1ad9.png">

  <img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/167296633-9c971784-a426-40eb-98f3-115180f7e7af.png">

  <img width="822" alt="image" src="https://user-images.githubusercontent.com/75510135/167296644-6d965879-913b-4b01-a61d-69f6f1f91cf1.png">

  <img width="902" alt="image" src="https://user-images.githubusercontent.com/75510135/167296655-3ad81118-b8fd-4e2f-a899-ce1f2ca1c8c2.png">

  <img width="930" alt="image" src="https://user-images.githubusercontent.com/75510135/167296662-adace6ed-63cf-4af4-bb89-e9ede0ae5a11.png">

  <img width="954" alt="image" src="https://user-images.githubusercontent.com/75510135/167296681-85f1d30f-b03c-4503-95de-a80510178a01.png">

  
</details>

<details>
<summary>Can We Scale up Too Much or De-scale to Zero Nodes?</summary>
<br>

  Scale or descale without threshold #

If we let Cluster Autoscaler do its “magic” without defining any thresholds, our cluster or our wallet might be at risk.

We might, for example, misconfigure HPA and end up scaling Deployments or StatefulSets to a huge number of replicas. As a result, Cluster Autoscaler might add too many nodes to the cluster. As a result, we could end up paying for hundreds of nodes, even though we need much less. Luckily, AWS, Azure, and GCP limit how many nodes we can have so we cannot scale to infinity. Nevertheless, we should not allow Cluster Autoscaler to go over some limits.

Similarly, there is a danger that Cluster Autoscaler will scale down to too few nodes. Having zero nodes is almost impossible since that would mean that we have no Pods in the cluster. Still, we should maintain a healthy minimum of nodes, even if that means sometimes being underutilized.
Minimum number of nodes #

A reasonable minimum of nodes is three. That way, we have a worker node in each zone (datacenter) of the region. As you already know, Kubernetes requires three zones with master nodes to maintain quorum. In some cases, especially on-prem, we might have only one geographically collocated datacenter with low latency. In that case, one zone (datacenter) is better than none. But, in the case of Cloud providers, three zones are the recommended distribution, and having a minimum of one worker node in each makes sense. That is especially true if we use block storage.

By its nature, block storage (e.g., EBS in AWS, Persistent Disk in GCP, and Block Blob in Azure) cannot move from one zone to another. That means that we have to have a worker node in each zone so that there is (most likely) always a place for it in the same zone as the storage. Of course, we might not use block storage in which case this argument is unfounded.
Maximum number of nodes #

How about the maximum number of worker nodes? Well, that differs from one use case to another. You do not have to stick with the same maximum for all eternity. It can change over time.

As a rule of thumb, I’d recommend having a maximum double from the actual number of nodes. However, don’t take that rule seriously. It truly depends on the size of your cluster. If you have only three worker nodes, your maximum size might be nine (three times bigger). On the other hand, if you have hundreds or even thousands of nodes, it wouldn’t make sense to double that number as the maximum. That would be too much. Just make sure that the maximum number of nodes reflects the potential increase in demand.

In any case, I’m sure that you’ll figure out what should be your minimum and your maximum number of worker nodes. If you make a mistake, you can correct it later. What matters more is how to define those thresholds.
Defining thresholds #

Luckily, setting up min and max values is easy in EKS, GKE, and AKS. For EKS, if you’re using eksctl to create the cluster, all we have to do is add --nodes-min and --nodes-max arguments to the eksctl create cluster command. GKE follows a similar logic with --min-nodes and --max-nodes arguments of the gcloud container clusters create command. If one of the two is your preference, you already used those arguments if you followed the Gists. Even if you forget to specify them, you can always modify Autoscaling Groups (AWS) or Instance Groups (GCP) since that’s where the limits are actually applied.

Azure takes a bit different approach. We define its limits directly in the cluster-autoscaler Deployment, and we can change them just by applying a new definition
  
</details>

<details>
<summary>Cluster Autoscaler Compared in GKE, EKS, and AKS</summary>
<br>

  Kubernetes’s service providers #

Cluster Autoscaler is a prime example of the differences between different managed Kubernetes offerings. We’ll use it to compare the three major Kubernetes-as-a-Service providers.

    🔍 I’ll limit the comparison between the vendors only to the topics related to Cluster Autoscaling.

GKE service provider #

GKE is a no-brainer for those who can use Google to host their clusters. It is the most mature and feature-rich platform. They started Google Kubernetes Engine (GKE) long before anyone else. When we combine their headstart with the fact that they are the major contributor to Kubernetes and hence have the most experience, it comes as no surprise that their offering is way above others.
Setting up Cluster Autoscaler in GKE #

When using GKE, everything is baked into the cluster. That includes Cluster Autoscaler. We do not have to execute any additional commands. It simply works out of the box. Our cluster scales up and down without the need for our involvement, as long as we specify the --enable-autoscaling argument when creating the cluster. On top of that, GKE brings up new nodes and joins them to the cluster faster than the other providers. If there is a need to expand the cluster, new nodes are added within a minute.

There are many other reasons I would recommend GKE, but that’s not the subject right now. Still, Cluster Autoscaling alone should be proof that GKE is the solution others are trying to follow.
EKS service provider #

Amazon’s Elastic Container Service for Kubernetes (EKS) is somewhere in the middle. Cluster Autoscaling works, but it’s not baked in. It’s as if Amazon did not think that scaling clusters is important and left it as an optional add-on.

EKS installation is too complicated (when compared to GKE and AKS) but thanks to eksctl from the folks from WeaveWorks, we have that, more or less, solved. Still, there is a lot left to be desired from eksctl. For example, we cannot use it to upgrade our clusters.

The reason I’m mentioning eksctl in the context of auto-scaling lies in the Cluster Autoscaler setup.
Setting up Cluster Autoscaler in EKS #

I cannot say that setting up Cluster Autoscaler in EKS is hard. It’s not. And yet, it’s not as simple as it should be. We have to tag the Autoscaling Group, put additional privileges to the role, and install Cluster Autoscaler. That’s not much. Still, those steps are much more complicated than they should be. We can compare it with GKE. Google understands that auto-scaling Kubernetes clusters is a must and it provides that with a single argument (or a checkbox if you prefer UIs). AWS, on the other hand, did not deem auto-scaling important enough to give us that much simplicity. On top of the unnecessary setup in EKS, the fact is that AWS added the internal pieces required for scaling only recently. Metrics Server can be used only since September 2018.

My suspicion is that AWS does not have the interest to make EKS great by itself and that they are saving the improvements for Fargate. If that’s the case (we’ll find that out soon), I’d characterize it as “sneaky business”. Kubernetes has all the tools required for scaling Pod and nodes and they are designed to be extensible. The choice not to include Cluster Autoscaler as an integral part of their managed Kubernetes service is a big minus.
AKS service provider #

What can I say about Azure Kubernetes Service (AKS)? I admire the improvements Microsoft made in Azure as well as their contributions to Kubernetes. They do recognize the need for a good managed Kubernetes offering. Yet, Cluster Autoscaler is still in beta. Sometimes, it works; more often than not, it doesn’t. Even when it does work as it should, it is slow. Waiting for a new node to join the cluster is an exercise in patience.
Setting up Cluster Autoscaler in AKS #

The steps required to install Cluster Autoscaler in AKS are sort of ridiculous. We are required to define a myriad of arguments that were supposed to be already available inside the cluster. It should know what is the name of the cluster, what is the resource group, and so on and so forth. And yet, it doesn’t. At least, that’s the case at the time of this writing. I hope that both the process and the experience will improve over time. For now, from the perspective of auto-scaling, AKS is at the tail of the pack.
Conclusion #

You might argue that the complexity of the setup does not really matter. You’d be right. What matters is how reliable Cluster Autoscaling is and how fast it adds new nodes to the cluster. Still, the situation is the same. GKE leads in reliability and speed. EKS is the close second, while AKS is trailing behind.

  
</details>

