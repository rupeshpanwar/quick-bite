<details>
<summary>Understanding Deployments</summary>
<br>

 At a high level, you start with the application code. That gets packaged as a container and wrapped in a Pod so it can run on Kubernetes. However, Pods don’t self-heal; they don’t scale, and they don’t allow for easy updates or rollbacks. Deployments do all of these. As a result, you’ll almost always deploy Pods via a Deployment controller.
  
 <img width="487" alt="image" src="https://user-images.githubusercontent.com/75510135/167239904-89fdcfa7-5e81-4358-a2ec-a6c45ea151e3.png">

 <img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/167239911-cb6c0e45-72fd-424c-a4f3-1f404afeb985.png">

  
</details>

<details>
<summary>Understanding ReplicaSets</summary>
<br>

  The last thing to note is that, behind the scenes, Deployments leverage another object called a ReplicaSet. While it’s best practice that you don’t interact directly with ReplicaSets, it’s important to understand the role they play.

Keeping it high level, Deployments use ReplicaSets to provide self-healing and scaling.

The figure below shows the same Pods managed by the same Deployment. However, this time, we’ve added a ReplicaSet object into the relationship and shown which object is responsible for which feature.
  
<img width="545" alt="image" src="https://user-images.githubusercontent.com/75510135/167239938-979ce966-a2e7-46db-88f7-e73e8e4a1df6.png">

  In summary, think of Deployments as managing ReplicaSets, and ReplicaSets as managing Pods. Put them all together, and you’ve got a great way to deploy and manage applications on Kubernetes.
  <img width="468" alt="image" src="https://user-images.githubusercontent.com/75510135/167239950-db935f70-fc62-4f98-9c8a-351c3360aa4f.png">

  <img width="642" alt="image" src="https://user-images.githubusercontent.com/75510135/167240070-1ca8e89d-71ac-4da5-a016-be96ff89f8f3.png">

  <img width="475" alt="image" src="https://user-images.githubusercontent.com/75510135/167240071-81d1695c-8b4a-4b99-b9da-1aefab969aa2.png">

  <img width="484" alt="image" src="https://user-images.githubusercontent.com/75510135/167240084-1269987c-f921-4cde-b4b4-443786aa9f68.png">

  <img width="508" alt="image" src="https://user-images.githubusercontent.com/75510135/167240091-2aff281f-86af-4f3d-98b1-b2eb080f9aa4.png">

  <img width="507" alt="image" src="https://user-images.githubusercontent.com/75510135/167240096-13b6969c-2c15-446e-96b2-84dd58f0a154.png">

  <img width="448" alt="image" src="https://user-images.githubusercontent.com/75510135/167240102-b913806a-c727-49c9-a8a0-9186c7bb1b76.png">

  
</details>

<details>
<summary>Self-Healing and Scalability</summary>
<br>

  <img width="376" alt="image" src="https://user-images.githubusercontent.com/75510135/167240112-ccf363a3-4a5f-462e-b0ce-d42d78476270.png">

  Deployments coordinate with ReplicaSets to manage pods. As we will see in this lesson, this enables high availability and auto-scaling.
It’s all about the state#

Before going any further, it’s critical to understand three concepts that are fundamental to everything about Kubernetes:

    Desired state
    Current state (sometimes called actual state or observed state)
    Declarative model

Desired state is what you want. Current state is what you have. If the two match, everybody’s happy.

The declarative model is a way of telling Kubernetes what your desired state is, without having to get into the detail about how to implement it. You leave the how up to Kubernetes.

  The declarative model

There are two competing models. The declarative model and the imperative model.

 <img width="633" alt="image" src="https://user-images.githubusercontent.com/75510135/167240245-5d41b65f-29ae-405c-ac21-d4bd711da144.png">

  Here are two extremely simple analogies that might help:

    Declarative: I need a chocolate cake that will feed 10 people.
    Imperative: Drive to the store. Buy eggs, milk, flour, cocoa powder. Drive home. Turn on the oven. Mix the ingredients. Place in a baking tray. Place the tray in the oven for 30 minutes. Remove the tray from the oven and turn the oven off. Add icing. Leave to stand.

The declarative model is stating what you want (chocolate cake for 10). The imperative model is a long list of steps required to make a chocolate cake for 10.

