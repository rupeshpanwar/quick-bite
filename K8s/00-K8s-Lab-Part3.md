# Topics covered
1. Persistent Volume


# LAB: Setting up NFS using StatefuleSets

Set up NFS Common

On all kubernetes nodes, if you have not already installed nfs, use the following command to do so

    sudo apt-get update
    sudo apt-get install nfs-common

[Skip this step if you are using a vagrant setup recommended as part of this course. ]
Set up NFS Provisioner in kubernetes

Change into nfs provisioner installation dir

    cd k8s-code/storage

Deploy nfs-client provisioner.

    kubectl apply -f nfs
     

This will create all the objects required to setup a nfs provisioner.

# LAB: Creating and mounting PersistentVolumeClaim
Creating a Persistent Volume Claim

switch to project directory

    cd k8s-code/projects/instavote/dev/

file: db-pvc.yaml

    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: db-pvc
    spec:
      accessModes:
        - ReadWriteOnce
      volumeMode: Filesystem
      resources:
        requests:
          storage: 2Gi
      storageClassName: nfs
     

And lets create the Persistent Volume Claim

    kubectl get pvc,storageclass
     
    kubectl logs -f nfs-provisioner-0
     
    kubectl apply -f db-pvc.yaml
     
    kubectl get pvc,storageclass
     
    kubectl describe pvc db-pvc

file: db-deploy.yaml

    ...
    spec:
       containers:
       - image: postgres:9.4
         imagePullPolicy: Always
         name: db
         ports:
         - containerPort: 5432
           protocol: TCP
         #mount db-vol to postgres data path
         volumeMounts:
         - name: db-vol
           mountPath: /var/lib/postgresql/data
       #create a volume with pvc
       volumes:
       - name: db-vol
         persistentVolumeClaim:
           claimName: db-pvc

Observe which host db pod is running on

    kubectl get pod -o wide --selector='role=db'
     

And apply this code as

    kubectl apply -f db-deploy.yaml
     
    kubectl get pod -o wide --selector='role=db'
     

    Observe the volume and its content created on the nfs server

    Observe which host the pod for db was created this time. Analyse the behavior of a deployment controller.
    
  # Exercise

1. Create a Storage Class manifest with the following properties.

    name: gke
    provisioner: kubernetes.io/gce-pd
    type: pd-ssd
    zones: us-central1-a

2. Fix and complete the following PVC manifest.

    kind: persistentVolumeClaim
    apiVersion: v1beta1
    metadata:
      name: jenkins-data
      annotations:
        volume.beta.kubernetes.io/storage-class: gke
    spec:
      accessMode:
      - ReadWriteMany
        xxx:
          storage: 10Gi

3. Convert the following Deployment to use the above created PVC.

    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: jenkins
      labels:
        app: jenkins
        tier: platform
        environment: dev
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: jenkins
            tier: platform
            environment: dev
        spec:
          containers:
          - name: jenkins
            image: jenkins
            ports:
            - containerPort: 8080
            - containerPort: 50000
            volumeMounts:
            - name: jenkins
              mountPath: /var/lib/jenkins
          [xxx]:
          - yyy
          securityContext:
            fsGroup: 1000
            
     # LAB: Releases with downtime using Recreate Strategy
Releases with downtime using Recreate Strategy

When the Recreate deployment strategy is used, * The old pods will be deleted * Then the new pods will be created.

This will create some downtime in our stack.

Let us change the deployment strategy to recreate and image tag to v4.

    cp vote-deploy.yaml vote-deploy-recreate.yaml

And edit the specs with following changes

    Update strategy to Recreate

    Remove rolling update specs

file: vote-deploy-recreate.yaml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: vote
    spec:
      strategy:
        type: Recreate
      revisionHistoryLimit: 4
      paused: false
      replicas: 15
      minReadySeconds: 20
      selector:
        matchLabels:
          role: vote
        matchExpressions:
          - {key: version, operator: In, values: [v1, v2, v3, v4]}
      template:
        metadata:
          name: vote
          labels:
            app: python
            role: vote
            version: v4
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v4
              ports:
                - containerPort: 80
                  protocol: TCP

and apply

    kubectl get pods,rs,deploy,svc
     
    kubectl apply -f vote-deploy-recreate.yaml
     
    kubectl rollout status deplloyment/vote
     

While the deployment happens, use the monitoring/visualiser and observe the manner in which the deployment gets updated.

