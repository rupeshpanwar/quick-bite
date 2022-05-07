<details>
<summary>Introduction</summary>
<br>

  <img width="774" alt="image" src="https://user-images.githubusercontent.com/75510135/167238421-e8c8cc5f-a3c5-4006-b3a4-ca9e34f2739f.png">

  It doesn’t matter where this cluster is or how it was deployed. All that matters is that you have three Linux hosts configured into a Kubernetes cluster with at least one master and two nodes. You’ll also need kubectl installed and configured to talk to the cluster.

Two quick ways to get a Kubernetes cluster include:

    Download and install Docker Desktop to your computer.
    Search “Play with Kubernetes” and get a temporary online playground.

Following the Kubernetes mantra of composable infrastructure, you define Pods in manifest files, POST these to the API server, and let the scheduler instantiate them on the cluster.

  
</details>

<details>
<summary>Pod Manifest Files</summary>
<br>

  <img width="279" alt="image" src="https://user-images.githubusercontent.com/75510135/167238440-35143072-8c36-4fa7-b219-f3e0c37067d1.png">

  For the examples in this chapter we’re going to use the following Pod manifest. It’s called pod.yml.

  <img width="465" alt="image" src="https://user-images.githubusercontent.com/75510135/167238649-2cb509f6-6216-46b3-a0cb-5f05f847b87c.png">

  Let’s step through what the YAML file is describing.

Straight away we can see four top-level resources:

    apiVersion
    kind
    metadata
    spec


  apiVersion#

The .apiVersion field tells you two things – the API group and the API version. The usual format for apiVersion is <api-group>/<version>. However, Pods are defined in a special API group, called the core group, which omits the api-group part. For example, StorageClass objects are defined in v1 of the storage.k8s.io API group and are described in YAML files as storage.k8s.io/v1. However, Pods are in the core API group, which is special, beacuse it omits the API group name, so we describe them in YAML files as just v1.

It’s possible for a resource to be defined in multiple versions of an API group. For example, some-api-group/v1 and some-api-group/v2. In this case, the definition in the newer group will probably include additional features and fields that extend the capabilities of the resource. Think of the apiVersion field as defining the schema – newer is usually better. Interestingly, there may be occasions where you deploy an object via one version in the YAML file, but when you introspect it, the return values show it as another version. For example, you may deploy an object by specifying v1 in the YAML file, but when you run commands against it the returns might show it as v1beta1. This is normal behavior.

Anyway, Pods are defined at the v1 path.

  Kind#

The .kind field tells Kubernetes the type of object being deployed.

So far, you know you’re deploying a Pod object as defined in v1 of the core API group.

  Metadata#

The .metadata section is where you attach a name and labels. These help you identify the object in the cluster, as well as create loose couplings between different objects. You can also define the namespace that an object should be deployed to. Keeping things brief, namespaces are a way to logically divide a cluster into multiple virtual clusters for management purposes. In the real world, it’s highly recommended to use namespaces; however, you should not think of them as strong security boundaries.

The .metadata section of this Pod manifest is naming the Pod “hello-pod” and assigning it two labels. Labels are simple key-value pairs, but they’re insanely powerful. We’ll talk more about labels later as you build your knowledge.

As the .metadata section does not specify a namespace, the Pod will be deployed to the default namespace. It’s not good practice to use the default namespace in the real world, but it’s fine for these examples.

  spec#

The .spec section is where you define the containers that will run in the Pod. This example is deploying a Pod with a single container based on the nigelpoulton/k8sbook:latest image. It’s calling the container hello-ctr and exposing it on port 8080.

If this was a multi-container Pod, you’d define additional containers in the .spec section.

</details>

<details>
<summary>Manifest Files: Empathy as Code</summary>
<br>

  <img width="415" alt="image" src="https://user-images.githubusercontent.com/75510135/167238708-f666f4cc-a7a0-4096-9965-d2e194be5211.png">

  Quick sidestep:

Configuration files, like Kubernetes manifest files, are excellent sources of documentation. As such, they have some secondary benefits. Two of these include:

    Speeding up the onboarding process for new team members
    Bridging the gap between developers and operations

For example, if you need a new team member to understand the basic functions and requirements of an application, get them to read the application’s Kubernetes manifest files.

Also, if your operations teams complain that developers don’t give accurate application requirements and documentation, make your developers use Kubernetes. Kubernetes forces developers to describe their applications through Kubernetes manifests, which can then be used by operations staff to understand how the application works and what it requires from the environment.

These kinds of benefits were described as a form of empathy as code by Nirmal Mehta in his 2017 DockerCon talk entitled “A Strong Belief, Loosely Held: Bringing Empathy to IT”.

I understand that describing YAML files as “empathy as code” sounds a bit extreme. However, there is merit to the concept – they definitely help.

Let’s get back on track.

</details>

<details>
<summary>Deploying Pods from a manifest file</summary>
<br>

  

If you’re following along with the examples, save the manifest file as pod.yml in your current directory and, then, use the following kubectl command to POST the manifest to the API server.
$ kubectl apply -f pod.yml