Let’s look at a more concrete example.

Assume you’ve got an application with two services – front-end and back-end. You’ve built container images so that you can have a Pod for the front-end service and a separate Pod for the back-end service. To meet expected demand, you always need 5 instances of the front-end Pod and 2 instances of the back-end Pod.

Taking the declarative approach, you write a configuration file that tells Kubernetes what you want your application to look like. For example, I want 5 replicas of the front-end Pod all listening externally on port 80 please. And I also want 2 back-end Pods listening internally on port 27017. That’s the desired state. Obviously, the YAML format of the config file will be different, but you get the picture.

Once you’ve described the desired state, you give the config file to Kubernetes and sit back while Kubernetes does the hard work of implementing it.

But things don’t stop there. Kubernetes implements watch loops that are constantly checking that you’ve got what you asked for – does the current state match the desired state.

Believe me, when I tell you, it’s a beautiful thing.

The opposite of the declarative model is the imperative model. In the imperative model, there’s no concept of what you actually want. At least there’s no record of what you want, all you get is a list of instructions.

To make things worse, imperative instructions might have multiple variations. For example, the commands to start containerd containers are different from the commands to start gVisor containers. This ends up being more work that is prone to more errors, and, because it’s not declaring a desired state, there’s no self-healing.

Believe me, when I tell you, this isn’t so beautiful.

Kubernetes supports both models but strongly prefers the declarative model.

</details>

<details>
<summary>Reconciliation loops</summary>
<br>

  Fundamental to the desired state is the concept of background reconciliation loops (a.k.a. control loops).

For example, ReplicaSets implement a background reconciliation loop that is constantly checking whether the right number of Pod replicas are present on the cluster.

If there aren’t enough, it adds more. If there are too many, it terminates some. To be crystal clear, Kubernetes is constantly making sure that the current state matches the desired state.

If they don’t match – maybe the desired state is 10 replicas, but only 8 are running – Kubernetes declares a red alert condition, orders the control plane to battle-stations, and brings up two more replicas. And the best part, it does all of this without calling you at 04:20 am!

But it’s not just failure scenarios. These very same reconciliation loops enable scaling.

For example, if you POST an updated config that changes the replica count from 3 to 5, the new value of 5 will be registered as the application’s new desired state. The next time the ReplicaSet reconciliation loop runs, it will notice the discrepancy and follow the same process – sounding the klaxon horn for red alert and spinning up two more replicas.
</details>

<details>
<summary>Rolling Updates With Deployments</summary>
<br>

  <img width="409" alt="image" src="https://user-images.githubusercontent.com/75510135/167240342-8e8cf581-b8b8-49b9-8f13-fa9c80370359.png">

  Rolling update#

As well as self-healing and scaling, Deployments give us zero-downtime rolling updates.

As previously mentioned, Deployments use ReplicaSets for some of the background legwork. In fact, every time you create a Deployment, you automatically get a ReplicaSet that manages the Deployment’s Pods.

    Note: Best practice states that you should not manage ReplicaSets directly. You should perform all actions against the Deployment object and leave the Deployment to manage ReplicaSets.

It works like this: You design applications with each discrete service as a Pod. For convenience – self-healing, scaling, rolling updates, etc. – you wrap Pods in Deployments. This means creating a YAML configuration file describing all of the following:

    How many Pod replicas
    What image to use for the Pod’s container(s)
    What network ports to use
    Details about how to perform rolling updates

You POST the YAML file to the API server and Kubernetes does the rest.

Once everything is up and running, Kubernetes sets up watch loops to make sure the observed state matches the desired state.

All good so far.

Now, assume you’ve experienced a bug, and you need to deploy an updated image that implements a fix. To do this, you update the same Deployment YAML file with the new image version and re-POST it to the API server. This registers a new desired state on the cluster, requesting the same number of Pods, but all running the new version of the image. To make this happen, Kubernetes creates a new ReplicaSet for the Pods with the new image. You now have two ReplicaSets – the original one for the Pods with the old version of the image and a new one for the Pods with the updated version. Each time Kubernetes increases the number of Pods in the new ReplicaSet (with the new version of the image), it decreases the number of Pods in the old ReplicaSet (with the old version of the image). Net result: you get a smooth rolling update with zero downtime. And you can rinse and repeat the process for future updates – just keep updating that manifest file (which should be stored in a version control system).
</details>