# LAB: Rolling out a Canary Release
Canary Releases

    cd k8s-code/projets/instavote/dev
    mkdir canary
    cp vote-deploy.yaml canary/vote-canary-deploy.yaml
     

change the following fields in vote-canary-deploy.yaml

    metadata.name: vote-canary

    spec.replicas: 3

    spec.selector.matchExpressions: - {key: version, operator: In, values: [v1, v2, v3, v4]}

    template.metadata.labels.version: v4

    template.spec.containers.image: schoolofdevops/vote:v4

File: canary/frontend-canary-deploy.yml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: vote-canary
    spec:
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 2
          maxUnavailable: 1
      revisionHistoryLimit: 4
      paused: false
      replicas: 3
      selector:
        matchLabels:
          role: vote
        matchExpressions:
          - {key: version, operator: In, values: [v1, v2, v3, v4, v5]}
      minReadySeconds: 40
      template:
        metadata:
          name: vote
          labels:
            app: python
            role: vote
            version: v4
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v4
              ports:
                - containerPort: 80
                  protocol: TCP

Before creating this deployment, find out how many endpoints the service has,

    kubectl describe service/vote

[sample output ]

    Endpoints:                10.32.0.10:80,10.32.0.11:80,10.32.0.4:80 + 12 more...

In this example current endpoints are 15

Now create the deployment for canary release

    kubectl apply -f canary/frontend-canary-deploy.yml
     

And validate,

    kubectl get rs,deploy,svc
     
    kubectl describe service/vote

When you describe vote service, observe the number of endpoints

[sample output]

    Endpoints:                10.32.0.10:80,10.32.0.11:80,10.32.0.16:80 + 15 more...

Now its 18, which is 3 more than the previous number. Those are the pods created by the canary deployment. And the above output proves that its actually sending traffic to both versions.
Delete Canary

Once validated, you could clean up canary release using

    kubectl delete -f canary/vote-canary-deploy.yaml
    
    
 # LAB: Deploying a Blue-Green Release
Blue/Green Releases

Before proceeding, lets clean up the existing deployment.

    kubectl delete deploy/vote
    kubectl delete svc/vote
    kubectl get pods,deploy,rs,svc
     

And create the work directory for blue-green release definitions.

    cd k8s-code/projets/instavote/dev
    mkdir blue-green
     

file: blue-green/vote-blue-deploy.yaml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: vote-blue
    spec:
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 2
          maxUnavailable: 1
      revisionHistoryLimit: 4
      paused: false
      replicas: 15
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
            version: v3
            release: bluegreen
            code: blue
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v3
              ports:
                - containerPort: 80
                  protocol: TCP

file: blue-green/vote-green-deploy.yaml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: vote-green
    spec:
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 2
          maxUnavailable: 1
      revisionHistoryLimit: 4
      paused: false
      replicas: 15
      minReadySeconds: 20
      selector:
        matchLabels:
          role: vote
        matchExpressions:
          - {key: version, operator: In, values: [v1, v2, v3, v4]}
      template:
        metadata:
          name: vote
          labels:
            app: python
            role: vote
            version: v3
            release: bluegreen
            code: green
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v4
              ports:
                - containerPort: 80
                  protocol: TCP
     

file: blue-green/vote-bg-svc.yml

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: vote-bg
      labels:
        role: vote
        release: bluegreen
    spec:
      selector:
        role: vote
        release: bluegreen
        code: green
      ports:
        - port: 80
          targetPort: 80
          nodePort: 30001
      type: NodePort
     

file: vote-svc.yml

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
        release: bluegreen
        code: blue
      ports:
        - port: 80
          targetPort: 80
          nodePort: 30000
      type: NodePort

Creating blue deployment

Now create vote service and observe the endpoints

    kubectl apply -f vote-svc.yaml
    kubectl get svc
    kubectl describe svc/vote