The output will look something like this:
pod/hello-pod created

Although the Pod is showing as created, it might not be fully deployed and available yet. This is because it takes time to pull the image.

Run a kubectl get pods command to check the status.
$ kubectl get pods

The output will be something like:
NAME        READY    STATUS             RESTARTS   AGE
hello-pod   0/1      ContainerCreating  0          9s

You can see that the container is still being created – probably waiting for the image to be pulled from the Docker Hub.

You can add the --watch flag to the kubectl get pods command so that you can monitor it and see when the status changes to Running.

Congratulations! Your Pod has been scheduled to a healthy node in the cluster and is being monitored by the local kubelet process. The kubelet process is the Kubernetes agent running on the node.

</details>

  
<details>
<summary>Introspecting Running Pods</summary>
<br>

  <img width="339" alt="image" src="https://user-images.githubusercontent.com/75510135/167239141-cfa5b10a-01ff-4e40-9eab-b90dff1d8932.png">

  As good as the kubectl get pods command is, it’s a bit light on detail. Not to worry though; there’s plenty of options for deeper introspection.

First up, the kubectl get command offers a couple of really simple flags that give you more information:

The -o wide flag gives a couple more columns but is still a single line of output.

The -o yaml flag takes things to the next level. This returns a full copy of the Pod manifest from the cluster store. The output is broadly divided into two parts:

    desired state (.spec)
    current observed state (.status)

The following command shows a snipped version of a kubectl get pods -o yaml command.

  $ kubectl get pods hello-pod -o yaml
  The output will be:

  <img width="546" alt="image" src="https://user-images.githubusercontent.com/75510135/167239163-b8517223-c957-4bcf-a630-c590b532a039.png">

  Notice how the output contains more values than you initially set in the 13-line YAML file. Where does this extra information come from?

Two main sources:

    The Kubernetes Pod object has far more settings than we defined in the manifest. Those that are not set explicitly are automatically expanded with default values by Kubernetes.
    When you run a kubectl get pods with -o yaml you get the Pods current observed state as well as its desired state. This observed state is listed in the .status section.


  kubectl describe

Another great Kubernetes introspection command is kubectl describe. This provides a nicely formatted multi-line overview of an object. It even includes some important object lifecycle events. The following command describes the state of the “hello-pod” Pod.
$ kubectl describe pods hello-pod
  
  The output will look like this:

  <img width="625" alt="image" src="https://user-images.githubusercontent.com/75510135/167239186-9b71df70-9580-4da4-975e-106341d851a7.png">

  
  
</details>

  
<details>
<summary>kubectl exec: Running Commands in Pods</summary>
<br>

  <img width="442" alt="image" src="https://user-images.githubusercontent.com/75510135/167239340-d8950674-29ec-4a0b-86b7-8d5b4e2951a9.png">

  Another way to introspect a running Pod is to log in to it or execute commands in it. You can do both of these with the kubectl exec command. The following example shows how to execute a ps aux command in the first container in the hello-pod Pod.
$ kubectl exec hello-pod -- ps aux

The output will be:
PID   USER     TIME   COMMAND
  1   root     0:00   node ./app.js
 11   root     0:00   ps aux

You can also log-in to containers running in Pods using kubectl exec. When you do this, your terminal prompt will change to indicate your session is now running inside of a container in the Pod, and you’ll be able to execute commands from there (as long as the command binaries are installed in the container).

The following kubectl exec command will log in to the first container in the hello-pod Pod.
$ kubectl exec -it hello-pod -- sh

Once inside the container, install the curl utility.
apk add curl

Then run a curl command to transfer data from the process listening on port 8080.
curl localhost:8080
<html><head><title>K8s rocks!</title><link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/></head><body><div class="container"><div class="jumbotron"><h1>Kubernetes Rocks!</h1><p>Check out my K8s Deep Dive course!</p><p> <a class="btn btn-primary" href="https://acloud.guru/learn/kubernetes-deep-dive">The video course</a></p><p></p></div></div></body></html>

The -it flags make the exec session interactive and connect STDIN and STDOUT on your terminal to STDIN and STDOUT inside the first container in the Pod. When the command completes, your shell prompt will change to indicate your shell is now connected to the container.

If you are running multi-container Pods, you will need to pass the kubectl exec command the --container flag and give it the name of the container that you want to create the exec session with. If you do not specify this flag, the command will execute against the first container in the Pod. You can see the ordering and names of containers in a Pod with the kubectl describe pods <pod> command.
kubectl logs#

One other useful command for introspecting Pods is the kubectl logs command. Like other Pod-related commands, if you don’t use --container to specify a container by name, it will execute against the first container in the Pod.

    Make sure you exit the container before using the kubectl log command.

The format of the command is kubectl logs <pod>.

There’s obviously a lot more to Pods than what we’ve covered. However, you’ve learned enough to get started.

Clean up the lab by typing exit to quit your exec session inside the container, then run kubectl delete to delete the Pod.
exit
$ kubectl delete -f pod.yml

The output will be:
pod "hello-pod" deleted
</details>
