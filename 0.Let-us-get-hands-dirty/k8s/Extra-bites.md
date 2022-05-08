<details>
<summary>Service Meshes</summary>
<br>

  
Cloud-native applications running on Kubernetes can be complex beasts and present challenges that didn’t previously exist.

Consider the following.

We used to build and deploy complex applications as a single large monolith. This meant that most of the application components and logic shipped as a single program, and all communication between the different components was internal over sockets and named pipes. Cloud-native applications are different, as they break application components and logic into many individual components (microservices) that have to communicate over the network.

With this in mind, we have several new and important considerations:

    How do we secure the traffic between all of the application microservices?
    How to we get telemetry and visibility?
    How do we effectively control traffic?

Kubernetes is not designed or equipped to handle these but service meshes are!

At the highest level, a service mesh is a form of an intelligent network that can do things like:

    Automatically encrypt traffic between microservices
    Provide extensive application network telemetry and observability
    Provide advanced traffic control, such as, circuit breaking, latency-aware loa balancing, fault injection, retries, etc.

There are many service mesh implementations, but the two leading technologies are Istio and Linkerd. They both build on top of something called an envoy proxy and are implemented in a similar way. However, they have slightly different scopes. Istio has a broader scope, at the expense of complexity. Linkerd has a smaller scope and is arguably easier to implement and run. Both are popular, but, at the time of writing, Istio seems to be gaining more community support and uptake.

Both are implemented as Kubernetes-native applications and run their own control plane on your Kubernetes cluster.

Once deployed to your cluster, they are injected into your applications as sidecar containers. This involves injecting a service mesh container into any application Pod that you want to be “on the service mesh”.

The service mesh sidecar container is based on the envoy proxy and sets up rules to intercept all network traffic entering and exiting the Pod. This allows the service mesh sidecar container to do things such as:

    Automatically encrypt all Pod-to-Pod communication
    Send detailed telemetry to a central location
    Implement circuit breaking, A/B loading, fault injection, etc.

There can be a small performance overhead, but the cost is usually worth it.

The way a service mesh sidecar container is injected into Pods is via an admission controller. Admission controllers inspect all objects being deployed to the cluster and can implement policies such as injecting service mesh sidecars. A simple example might be a policy that injects a service mesh sidecar into every Pod being deployed to the production Namespace.

Service mesh technologies are relatively new and can sometimes be hard to configure and work with. However, many of the public clouds that offer hosted Kubernetes services allow you to deploy a service mesh as part of the hosted service. These options give you a very simple way to deploy a service mesh, but they only work on the hosted platform.

Considering the benefits, a service mesh should be a top priority when deploying important production business applications. Nobody wants to be responsible for insecure applications with limited visibility into the network traffic flow and limited options for influencing traffic.


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

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
