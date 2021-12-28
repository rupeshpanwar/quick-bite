# Topics covered
1. Service
2. Replicaset
3. Deployment, upgrade, rollback
4. Configmap, secrets
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
    
  # Lab : Scale, Rollout and Rollback
Scaling a deployment

To scale a deployment in Kubernetes:

    kubectl scale deployment/vote --replicas=12
     
    kubectl rollout status deployment/vote
     

Sample output:

    Waiting for rollout to finish: 5 of 12 updated replicas are available...
    Waiting for rollout to finish: 6 of 12 updated replicas are available...
    deployment "vote" successfully rolled out

You could also update the deployment by editing it.

    kubectl edit deploy/vote

[change replicas to 15 from the editor, save and observe]
Rolling Updates in Action

Now, update the deployment spec to apply

file: vote-deploy.yaml

    spec:
    ...
      replicas: 15
    ...
    labels:
       app: python
       role: vote
       version: v3
    ...
    template:   
      spec:
        containers:
          - name: app
            image: schoolofdevops/vote:v3
     

apply

    kubectl apply -f vote-deploy.yaml
     
    kubectl rollout status deployment/vote

Observe rollout status and monitoring screen.

    kubectl rollout history deploy/vote
     
    kubectl rollout history deploy/vote --revision=1
     

Undo and Rollback

file: vote-deploy.yaml

    spec:
      containers:
        - name: app
          image: schoolofdevops/vote:rgjerdf
     

apply

    kubectl apply -f vote-deploy.yaml
     
    kubectl rollout status
     
    kubectl rollout history deploy/vote
     
    kubectl rollout history deploy/vote --revision=xx

where replace xxx with revisions

Find out the previous revision with sane configs.

To undo to a sane version (for example revision 3)

    kubectl rollout undo deploy/vote --to-revision=3
    
 # MINI PROJECT : Deploy instavote app stack with Kubernetes
Mini Project: Deploying Multi Tier Application Stack


In this project , you would write definitions for deploying the vote application stack with all components/tiers which include,

    vote ui

    redis

    worker

    db

    results ui

Tasks

    Create deployments for all applications

    Define services for each tier applicable

    Launch/apply the definitions

Following table  depicts the state of readiness of the above services.




Specs:

    worker

        image: schoolofdevops/worker:latest

    results

        image: schoolofdevops/vote-result

        port: 80

        service type: NodePort


Deploying the sample application


To create deploy the sample applications,

    kubectl create -f projects/instavote/dev

Sample output is like:

    deployment "db" created
    service "db" created
    deployment "redis" created
    service "redis" created
    deployment "vote" created
    service "vote" created
    deployment "worker" created
    deployment "results" created
    service "results" created

To Validate:

    kubectl get svc -n instavote

Sample Output is:

    kubectl get service vote
    NAME         CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    vote   10.97.104.243   <pending>     80:31808/TCP   1h

Here the port assigned is 31808, go to the browser and enter

    masterip:31808

alt text

This will load the page where you can vote.

To check the result:

    kubectl get service result

Sample Output is:

    kubectl get service result
    NAME      CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    result    10.101.112.16   <pending>     80:32511/TCP   1h

Here the port assigned is 32511, go to the browser and enter

    masterip:32511

alt text

This is the page where you should see the results for the vote

# Exercise

1. Create an Nginx Deployment using kubectl with following properties.

      1. Name: nginx-frontend
      2. Labels: app=nginx, tier=frontend
      3. Image: nginx:latest
      3. Replicas: 3
      4. ImagePullPolicy: Always

2. For the above mentioned Deployment, change the image version from nginx:latest to nginx:1.12.0 using kubectl set image command

3. For the above mentioned Deployment, undo the changes using kubectl rollout command and rollback to revision 1.

4. Create a Deployment manifest with the following properties and apply it. If it fails, try to do rolling update the image version to 0.3.0

      1. Name: web-app
      2. Labels: env=prod, tier=web
      3. Image: robotshop/rs-web:v1.0
      4. Port: 8080
      5. Restart Policy: Always

