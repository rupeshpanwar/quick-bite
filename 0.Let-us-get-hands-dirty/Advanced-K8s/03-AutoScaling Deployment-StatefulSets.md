<details>
<summary>Introduction</summary>
<br>

  Kubernetes system#

By now, you probably understood that one of the critical aspects of a system based on Kubernetes is a high level of dynamism. Almost nothing is static. We define Deployments or StatefulSets, and Kubernetes distributes the Pods across the cluster. In most cases, those Pods are rarely sitting in one place for a long time. Rolling updates result in Pods being re-created and potentially moved to other nodes. Failure of any kind provokes the rescheduling of the affected resources. Many other events cause the Pods to move around. A Kubernetes cluster is like a beehive. It’s full of life, and it’s always in motion.
Dynamic nature of Kubernetes#

The dynamic nature of a Kubernetes cluster is not only due to our (human) actions or rescheduling caused by failures. Autoscaling is to be blamed as well. We should fully embrace Kubernetes’ dynamic nature and move towards autonomous and self-sufficient clusters capable of serving the needs of our applications without (much) human involvement. To accomplish that, we need to provide sufficient information that will allow Kubernetes’ to scale the applications as well as the nodes that constitute the cluster. In this chapter, we’ll focus on the former case. We’ll explore commonly used and basic ways to auto-scale Pods based on memory and CPU consumption. We’ll accomplish that using HorizontalPodAutoscaler.

    HorizontalPodAutoscaler's only function is to automatically scale the number of Pods in a Deployment, a StatefulSet, or a few other types of resources. It accomplishes that by observing CPU and memory consumption of the Pods and acting when they reach pre-defined thresholds.

HorizontalPodAutoscaler is implemented as a Kubernetes API resource and a controller. The resource determines the behavior of the controller. The controller periodically adjusts the number of replicas in a StatefulSet or a Deployment to match the observed average CPU utilization to the target specified by a user.
<img width="572" alt="image" src="https://user-images.githubusercontent.com/75510135/167991660-8b843d95-9acd-496c-8b37-25ad34ef93c6.png">

  We’ll see HorizontalPodAutoscaler in action soon and comment on its specific features through practical examples. But, before we get there, we need a Kubernetes cluster as well as a source of metrics.

In the next lesson, we will create a cluster and get on with the process of Autoscaling Deployments and StatefulSets.

</details>

<details>
<summary>Install Metrics Server</summary>
<br>

  From Heapster to Metrics Server #

The critical element in scaling Pods is the Kubernetes Metrics Server. You might consider yourself a Kubernetes ninja and yet never heard of the Metrics Server. Don’t be ashamed if that’s the case. You’re not the only one.

If you started observing Kubernetes metrics, you might have used Heapster. It’s been around for a long time, and you likely have it running in your cluster, even if you don’t know what it is. Both the Metrics server and Heapster serve the same purpose, with one being deprecated for a while, so let’s clarify things a bit.

Early on, Kubernetes introduced Heapster as a tool that enables Container Cluster Monitoring and Performance Analysis for Kubernetes. It’s been around since Kubernetes version 1.0.6. You can say that Heapster has been part of Kubernetes’ life since its toddler age. It collects and interprets various metrics like resource usage, events, and so on. Heapster has been an integral part of Kubernetes and enabled it to schedule Pods appropriately. Without it, Kubernetes would be blind. It would not know which node has available memory, which Pod is using too much CPU, and so on. But, just as with most other tools that become available early, its design was a “failed experiment”. As Kubernetes continued growing, we (the community around Kubernetes) started realizing that a new, better, and, more importantly, a more extensible design is required. Hence, the Metrics Server was born. Right now, even though Heapster is still in use, it is considered deprecated, even though today the Metrics Server is still in beta state.
What is Metrics Server? #

A simple explanation is that it collects information about used resources (memory and CPU) of nodes and Pods. It does not store metrics, so do not think that you can use it to retrieve historical values and predict tendencies. There are other tools for that, and we’ll explore them later. Instead, Metrics Server's goal is to provide an API that can be used to retrieve current resource usage. We can use that API through kubectl or by sending direct requests with, let’s say, curl. In other words, the Metrics Server collects cluster-wide metrics and allows us to retrieve them through its API. That, by itself, is very powerful, but it is only part of the story.

I already mentioned extensibility. We can extend the Metrics Server to collect metrics from other sources. We’ll get there in due time. For now, we’ll explore what it provides out of the box and how it interacts with some other Kubernetes resources that will help us make our Pods scalable and more resilient.
Installation of Metrics Server #