<details>
<summary>Slides show a Deployment </summary>
<br>

  The slides below show a Deployment that has been updated once. The initial deployment created the ReplicaSet on the left, and the update created the ReplicaSet on the right. You can see that the ReplicaSet for the initial deployment has been wound down and no longer has any Pod replicas. The ReplicaSet associated with the update is active and owns all of the Pods.
  <img width="641" alt="image" src="https://user-images.githubusercontent.com/75510135/167240588-befe67be-ea0a-41cf-8212-2024055a256a.png">

  <img width="508" alt="image" src="https://user-images.githubusercontent.com/75510135/167240593-c9af46e1-e9b7-46b6-8cb6-8c88dfbab984.png">

  <img width="621" alt="image" src="https://user-images.githubusercontent.com/75510135/167240603-65e3b363-bbb5-4b3b-ac31-a3e46ae457be.png">

  <img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/167240610-529e575f-451f-4603-9d6d-da35e46c2ea6.png">
It’s important to understand that the old ReplicaSet still has its entire configuration, including the older version of the image it used. This will be important in the next section.
  
</details>

<details>
<summary>Rollbacks</summary>
<br>

  As we’ve seen in the slides above, older ReplicaSets are wound down and no longer manage any Pods. However, they still exist with their full configuration. This makes them a great option for reverting to previous versions.

The process of rolling back is essentially the opposite of a rolling update – wind one of the old ReplicaSets up and wind the current one down. Simple.

The slides below show the same app rolled back to the initial revision.
  <img width="354" alt="image" src="https://user-images.githubusercontent.com/75510135/167240636-ed0266b9-0983-434f-8ff3-0877a5314c53.png">

  <img width="466" alt="image" src="https://user-images.githubusercontent.com/75510135/167240644-dd95b8c0-7740-485f-9f3b-5ee2982199c6.png">

  <img width="610" alt="image" src="https://user-images.githubusercontent.com/75510135/167240649-ca003061-b601-4e29-952b-39fe40f5dc0c.png">

  <img width="618" alt="image" src="https://user-images.githubusercontent.com/75510135/167240655-67073bdc-c13e-4423-ba56-c39129427eea.png">

  That’s not the end though. There’s built-in intelligence that lets us say things like, “Wait X number of seconds after each Pod comes up before proceeding to the next Pod.”

There’s also startup probes, readiness probes, and liveness probes that can check the health and status of Pods. All in all, Deployments are excellent for performing rolling updates and versioned rollbacks.

  
</details>

<details>
<summary>How to Create a Deployment</summary>
<br>

  You can skip the usage of a YAML file and alternatively, use the kubectl run command, but you shouldn’t. The right way is the declarative way.

The following YAML snippet is the Deployment manifest file that you’ll use. The examples assume you’ve got a copy in your system’s PATH and is called deploy.yml.

  <img width="557" alt="image" src="https://user-images.githubusercontent.com/75510135/167240713-795d7965-6418-49d2-9198-51c40502c264.png">

  Let’s step through the config and explain some of the important parts.

Right at the very top, you specify the API version to use. Assuming that you’re using an up-to-date version of Kubernetes, Deployment objects are in the apps/v1 API group.

Next, the .kind field tells Kubernetes you’re defining a Deployment object.

The .metadata section is where we give the Deployment a name and labels.

The .spec section is where most of the action happens. Anything directly below .spec relates to the Pod. Anything nested below .spec.template relates to the Pod template that the Deployment will manage. In this example, the Pod template defines a single container.

.spec.replicas tells Kubernetes how many Pod replicas to deploy. spec.selector is a list of labels that Pods must have in order for the Deployment to manage them. And .spec.strategy tells Kubernetes how to perform updates to the Pods managed by the Deployment.

Use kubectl apply to implement it on the cluster.

    Note: kubectl apply POSTs the YAML file to the Kubernetes API server.

  $ kubectl apply -f deploy.yml
  
  You will get the output:
  deployment.apps/hello-deploy created
  
  The Deployment is now instantiated on the cluster.
  
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