[sample output]

    Name:                     vote
    Namespace:                instavote
    Labels:                   role=vote
    Annotations:              kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"role":"vote"},"name":"vote","namespace":"instavote"},"spec":{"externalIPs":...
    Selector:                 code=blue,release=bluegreen,role=vote
    Type:                     NodePort
    IP:                       10.111.93.227
    External IPs:             206.189.150.190,159.65.8.227
    Port:                     <unset>  80/TCP
    TargetPort:               80/TCP
    NodePort:                 <unset>  30000/TCP
    Endpoints:                <none>
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>

where, * endpoints are None * its selecting pods with code=blue

Now lets create the deployment for blue release

    kubectl get pods,rs,deploy
    kubectl apply -f blue-green/vote-blue-deploy.yaml
    kubectl get pods,rs,deploy
    kubectl rollout status deploy/vote-blue

[sample output]

    Waiting for rollout to finish: 2 of 15 updated replicas are available...
    deployment "vote-blue" successfully rolled out

Now if you check the service, it should have the pods launched with blue set as endpoints

    kubectl describe svc/vote
     
    Name:                     vote
    Namespace:                instavote
    Labels:                   role=vote
    Annotations:              kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"role":"vote"},"name":"vote","namespace":"instavote"},"spec":{"externalIPs":...
    Selector:                 code=blue,release=bluegreen,role=vote
    Type:                     NodePort
    IP:                       10.111.93.227
    External IPs:             206.189.150.190,159.65.8.227
    Port:                     <unset>  80/TCP
    TargetPort:               80/TCP
    NodePort:                 <unset>  30000/TCP
    Endpoints:                10.32.0.10:80,10.32.0.11:80,10.32.0.4:80 + 12 more...
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
     

You could observe the Endpoints created and added to the service. Browse to http://IPADDRESS:NODEPORT to see the application deployed.

Vote App
Deploying new version with green release

While deploying a new version with blue-green strategy, we would

    Create a new deployment in parallel

    Test it by creating another service

    Cut over to new release by updating selector in the main service

Lets create the deployment with new version and a service to test it. Lets call it the green deployment

    kubectl apply -f blue-green/vote-bg-svc.yaml
    kubectl apply -f blue-green/vote-bg-svc.yaml
    kubectl apply -f blue-green/vote-green-deploy.yaml
    kubectl rollout status deploy/vote-green
     

[sample output]

    Waiting for rollout to finish: 0 of 15 updated replicas are available...
    Waiting for rollout to finish: 0 of 15 updated replicas are available...
    Waiting for rollout to finish: 0 of 15 updated replicas are available...
    Waiting for rollout to finish: 0 of 15 updated replicas are available...
    Waiting for rollout to finish: 7 of 15 updated replicas are available...
    deployment "vote-green" successfully rolled out

Validate

    kubectl get pods,rs,deploy,svc

You could also test it by going to the http://host:nodeport for service vote-bg
Switching to new version

Now that you have the new version running in parallel, you could quickly switch to it by updating selector for main vote service which is live. Please note, while switching there may be a momentory downtime.

Steps

    visit http://HOST:NODEPORT for vote service

    update vote service to select green release

    apply service definition

    visit http://HOST:NODEPORT for vote service again to validate

file: vote-svc.yml

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
        release: bluegreen
        code: green
      ports:
        - port: 80
          targetPort: 80
          nodePort: 30000
      type: NodePort
     

Apply it with

    kubectl apply -f vote-svc.yaml
     
    kubectl describe svc/vote

If you visit http://HOST:NODEPORT for vote service, you should see the application version updated

Vote App
Clean up the previous version

    kubectl delete deploy/vote-blue
     

Clean up blue-green configs

Now that you are done testing blue green release, lets revert to our previous configurations.

    kubectl delete deploy/vote-green
    kubectl apply -f vote-deploy.yaml
     

Also update the service definition and remove following selectors added for blue green release

    release: bluegreen

    code: blue

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
          nodePort: 30000
      type: NodePort

And apply

    kubectl apply -f vote-svc.yaml

Pause/Unpause

When you are in the middle of a new update for your application and you found out that the application is behaving as intended. In those situations, 1. we can pause the update, 2. fix the issue, 3. resume the update.

Let us change the image tag to V4 in pod spec.

File: vote-deploy.yaml

        spec:
           containers:
             - name: app
               image: schoolofdevops/vote:V4
               ports:
                 - containerPort: 80
                   protocol: TCP

Apply the changes.

    kubectl apply -f vote-deploy.yaml
     
    kubectl get pods
     
    [Output]
    NAME                         READY     STATUS         RESTARTS   AGE
    vote-c4f7b49d8-g5dgc   1/1       Running        0          6m
    vote-65554cc7-xsbhs    0/1       ErrImagePull   0          s

Our deployment is failing. From some debugging, we can conclude that we are using a wrong image tag.

Now pause the update

    kubectl rollout pause deploy/vote

Set the deployment to use v4 version of the image.

Now resume the update

    kubectl rollout resume deployment vote
    kubectl rollout status deployment vote
     
    [Ouput]
    deployment "vote" successfully rolled out

and validate

    kubectl get pods,rs,deploy
     
    [Output]
    NAME                         READY     STATUS    RESTARTS   AGE
    vote-875c8df8f-k4hls   1/1       Running   0          m

When you do this, you skip the need of creating a new rolling update altogether.

# LAB: Pause and Resume a Release
Pause/Unpause


When you are in the middle of a new update for your application and you found out that the application is behaving as intended. In those situations, 1. we can pause the update, 2. fix the issue, 3. resume the update.

Let us change the image tag to V4 in pod spec.

File: vote-deploy.yaml

        spec:
           containers:
             - name: app
               image: schoolofdevops/vote:V4
               ports:
                 - containerPort: 80
                   protocol: TCP

Apply the changes.

    kubectl apply -f vote-deploy.yaml
     
    kubectl get pods
     
    [Output]
    NAME                         READY     STATUS         RESTARTS   AGE
    vote-c4f7b49d8-g5dgc   1/1       Running        0          6m
    vote-65554cc7-xsbhs    0/1       ErrImagePull   0          s

Our deployment is failing. From some debugging, we can conclude that we are using a wrong image tag.

Now pause the update

    kubectl rollout pause deploy/vote

Set the deployment to use v4 version of the image.

Now resume the update

    kubectl rollout resume deployment vote
    kubectl rollout status deployment vote
     
    [Ouput]
    deployment "vote" successfully rolled out

and validate

    kubectl get pods,rs,deploy
     
    [Output]
    NAME                         READY     STATUS    RESTARTS   AGE
    vote-875c8df8f-k4hls   1/1       Running   0          m

When you do this, you skip the need of creating a new rolling update altogether.

# Exercise

1. Create a Deployment manifest which uses Recreate as its deployment

strategy with the following properties.

    Name: mogambo
    Replicas: 3
    Image: schoolofdevops/frontend:latest

2. Create a Deployment with version 1 of the image and then do a rolling update to version 2.

    Image Version 1: schoolofdevops/frontend:v1.0
    Image Version 2: schoolofdevops/frontend:v2.0
    maxUnavailable pods should be 1.
    maxSurge should be 2.

3. Convert the above created Deployment manifest with Blue/Green strategy.

    Version 1: Blue
    Version 2: Green
    
 # LAB: Deploy Metrics Server for feeding in core metrics to HPA
Deploying Metrics Server

Kubernetes Horizontal Pod Autoscaler along with kubectl topcommand depends on the core monitoring data such as cpu and memory utilization which is scraped and provided by kubelet, which comes with in built cadvisor component. Earlier, you would have to install a additional component called heapster in order to collect this data and feed it to the hpa controller. With 1.8 version of Kubernetes, this behavior is changed, and now metrics-server would provide this data. Metric server is being included as a essential component for kubernetes cluster, and being incroporated into kubernetes to be included out of box. It stores the core monitoring information using in-memory data store.

If you try to pull monitoring information using the following commands

    kubectl top pod
     
    kubectl top node

it does not show it, rather gives you a error message similar to

[output]

    Error from server (NotFound): the server could not find the requested resource (get services http:heapster:)

Even though the error mentions heapster, its replaced with metrics server by default now.

Deploy metric server with the following commands,

    git clone  https://github.com/kubernetes-incubator/metrics-server.git
    kubectl apply -f kubectl create -f metrics-server/deploy/1.8+/

Validate

    kubectl get deploy,pods -n kube-system --selector='k8s-app=metrics-server'

[sample output]

    NAME                                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    deployment.extensions/metrics-server   1         1         1            1           28m
     
    NAME                                  READY     STATUS    RESTARTS   AGE
    pod/metrics-server-6fbfb84cdd-74jww   1/1       Running   0          28m

Monitoring has been setup.
Fixing issues with Metrics deployment

There is a known issue as off Dec 2018 with Metrics Server where is fails to work event after deploying it using above commands. This can be fixed with a patch using steps below.

To apply a patch to metrics server,

    wget -c https://gist.githubusercontent.com/initcron/1a2bd25353e1faa22a0ad41ad1c01b62/raw/008e23f9fbf4d7e2cf79df1dd008de2f1db62a10/k8s-metrics-server.patch.yaml
     
    kubectl patch deploy metrics-server -p "$(cat k8s-metrics-server.patch.yaml)" -n kube-system

Now validate with

    kubectl top node 
    kubectl top pod 

where expected output should be similar to,

    # kubectl top node
    NAME     CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
    vis-01   145m         7%     2215Mi          57%
    vis-13   36m          1%     1001Mi          26%
    vis-14   71m          3%     1047Mi          27%

# LAB: Running load test as a kubernetes Job
Running Load Test as a Job


file: loadtest-job.yaml

    apiVersion: batch/v1
    kind: Job
    metadata:
      name: loadtest
    spec:
      template:
        spec:
          containers:
          - name: siege
            image: schoolofdevops/loadtest:v1
            command: ["siege",  "--concurrent=5", "--benchmark", "--time=10m", "http://vote"]
          restartPolicy: Never
      backoffLimit: 4

And launch the loadtest

    kubectl apply -f loadtest-job.yaml

To monitor while the load test is running ,

    watch kubectl top pods
     

To get information about the job

    kubectl get jobs
    kubectl describe  job loadtest
     

To check the load test output

    kubectl logs  -f loadtest-xxxx

[replace loadtest-xxxx with the actual pod id.]

[Sample Output]

    ** SIEGE 3.0.8
    ** Preparing 15 concurrent users for battle.
    root@kube-01:~# kubectl logs vote-loadtest-tv6r2 -f
    ** SIEGE 3.0.8
    ** Preparing 15 concurrent users for battle.
     
    .....
     
     
    Lifting the server siege...      done.
     
    Transactions:              41618 hits
    Availability:              99.98 %
    Elapsed time:             299.13 secs
    Data transferred:         127.05 MB
    Response time:              0.11 secs
    Transaction rate:         139.13 trans/sec
    Throughput:             0.42 MB/sec
    Concurrency:               14.98
    Successful transactions:       41618
    Failed transactions:               8
    Longest transaction:            3.70
    Shortest transaction:           0.00
     
    FILE: /var/log/siege.log
    You can disable this annoying message by editing
    the .siegerc file in your home directory; change
    the directive 'show-logfile' to false.

Now check the job status again,

    kubectl get jobs
    NAME            DESIRED   SUCCESSFUL   AGE
    vote-loadtest   1         1            10m
    
  # Exercise

1. When you deploy the metrics server, you are not able to get metrics either from Pods or Nodes. After debugging further, you found out that the metrics-server Pods is not running with following error. How would you go about fixing this issue?

    [metrics-server-logs]
    I0919 11:06:38.614962       1 serving.go:273] Generated self-signed cert (apiserver.local.config/certificates/apiserver.crt, apiserver.local.config/certificates/apiserver.key)
    [restful] 2018/09/19 11:06:39 log.go:33: [restful/swagger] listing is available at https://:443/swaggerapi
    [restful] 2018/09/19 11:06:39 log.go:33: [restful/swagger] https://:443/swaggerui/ is mapped to folder /swagger-ui/
    I0919 11:06:39.698970       1 serve.go:96] Serving securely on [::]:443
    E0919 11:06:50.112929       1 reststorage.go:101] unable to fetch node metrics for node "kubeadm-test": no metrics known for node "kubeadm-test"
    E0919 11:06:50.112964       1 reststorage.go:101] unable to fetch node metrics for node "kubeadm-test-2": no metrics known for node "kubeadm-test-2"
    E0919 11:06:52.638381       1 reststorage.go:101] unable to fetch node metrics for node "kubeadm-test": no metrics known for node "kubeadm-test"
    E0919 11:06:52.638404       1 reststorage.go:101] unable to fetch node metrics for node "kubeadm-test-2": no metrics known for node "kubeadm-test-2"
    E0919 11:07:39.693561       1 manager.go:102] unable to fully collect metrics: [unable to fully scrape metrics from source kubelet_summary:kubeadm-test: unable to fetch metrics from Kubelet kubeadm-test (kubeadm-test): Get https://kubeadm-test:10250/stats/summary/: x509: certificate signed by unknown authority, unable to fully scrape metrics from source kubelet_summary:kubeadm-test-2: unable to fetch metrics from Kubelet kubeadm-test-2 (kubeadm-test-2): Get https://kubeadm-test-2:10250/stats/summary/: x509: certificate signed by unknown authority]

2. Create a Deployment manifest with following properties.

    image: schoolofdevops/frontend:v1.0
    minimum available memory: 128mb
    minimum available cpu: 0.25 core
    maximum available memory: 256mb
    maximum available cpu: 0.50 core

3. Create a HPA for the above created Deployment with following propeties.

    cpu target utilization: 50%
    memory target utiliztion: 200mb
    
  