5. For the following application, fix and fill in the missing details.

    apiVersion: extensions/v1beta1
    kind: deployment
    metadata:
      labels:
      name: mysql
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: mysql
        spec:
          containers:
          - image: robotshop/rs-mysql-db:latest
            name:
            ports:
            - Containerport: 3306
          restartPolicy: xxxx
          
  # LAB: Injecting env variables with configmaps


Injecting env variables with configmaps


Create our configmap for vote app

file: projects/instavote/dev/vote-cm.yaml

    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: vote
      namespace: instavote
    data:
      OPTION_A: Visa
      OPTION_B: Mastercard

In the above given configmap, we define two environment variables,

    OPTION_A=EMACS

    OPTION_B=VI

Lets create the configmap object

    kubectl get cm
    kubectl apply -f vote-cm.yaml
    kubectl get cm
    kubectl describe cm vote
     
     

In order to use this configmap in the deployment, we need to reference it from the deployment file.

Check the deployment file for vote add for the following block.

file: vote-deploy.yaml

    ...
        spec:
          containers:
          - image: schoolofdevops/vote
            imagePullPolicy: Always
            name: vote
            envFrom:
              - configMapRef:
                  name: vote
            ports:
            - containerPort: 80
              protocol: TCP
            restartPolicy: Always

So when you create your deployment, these configurations will be made available to your application. In this example, the values defined in the configmap (Visa and Mastercard) will override the default values(CATS and DOGS) present in your source code.

    kubectl apply -f vote-deploy.yaml

Watch the monitoring screen for deployment in progress.

    kubectl get deploy --show-labels
    kubectl get rs --show-labels
    kubectl  rollout status deploy/vote
     

# LAB: Providing environment Specific Configs
Providing environment Specific Configs


Copy the dev env to staging

    cd k8s-code/projects/instavote
    cp -r dev staging

Edit the configurations for staging

    cd staging
     

Edit vote-cm.yaml

    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: vote
    data:
      OPTION_A: Apple
      OPTION_B: Samsung

Edit vote-svc.yaml

    remove namespace if set

    remove extIP

    remove hard coded nodePort config if any

file: vote-svc.yaml

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
      type: NodePort

Edit vote-deploy.yaml

    remove namespace if set

    change replicas to 2

Lets launch it all in another namespace. We could use default namespace for this purpose.

    kubectl config set-context $(kubectl config  current-context) --namespace=default

Verify the namespace has been switched by observing the monitoring screen.

Deploy new objects in this nmespace

    kubectl apply -f vote-svc.yaml
    kubectl apply -f vote-cm.yaml
    kubectl apply -f vote-deploy.yaml
     

Now connect to the vote service by finding out the nodePort configs

    kubectl get svc vote
     

Troubleshooting

    Do you see the application when you browse to http://host:nodeport

    If not, why? Find the root cause and fix it.

Clean up and Switch back the namespace

Verify the environment specific options are in effect. Once verified, you could switch the namespace back to instavote.

    kubectl delete deploy/vote svc/vote
     
    kubectl config set-context $(kubectl config  current-context) --namespace=instavote
     
    cd ../dev/


# LAB: Configuration file as ConfigMap
Configuration file as ConfigMap


In the topic above we have seen how to use configmap as environment variables. Now let us see how to use configmap as redis configuration file.

Syntax for consuming file as a configmap is as follows

      kubectl create configmap --from-file <CONF-FILE-PATH> <NAME-OF-CONFIGMAP>

We have redis configuration as a file named projects/instavote/config/redis.conf. We are going to convert this file into a configmap

    cd k8s-code/projects/instavote/config/
     
    kubectl create configmap --from-file  redis.conf redis

Now validate the configs

    kubectl get cm
     
    kubectl describe cm redis

To use this confif file, update your redis-deploy.yaml file to use it by mounting it as a volume.

File: dev/redis-deploy.yaml

        spec:
          containers:
          - image: schoolofdevops/redis:latest
            imagePullPolicy: Always
            name: redis
            ports:
            - containerPort: 6379
              protocol: TCP
            volumeMounts:
              - name: redis
                subPath: redis.conf
                mountPath: /etc/redis.conf
          volumes:
          - name: redis
            configMap:
              name: redis
          restartPolicy: Always

