# Topics covered
1. Service
2. 
# LAB: Creating a Service and exposing it with NodePort

Exposing Application with a Service

Types of Services:

    ClusterIP

    NodePort

    LoadBalancer

    ExternalName

kubernetes service

    kubectl get pods
    kubectl get svc

Sample Output:

    NAME                READY     STATUS    RESTARTS   AGE
    voting-appp-j52x   1/1       Running   0          2m
    voting-appp-pr2xz   1/1       Running   0          m
    voting-appp-qpxbm   1/1       Running   0          5m

Setting up monitoring

If you are not running a monitoring screen, start it in a new terminal with the following command.

    watch -n 1 kubectl get  pod,deploy,rs,svc

Writing Service Spec

Lets start writing the meta information for service.

Filename: vote-svc.yaml

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: vote
      labels:
        role: vote
    spec:

And then add the spec to it. Refer to Service (v1 core) api at this page https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.10/

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: vote
      labels:
        role: vote
    spec:
      selector:
        role: vote
      ports:
        - port: 80
          targetPort: 80
          nodePort: 30000
      type: NodePort
     

Save the file.

Now to create a service:

    kubectl apply -f vote-svc.yaml --dry-run
    kubectl apply -f vote-svc.yaml
    kubectl get svc

Now to check which port the pod is connected

    kubectl describe service vote

Check for the Nodeport here

Sample Output

    Name:                     vote
    Namespace:                instavote
    Labels:                   role=svc
                              tier=front
    Annotations:              kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"role":"svc","tier":"front"},"name":"vote","namespace":"instavote"},"spec":{...
    Selector:                 app=vote
    Type:                     NodePort
    IP:                       10.108.108.157
    Port:                     <unset>  80/TCP
    TargetPort:               80/TCP
    NodePort:                 <unset>  31429/TCP
    Endpoints:                10.38.0.4:80,10.38.0.5:80,10.38.0.6:80 + 2 more...
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>

Go to browser and check hostip:NodePort

Here the node port is 31429.

Sample output will be:

# LAB: Exposing Sevice with ExternalIPs
Exposing the app with ExternalIP


    spec:
      selector:
        role: vote
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      type: NodePort
      externalIPs:
        - xx.xx.xx.xx
        - yy.yy.yy.yy

Where

replace xx.xx.xx.xx and yy.yy.yy.yy with IP addresses of the nodes on two of the kubernetes hosts.

apply

    kubectl  get svc
    kubectl apply -f vote-svc.yaml
    kubectl  get svc
    kubectl describe svc vote

[sample output]

    NAME      TYPE       CLUSTER-IP      EXTERNAL-IP                    PORT(S)        AGE
    vote      NodePort   10.107.71.204   206.189.150.190,159.65.8.227   80:30000/TCP   11m

where,

EXTERNAL-IP column shows which IPs the application is been exposed on. You could go to http://: to access this application.
e.g. http://206.189.150.190:80 where you should replace 206.189.150.190 with the actual IP address of the node that you exposed this on.

# LAB: Intetnal Service Discovery with ClusterIP
Internal Service Discovery

    Visit the vote app from browser

    Attemp to vote by clicking on one of the options

observe what happens. Does it go through?

Debugging,

    kubectl get pod
    kubectl exec vote-xxxx ping redis
     

[replace xxxx with the actual pod id of one of the vote pods ]

keep the above command on a watch. You should create a new terminal to run the watch command.

e.g.

    watch  kubectl exec vote-kvc7j ping redis

where, vote-kvc7j is one of the vote pods that I am running. Replace this with the actual pod id.

Now create redis service

    kubectl apply -f redis-svc.yaml
     
    kubectl get svc
     
    kubectl describe svc redis

Watch the ping and observe if its able to resolve redis by hostname and its pointing to an IP address.

e.g.

    PING redis (10.102.77.6): 56 data bytes

where 10.102.77.6 is the ClusterIP assigned to the service.

What happened here?

    Service redis was created with a ClusterIP e.g. 10.102.77.6

    A DNS entry was created for this service. The fqdn of the service is redis.instavote.svc.cluster.local and it takes the form of my-svc.my-namespace.svc.cluster.local

    Each pod points to internal DNS server running in the cluster. You could see the details of this by running the following commands

    kubectl exec vote-xxxx cat /etc/resolv.conf

[replace vote-xxxx with actual pod id]

[sample output]

    nameserver 10.96.0.10
    search instavote.svc.cluster.local svc.cluster.local cluster.local
    options ndots:5

where 10.96.0.10 is the ClusterIP assigned to the DNS service. You could co relate that with,

    kubectl get svc -n kube-system
     
     
    NAME                   TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)         AGE
    kube-dns               ClusterIP   10.96.0.10     <none>        53/UDP,53/TCP   h
    kubernetes-dashboard   NodePort    10.104.42.73   <none>        80:31000/TCP    3m
     