Helm makes the installation of almost any publicly available software very easy if there is a Chart available. If there isn’t, you might want to consider an alternative since that is a clear indication that the vendor or the community behind it does not believe in Kubernetes. Or, maybe they do not have the skills necessary to develop a Chart. Either way, the best course of action is to run away from it and adopt an alternative. If that’s not an option, develop a Helm Chart yourself. In our case, there won’t be a need for such measures. Metrics Server does have a Helm Chart, and all we need to do is to install it.

    A note to GKE and AKS users#

    Google and Microsoft already ship Metrics Server as part of their managed Kubernetes clusters (GKE and AKS). There is no need to install it, so please skip the commands that follow.

    A note to minikube users#
    Metrics Server is available as one of the plugins. Please execute minikube addons enable metrics-server and kubectl -n kube-system rollout status deployment metrics-server commands instead of those below. 

    A note to Docker For Desktop users#

    Recent updates to the Metrics Server do not work with self-signed certificates by default. Since Docker For Desktop uses such certificates, you’ll need to allow insecure TLS. Please add --set args={"--kubelet-insecure-tls=true"} argument to the helm install command that follows.


  
  <img width="534" alt="image" src="https://user-images.githubusercontent.com/75510135/167994597-fccb603f-b932-42a3-8fb6-63caa7f0961f.png">

  We used Helm to install Metrics Server, and we waited until it rolled out.
Flow of data in Metrics Server #

Metrics Server will periodically fetch metrics from Kubeletes running on the nodes. Those metrics, for now, contain memory and CPU utilization of the Pods and the nodes. Other entities can request data from the Metrics Server through the API Server which has the Master Metrics API. An example of those entities is the Scheduler that, once Metrics Server is installed, uses its data to make decisions. As you will see soon, the usage of the Metrics Server goes beyond the Scheduler but, for now, the explanation should provide an image of the basic flow of data.
  
  <img width="642" alt="image" src="https://user-images.githubusercontent.com/75510135/167994630-de502b8a-b4b3-4d34-a90f-9298fea6231c.png">

  Retrieve the metrics of nodes #

Now we can explore one of the ways we can retrieve the metrics. We’ll start with those related to nodes.

kubectl top nodes

If you were fast, the output should state that metrics are not available yet. That’s normal. It takes a few minutes before the first iteration of metrics retrieval is executed. The exception is GKE and AKS that already come with the Metrics Server baked in.

Fetch some coffee before we repeat the command.

kubectl top nodes

This time, the output is different.

    In this chapter, I’ll show the outputs from Docker For Desktop. Depending on the Kubernetes flavor you’re using, your outputs will be different. Still, the logic is the same and you should not have a problem following along.

My output is as follows.

NAME               CPU(cores) CPU% MEMORY(bytes) MEMORY%
docker-for-desktop 248m       12%  1208Mi        63%

We can see that I have one node called docker-for-desktop. It is using 248 CPU milliseconds. Since the node has two cores, that’s 12% of the total available CPU. Similarly, 1.2GB of RAM is used, which is 63% of the total available memory of 2GB.

</details>


<details>
<summary>Observe Metrics Server Data</summary>
<br>

  Resource usage of the nodes is useful but is not what we’re looking for. In this chapter, we’re focused on auto-scaling Pods. But, before we get there, we should observe how much memory each of our Pods is using. We’ll start with those running in the kube-system Namespace.
Memory consumption of pods running in kube-system #

Execute the following from your command line to see the memory consumption of all the pods running in the Kube-system.
  <img width="924" alt="image" src="https://user-images.githubusercontent.com/75510135/168001866-51c73175-1c3b-4265-90af-17104fe7230d.png">

  <img width="933" alt="image" src="https://user-images.githubusercontent.com/75510135/168001896-555400c2-62e3-4bd1-a945-f712dd0813f3.png">

  <img width="921" alt="image" src="https://user-images.githubusercontent.com/75510135/168001931-62bc0e72-a11a-4068-a510-6f7a315fb74d.png">

  We can see that this time, the output shows each container separately. We can, for example, observe metrics of the kube-dns-* Pod separated into three containers (kubedns, dnsmasq, sidecar).
Flow of data using kubectl top #

When we request metrics through kubectl top, the flow of data is almost the same as when the scheduler makes requests. A request is sent to the API Server (Master Metrics API), which gets data from the Metrics Server which, in turn, was collecting information from Kubeletes running on the nodes of the cluster.
  <img width="646" alt="image" src="https://user-images.githubusercontent.com/75510135/168001981-3acc9253-340f-4b16-ae51-caa47b5e9045.png">

  Scrape the metrics using JSON #

While kubectl top command is useful to observe current metrics, it is pretty useless if we’d like to access them from other tools. After all, the goal is not for us to sit in front of a terminal with watch kubectl top pods command. That would be a waste of our (human) talent. Instead, our goal should be to scrape those metrics from other tools and create alerts and (maybe) dashboards based on both real-time and historical data. For that, we need output in JSON or some other machine-parsable format. Luckily, kubectl allows us to invoke its API directly in raw format and retrieve the same result as if a tool would query it.
  <img width="636" alt="image" src="https://user-images.githubusercontent.com/75510135/168002032-cf2960d4-a701-4dae-ac2f-79faf45c69da.png">

  <img width="911" alt="image" src="https://user-images.githubusercontent.com/75510135/168002059-9ae650e8-b620-4154-a7b9-36fcc13b2bba.png">

  
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