And apply it

    kubectl apply -f redis-deploy.yaml
     
    kubectl apply -f redis-svc.yaml
     
    kubectl get rs,deploy --show-labels

Exercise: Connect to redis pod and verify configs.

# LAB: Using Secrets to encrypt sensitive data
Secrets

Secrets are for storing sensitive data like passwords and keychains. We will see how db deployment uses username and password in form of a secret.

You would define two fields for db,

    username

    password

To create secrets for db you need to generate base64 format as follows,

    echo "admin" | base64
    echo "password" | base64

where admin and password are the actual values that you would want to inject into the pod environment.

If you do not have a unix host, you can make use of online base64 utility to generate these strings.

    http://www.utilities-online.info/base64

Lets now add it to the secrets file,

File: projects/instavote/dev/db-secrets.yaml

    apiVersion: v1
    kind: Secret
    metadata:
      name: db
      namespace: instavote
    type: Opaque
    data:
      POSTGRES_USER: YWRtaW4=
      POSTGRES_PASSWD: cGFzc3dvcmQ=

    kubectl apply -f db-secrets.yaml
     
    kubectl get secrets
     
    kubectl describe secret db

Secrets can be referred to inside a container spec with following syntax

    env:
      - name: VAR
        valueFrom:
          secretKeyRef:
            name: db
            key: SECRET_VAR

To consume these secrets, update the deployment for db

file: db-deploy.yaml

    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: db
      namespace: instavote
    spec:
      replicas: 1
      selector:
        matchLabels:
          tier: back
          app: postgres
      minReadySeconds: 10
      template:
        metadata:
          labels:
            app: postgres
            role: db
            tier: back
        spec:
          containers:
          - image: postgres:9.4
            imagePullPolicy: Always
            name: db
            ports:
            - containerPort: 5432
              protocol: TCP
            # Secret definition
            env:
              - name: POSTGRES_USER
                valueFrom:
                  secretKeyRef:
                    name: db
                    key: POSTGRES_USER
              - name: POSTGRES_PASSWD
                valueFrom:
                  secretKeyRef:
                    name: db
                    key: POSTGRES_PASSWD
          restartPolicy: Always

To apply this,

    kubectl apply -f db-deploy.yaml
     
    kubectl apply -f db-svc.yaml
     
    kubectl get rs,deploy --show-labels

Note: Automatic Updation of deployments on ConfigMap Updates

Currently, updating configMap does not ensure a new rollout of a deployment. What this means is even after updading configMaps, pods will not immediately reflect the changes.

There is a feature request for this https://github.com/kubernetes/kubernetes/issues/22368

Currently, this can be done by using immutable configMaps.

    Create a configMaps and apply it with deployment.

    To update, create a new configMaps and do not update the previous one. Treat it as immutable.

    Update deployment spec to use the new version of the configMaps. This will ensure immediate update.
    
  # Exercise

1. Create two different ConfigMap manifest with the following properties. If there are any bugs, fix them.

    Name: ConfigMap-A
    data 1:
      SALT: astdXy3Cmn5DMbcPqeYK
      STATE: present
     
    Name: ConfigMap-B
    data 2:
      API: https://107.178.217.202
      USER: admin

2. Complete the following Pod definition to use the above mentioned configMaps.

    apiVersion: v1
    kind: Pod
    metadata:
      name: config-test-pod
    spec:
      containers:
        - name: config-test-container
          image: k8s.gcr.io/busybox
          command: [ "/bin/sh", "-c", "echo $(SALT) $(STATE) $(API)" ]
          xxx:
          [...]
      restartPolicy: Never

3. Convert the following data into secret.

    name: mongo-secret
    data:
      username: mongoadmin
      password: Cr0wnJ3w3!
      secret_key: AsMPgc3xTroPcv6vi$NO

4. Mount the above created secret as a volume with the /etc/mongoCreds path in the following Pod manifest.

    apiVersion: v1
    kind: Pod
    metadata:
      name: secret-test-pod
    spec:
      containers:
        - name: secret-test-container
          image: k8s.gcr.io/busybox
          command: [ "/bin/sh", "-c", "ping" "localhost" ]

5. Create a Secret from literal values using kubectl.

      username: casterAdmin
      password: s3cr3tsauc3
     