where, 10.96.0.10 is the ClusterIP assigned to kube-dns and matches the configuration in /etc/resolv.conf above.
Creating Endpoints for Redis

Service is been created, but you still need to launch the actual pods running redisapplication.

Create the endpoints now,

    kubectl apply -f redis-deploy.yaml
    kubectl describe svc redis
     

[sample output]

    Name:              redis
    Namespace:         instavote
    Labels:            role=redis
                       tier=back
    Annotations:       kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"role":"redis","tier":"back"},"name":"redis","namespace":"instavote"},"spec"...
    Selector:          app=redis
    Type:              ClusterIP
    IP:                10.102.77.6
    Port:              <unset>  6379/TCP
    TargetPort:        6379/TCP
    Endpoints:         10.32.0.6:6379,10.46.0.6:6379
    Session Affinity:  None
    Events:            <none>

Again, visit the vote app from browser, attempt to register your vote and observe what happens now.

# Exercise

1. Complete the following Service manifest for Pod with the label app=webapp and which is running on port 8888.

    kind: Service
    apiVersion: v1
    metadata:
      name: service

2. From the following manifest, change the service type to Load Balancer. Try to access the service by accessing the load balancer URL. (This excercise assumes you already have vote application deployed in your environment.)

    apiVersion: v1
    kind: Service
    metadata:
      name: vote
      namespace: instavote
      labels:
        role: vote
    spec:
      selector:
        role: vote
      ports:
        - port: 80
          targetPort: 80
          nodePort: 30100
      type: NodePort

3. How would you access your service on Port 80 from internet for the following?

    apiVersion: v1
    kind: Service
    metadata:
      name: vote
      namespace: instavote
      labels:
        role: vote
    spec:
      selector:
        role: vote
      ports:
        - port: 80
          targetPort: 80

4. The following service is created in instavote namespace. Use kubectl command to change its namespace to default.

    apiVersion: v1
    kind: Service
    metadata:
      name: vote
      namespace: instavote
      labels:
        role: vote
    spec:
      selector:
        role: vote
      ports:
        - port: 80
          targetPort: 80

5. Write a Service manifest which listens to a RS with ports 80, 8080 and 8443. The Service should be created in the dev namespace.

Reference: Multi-port Service

# LAB: Create and rollout a Deployment
Creating a Deployment

A Deployment is a higher level abstraction which sits on top of replica sets and allows you to manage the way applications are deployed, rolled back at a controlled rate.

Deployment has mainly two responsibilities,

    Provide Fault Tolerance: Maintain the number of replicas for a type of service/app. Schedule/delete pods to meet the desired count.

    Update Strategy: Define a release strategy and update the pods accordingly.

    /k8s-code/projects/instavote/dev/
    cp vote-rs.yaml vote-deploy.yaml

Deployment spec (deployment.spec) contains everything that replica set has + strategy. Lets add it as follows,

File: vote-deploy.yaml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: vote
    spec:
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 2
          maxUnavailable: 1
      revisionHistoryLimit: 4
      paused: false
      replicas: 8
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
            version: v2
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v2
              ports:
                - containerPort: 80
                  protocol: TCP

This time, start monitoring with --show-labels options added.

    watch -n 1 kubectl get  pod,deploy,rs,svc --show-labels

Lets create the Deployment. Do monitor the labels of the pod while applying this.

    kubectl apply -f vote-deploy.yaml

Observe the chances to pod labels, specifically the pod-template-hash.

Now that the deployment is created. To validate,

    kubectl get deployment
    kubectl get rs --show-labels
    kubectl get deploy,pods,rs
    kubectl rollout status deployment/vote
    kubectl get pods --show-labels

Sample Output

    kubectl get deployments
    NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    vote   3         3         3            1           3m
    
  
