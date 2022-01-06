# LAB: Create a Ingress Controller
Ingress
Pre Requisites

    Ingress controller such as Nginx, Trafeik needs to be deployed before creating ingress resources.

    On GCE, ingress controller runs on the master. On all other installations, it needs to be deployed, either as a deployment, or a daemonset. In addition, a service needs to be created for ingress.

    Daemonset will run ingress on each node. Deployment will just create a highly available setup, which can then be exposed on specific nodes using ExternalIPs configuration in the service.

Create a Ingress Controller

An ingress controller needs to be created in order to serve the ingress requests. Kubernetes comes with support for GCE and nginx ingress controllers, however additional softwares are commonly used too. As part of this implementation you are going to use Traefik as the ingress controller. Its a fast and lightweight ingress controller and also comes with great documentation and support.

    +----+----+--+            
    | ingress    |            
    | controller |            
    +----+-------+            
     
     

There are commonly two ways you could deploy an ingress

    Using Deployments with HA setup

    Using DaemonSets which run on every node

We pick DaemonSet, which will ensure that one instance of traefik is run on every node. Also, we use a specific configuration hostNetwork so that the pod running traefik attaches to the network of underlying host, and not go through kube-proxy. This would avoid extra network hop and increase performance a bit.

Deploy ingress controller with daemonset as

    cd k8s-code/ingress/traefik
     
    kubectl get ds -n kube-system
     
    kubectl apply -f traefik-rbac.yaml
    kubectl apply -f traefik-ds.yaml

Validate

    kubectl get svc,ds,pods -n kube-system  --selector='k8s-app=traefik-ingress-lb'

[output]

    NAME                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
    service/traefik-ingress-service   ClusterIP   10.109.182.203   <none>        80/TCP,8080/TCP   1h
     
    NAME                                              DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
    daemonset.extensions/traefik-ingress-controller   2         2         2         2            2           <none>          1h
     
    NAME                                   READY     STATUS    RESTARTS   AGE
    pod/traefik-ingress-controller-bmwn7   1/1       Running   0          1h
    pod/traefik-ingress-controller-vl296   1/1       Running   0          1h

You would notice that the ingress controller is started on all nodes (except managers). Visit any of the nodes 8080 port e.g. http://IPADDRESS:8080 to see traefik's management UI.

Traefik



# LAB: Adding Named Based Routing

Setting up Named Based Routing for Vote App

We will direct all our request to the ingress controller now, but with differnt hostname e.g. vote.example.org or results.example.org. And it should direct to the correct service based on the host name.

In order to achieve this you, as a user would create a ingress object with a set of rules,

    +----+----+--+            
    | ingress    |            
    | controller |            
    +----+-------+            
         |              +-----+----+
         +---watch----> | ingress  | <------- user
                        +----------+
     

file: vote-ing.yaml

    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: vote
      annotations:
        kubernetes.io/ingress.class: traefik
        ingress.kubernetes.io/auth-type: "basic"
        ingress.kubernetes.io/auth-secret: "mysecret"
    spec:
      rules:
        - host: vote.example.org
          http:
            paths:
              - path: /
                backend:
                  serviceName: vote
                  servicePort: 82
        - host: results.example.org
          http:
            paths:
              - path: /
                backend:
                  serviceName: results
                  servicePort: 81

And apply

    kubectl get ing
    kubectl apply -f vote-ing.yaml --dry-run
    kubectl apply -f vote-ing.yaml

Since the ingress controller is constantly monitoring for the ingress objects, the moment it detects, it connects with traefik and creates a rule as follows.

                        +----------+
         +--create----> | traefik  |
         |              |  rules   |
         |              +----------+
    +----+----+--+            ^
    | ingress    |            :
    | controller |            :
    +----+-------+            :
         |              +-----+----+
         +---watch----> | ingress  | <------- user
                        +----------+
     

where,

    A user creates a ingress object with the rules. This could be a named based or a path based routing.

    An ingress controller, in this example traefik constantly monitors for ingress objects. The moment it detects one, it creates a rule and adds it to the traefik load balancer. This rule maps to the ingress specs.

You could now see the rule added to ingress controller,

Traefik with Ingress Rules

Where,

    vote.example.org and results.example.org are added as frontends. These frontends point to respective services vote and results.

    respective backends also appear on the right hand side of the screen, mapping to each of the service.

Adding Local DNS

You have created the ingress rules based on hostnames e.g. vote.example.org and results.example.org. In order for you to be able to access those, there has to be a dns entry pointing to your nodes, which are running traefik.

      vote.example.org     -------+                        +----- vote:81
                                  |     +-------------+    |
                                  |     |   ingress   |    |
                                  +===> |   node:80   | ===+
                                  |     +-------------+    |
                                  |                        |
      results.example.org  -------+                        +----- results:82
     

To achieve this you need to either,

    Create a DNS entry, provided you own the domain and have access to the dns management console.

    Create a local hosts file entry. On unix systems its in /etc/hosts file. On windows its at C:\Windows\System32\drivers\etc\hosts. You need admin access to edit this file.

For example, on a linux or osx, you could edit it as,

    sudo vim /etc/hosts

And add an entry such as ,

    xxx.xxx.xxx.xxx vote.example.org results.example.org

where,

    xxx.xxx.xxx.xxx is the actual IP address of one of the nodes running traefik.

And then access the app urls using http://vote.example.org or http://results.example.org

Name Based Routing

# LAB: Using Annotations to enable HTTP Auth

Adding HTTP Authentication with Annotations
Creating htpasswd spec as Secret

    htpasswd -c auth devops

Or use Online htpasswd generator to generate a htpasswd spec. if you use the online generator, copy the contents to a file by name auth in the current directory.

Then generate the secret as,

    kubectl create secret generic mysecret --from-file auth
     
    kubectl get secret
     
    kubectl describe secret mysecret

And then add annotations to the ingress object so that it is read by the ingress controller to update configurations.

file: vote-ing.yaml

    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: vote
      annotations:
        kubernetes.io/ingress.class: traefik
        ingress.kubernetes.io/auth-type: "basic"
        ingress.kubernetes.io/auth-secret: "mysecret"
    spec:
      rules:
        - host: vote.example.org
          http:
            paths:
              - path: /
                backend:
                  serviceName: vote
                  servicePort: 82
        - host: results.example.org
          http:
            paths:
              - path: /
                backend:
                  serviceName: results
                  servicePort: 81
     

where,

    ingress.kubernetes.io/auth-type: "basic" defines authentication type that needs to be added.

    ingress.kubernetes.io/auth-secret: "mysecret" refers to the secret created earlier.

apply

    kubectl apply -f vote-ing.yaml
    kubectl get ing/vote -o yaml

Observe the annotations field. No sooner than you apply this spec, ingress controller reads the event and a basic http authentication is set with the secret you added.

                          +----------+
           +--update----> | traefik  |
           |              |  configs |
           |              +----------+
      +----+----+--+            ^
      | ingress    |            :
      | controller |            :
      +----+-------+            :
           |              +-----+-------+
           +---watch----> | ingress     | <------- user
                          | annotations |
                          +-------------+

And if you visit traefik's dashboard and go to the details tab, you should see the basic authentication section enabled as in the diagram below.

Name Based Routing
Reading

    Trafeik's Guide to Kubernetes Ingress Controller

    Annotations

    DaemonSets

References

    Online htpasswd generator
  
 # Exercise

1. Create a nginx ingress controller by following the documentation.

Reference: Nginx ingress

2. Use the nginx ingress to with the following properties for the deployment give below. Create the missing components( such as frontend-svc) to expose this deployment.

    [ingress-details]
    ingress controller: nginx
    domain name: mogambo.com
    path: /
    service: frontend
    service port: 80

    [frontend-deployment]
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: frontend
    spec:
      replicas: 2
      template:
        metadata:
          labels:
            app: front-end
        spec:
          containers:
          - image: schoolofdevops/frontend:latest
            imagePullPolicy: Always
            name: front-end
            ports:
            - containerPort: 8079
              protocol: TCP

3. Create a basic authentication for the frontend deployment with the following parameters with nginx ingress controller.

    username: serviceadmin
    password: sup3rs3cr3t
    
  # LAB: Creating firewall with Network Policies
Setting up a firewall with Network Policies

While setting up the network policy, you may need to refer to the namespace created earlier. In order to being abel to referred to, namespace should have a label. Lets update the namespace with a label.

file: instavote-ns.yaml

    kind: Namespace
    apiVersion: v1
    metadata:
      name: instavote
      labels:
        project: instavote
     

apply

    kubectl get namespace --show-labels
    kubectl apply -f instavote-ns.yaml
    kubectl get namespace --show-labels
     

Now, define a restrictive network policy which would,

    Block all incoming connections from any source except for pods from the same namespace

    Block all outgoing connections

      +-----------------------------------------------------------+
      |                                                           |
      |    +----------+          +-----------+                    |
    x |    | results  |          | db        |                    |
      |    |          |          |           |                    |
      |    +----------+          +-----------+                    |
      |                                                           |
      |                                                           |
      |                                        +----+----+--+     |           
      |                                        |   worker   |     |            
      |                                        |            |     |           
      |                                        +----+-------+     |           
      |                                                           |
      |                                                           |
      |    +----------+          +-----------+                    |
      |    | vote     |          | redis     |                    |
    x |    |          |          |           |                    |
      |    +----------+          +-----------+                    |
      |                                                           |
      +-----------------------------------------------------------+
     

file: instavote-netpol.yaml

    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: default-deny
    spec:
      podSelector: {}
      policyTypes:
      - Ingress
      - Egress

apply

    kubectl get netpol
     
    kubectl apply -f instavote-netpol.yaml
     
    kubectl get netpol
     
    kubectl describe netpol/default-deny
     

Try accessing the vote and results ui. Can you access it ?
Setting up ingress rules for outward facing applications

      +-----------------------------------------------------------+
      |                                                           |
      |    +----------+          +-----------+                    |
    =====> | results  |          | db        |                    |
      |    |          |          |           |                    |
      |    +----------+          +-----------+                    |
      |                                                           |
      |                                                           |
      |                                        +----+----+--+     |           
      |                                        |   worker   |     |            
      |                                        |            |     |           
      |                                        +----+-------+     |           
      |                                                           |
      |                                                           |
      |    +----------+          +-----------+                    |
      |    | vote     |          | redis     |                    |
    =====> |          |          |           |                    |
      |    +----------+          +-----------+                    |
      |                                                           |
      +-----------------------------------------------------------+
     

To the same file, add a new network policy object.

file: instavote-netpol.yaml

    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: default-deny
    spec:
      podSelector: {}
      policyTypes:
      - Ingress
      - Egress
    ---
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: public-ingress
      namespace: instavote
    spec:
      podSelector:
        matchExpressions:
          - {key: role, operator: In, values: [vote, results]}
      policyTypes:
      - Ingress
      ingress:
        - {}

where,

instavote-ingress is a new network policy which,

    defines policy for pods with vote and results role

    and allows them incoming access from anywhere

apply

    kubectl apply -f instavote-netpol.yaml

Exercise

    Try accessing the ui now and check if you are able to.

    Try to vote, see if that works? Why ?

Setting up egress rules to allow communication between services from same project

When you tried to vote, you might have observed that it does not work. Thats because the default network policy we created earlier blocks all outgoing traffic. Which is good for securing the environment, however you still need to provide inter connection between services from the same project. Specifically vote, worker and results apps need outgoing connection to redis and db. Lets allow that with a egress policy.

      +-----------------------------------------------------------+
      |                                                           |
      |    +------------+        +-----------+                    |
    =====> | results    | ------>| db        |                    |
      |    |            |        |           | <-------+          |
      |    +------------+        +-----------+         |          |
      |                                                |          |
      |                                                |          |
      |                                        +----+----+---+    |           
      |                                        |   worker    |    |            
      |                                        |             |    |           
      |                                        +----+--------+    |           
      |                                                |          |
      |                                                |          |
      |    +----------+          +-----------+         |          |
      |    | vote     |          | redis     | <-------+          |
    =====> |          |  ------> |           |                    |
      |    +----------+          +-----------+                    |
      |                                                           |
      +-----------------------------------------------------------+
     

Edit the same policy file and add the following snippet,

file: instavote-netpol.yaml

    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: default-deny
    spec:
      podSelector: {}
      policyTypes:
      - Ingress
      - Egress
      ingress:
      - from:
        - namespaceSelector:
            matchLabels:
              project: instavote
      egress:
      - to:
        - namespaceSelector:
            matchLabels:
              project: instavote
    ---
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: public-ingress
      namespace: instavote
    spec:
      podSelector:
        matchExpressions:
          - {key: role, operator: In, values: [vote, results]}
      policyTypes:
      - Ingress
      ingress:
        - {}

where,

instavote-egress is a new network policy which,

    defines policy for pods with vote, worker and results role

    and allows them outgoing access to any pods in the same namespace, and that includes redis and db



# LAB: Creating users and groups using x509 certificates
Creating Kubernetes Users and Groups

Generate the user's private key

    mkdir -p  ~/.kube/users
    cd ~/.kube/users
     
    openssl genrsa -out maya.key 2048
    openssl genrsa -out kim.key 2048
    openssl genrsa -out yono.key 2048
     

[sample Output]

    openssl genrsa -out maya.key 2048
    Generating RSA private key, 2048 bit long modulus
    .............................................................+++
    .........................+++
    e is 65537 (0x10001)
     

Lets now create a Certification Signing Request (CSR) for each of the users. When you generate the csr make sure you also provide

    CN: This will be set as username

    O: Org name. This is actually used as a group by kubernetes while authenticating/authorizing users. You could add as many as you need

e.g.

    openssl req -new -key maya.key -out maya.csr -subj "/CN=maya/O=ops/O=example.org"
    openssl req -new -key kim.key -out kim.csr -subj "/CN=kim/O=dev/O=example.org"
    openssl req -new -key yono.key -out yono.csr -subj "/CN=yono/O=interns/O=example.org"
     

In order to be deemed authentic, these CSRs need to be signed by the Certification Authority (CA) which in this case is Kubernetes Master. You need access to the folllwing files on kubernetes master.

    Certificate : ca.crt (kubeadm) or ca.key (kubespray)

    Pricate Key : ca.key (kubeadm) or ca-key.pem (kubespray)

You would typically find it at one of the following paths

    /etc/kubernetes/pki (kubeadm)

    /etc/kubernetes/ssl (kubespray)

To verify which one is your cert and which one is key, use the following command,

    $ file ca.pem
    ca.pem: PEM certificate
     
     
    $ file ca-key.pem
    ca-key.pem: PEM RSA private key

Once signed, .csr files with added signatures become the certificates that could be used to authenticate.

You could either

    move the crt files to k8s master, sign and download

    copy over the CA certs and keys to your management node and use it to sign. Make sure to keep your CA related files secure.

In the example here, I have already downloaded ca.pem and ca-key.pem to my management workstation, which are used to sign the CSRs.

Assuming all the files are in the same directory, sign the CSR as,

    openssl x509 -req -CA ca.pem -CAkey ca-key.pem -CAcreateserial -days 730 -in maya.csr -out maya.crt
     
    openssl x509 -req -CA ca.pem -CAkey ca-key.pem -CAcreateserial -days 730 -in kim.csr -out kim.crt
     
    openssl x509 -req -CA ca.pem -CAkey ca-key.pem -CAcreateserial -days 730 -in yono.csr -out yono.crt

Setting up User configs with kubectl

In order to configure the users that you created above, following steps need to be performed with kubectl

    Add credentials in the configurations

    Set context to login as a user to a cluster

    Switch context in order to assume the user's identity while working with the cluster

to add credentials,

    kubectl config set-credentials maya --client-certificate=/absolute/path/to/maya.crt --client-key=/absolute/path/to/maya.key
     
    kubectl config set-credentials kim --client-certificate=/absolute/path/to/kim.crt --client-key=~/.kube/users/kim.key
     
    kubectl config set-credentials yono --client-certificate=/absolute/path/to/yono.crt --client-key=~/.kube/users/yono.key
     

where,

    Replace /absolute/path/to/ with the path to these files.

        invalid : ~/.kube/users/yono.crt

        valid : /home/xyz/.kube/users/yono.crt

And proceed to set/create contexts (user@cluster). If you are not sure whats the cluster name, use the following command to find,

    kubectl config get-contexts
     

[sample output]

    CURRENT   NAME                          CLUSTER         AUTHINFO              NAMESPACE
              admin-prod           prod   admin-cluster.local   instavote
              admin-cluster4                cluster4        admin-cluster4        instavote
    *         kubernetes-admin@kubernetes   kubernetes      kubernetes-admin      instavote

where, prod, cluster4 and kubernetes are cluster names.

To set context for prod cluster,

    kubectl config set-context maya-prod --cluster=prod  --user=maya --namespace=instavote
     
    kubectl config set-context kim-prod --cluster=prod  --user=kim --namespace=instavote
     
    kubectl config set-context yono-prod --cluster=prod  --user=yono --namespace=instavote
     

Where,

    maya-prod : name of the context

    prod : name of the kubernetes cluster you set while creating it

    maya : user you created and configured above to connect to the cluster

You could verify the configs with

    kubectl config get-contexts
     
    CURRENT   NAME         CLUSTER   AUTHINFO     NAMESPACE
    *         admin-prod   prod      admin-prod
              kim-prod     prod      kim
              maya-prod    prod      maya
              yono-prod    prod      yono

and

    kubectl config view
     
    apiVersion: v1
    clusters:
    - cluster:
       certificate-authority-data: REDACTED
       server: https://128.199.248.240:6443
     name: prod
    contexts:
    - context:
       cluster: prod
       user: admin-prod
     name: admin-prod
    - context:
       cluster: prod
       user: kim
     name: kim-prod
    - context:
       cluster: prod
       user: maya
     name: maya-prod
    - context:
       cluster: prod
       user: yono
     name: yono-prod
    current-context: admin-prod
    kind: Config
    preferences: {}
    users:
    - name: admin-prod
     user:
       client-certificate-data: REDACTED
       client-key-data: REDACTED
    - name: maya
     user:
       client-certificate: users/~/.kube/users/maya.crt
       client-key: users/~/.kube/users/maya.key

You could assume the identity of user yono and connect to the prod cluster as,

    kubectl config use-context yono-prod
     
    kubectl config get-contexts
     
    CURRENT   NAME         CLUSTER   AUTHINFO     NAMESPACE
              admin-prod   prod      admin-prod
              kim-prod     prod      kim
              maya-prod    prod      maya
    *         yono-prod    prod      yono

And then try running any command as,

    kubectl get pods

Alternately, if you are a admin user, you could impersonate a user and run a command with that literally using --as option

    kubectl config use-context admin-prod
    kubectl get pods --as yono

[Sample Output]

    No resources found.
    Error from server (Forbidden): pods is forbidden: User "yono" cannot list pods in the namespace "instavote"
     

Either ways, since there are authorization rules set, the user can not make any api calls. Thats when you would create some roles and bind it to the users in the next section.

# LAB: Defining authorisation rules with Roles and ClusterRoles
Define authorisation rules with Roles and ClusterRoles

Whats the difference between Roles and ClusterRoles ??

    Role is limited to a namespace (Projects/Orgs/Env)

    ClusterRole is Global

Lets say you want to provide read only access to instavote, a project specific namespace to all users in the example.org

file: interns-role.yaml

    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: Role
    metadata:
      namespace: instavote
      name: interns
    rules:
    - apiGroups: ["*"]
      resources: ["*"]
      verbs: ["get", "list", "watch"]

In order to map it to all users in example.org, create a RoleBinding as

interns-rolebinding.yml

    kind: RoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: interns
      namespace: instavote
    subjects:
    - kind: Group
      name: interns
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: Role
      name: interns
      apiGroup: rbac.authorization.k8s.io

    kubectl create -f interns-role.yml
     
    kubectl create -f interns-rolebinding.yml

To gt information about the objects created above,

    kubectl get roles -n instavote
    kubectl get roles,rolebindings -n instavote
     
    kubectl describe role interns
    kubectl describe rolebinding interns
     

To validate the access,

    kubectl config use-context yono-prod
    kubectl get pods
     

To switch back to admin,

    kubectl config use-context admin-prod
     

Exercise

Create a Role and Rolebinding for dev group with the authorizations defined in the table above. Once applied, test it

# Exercise

1. Generate certificates for the follwoing user table

User       Group    Namespace     Resources                                         Access Types

Mike         Ops          all                     all                 get, list, watch, update, patch, create, delete, deletecollection

Vitos         Test         test                   all                 get, list, watch, update, patch, create, delete

Dimash    Dev          dev                   all                 get, list, watch   

2. Create kubeconfig files and set contexts for the above mentioned table.

3. Grant extra priviliges for the user Dimash to get,list and watch resources on test namespace.

4. Create a cluster role with the following properties.

    name: config-reader
    resources: configmaps
    verbs: get, watch and list

Create a Cluster Role Binding which allows user Dave to use this Cluster Role.

# LAB: Using NodeSelector
Advanced Pod Scheduling

In the Kubernetes bootcamp training, we have seen how to create a pod and and some basic pod configurations to go with it. But this chapter explains some advanced topics related to pod scheduling.

From the api document for version 1.11 following are the pod specs which are relevant from scheduling perspective.

    nodeSelector

    nodeName

    affinity

    schedulerName

    tolerations

Using Node Selectors

    kubectl get nodes --show-labels
     
    kubectl label nodes <node-name> zone=aaa
     
    kubectl get nodes --show-labels
     

e.g.

    kubectl label nodes node1 zone=bbb
    kubectl label nodes node2 zone=bbb
    kubectl label nodes node3 zone=aaa
    kubectl label nodes node4 zone=aaa
    kubectl get nodes --show-labels

[sample output]

    NAME      STATUS    ROLES         AGE       VERSION   LABELS
    node1     Ready     master,node   22h       v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node1,node-role.kubernetes.io/master=true,node-role.kubernetes.io/node=true,zone=bbb
    node2     Ready     master,node   22h       v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node2,node-role.kubernetes.io/master=true,node-role.kubernetes.io/node=true,zone=bbb
    node3     Ready     node          22h       v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node3,node-role.kubernetes.io/node=true,zone=aaa
    node4     Ready     node          21h       v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node4,node-role.kubernetes.io/node=true,zone=aaa

Check how the pods are distributed on the nodes using the following command,

    kubectl get pods -o wide --selector="role=vote"
    NAME                    READY     STATUS    RESTARTS   AGE       IP               NODE
    vote-5d88d47fc8-6rflg   1/1       Running   0          1m        10.233.75.9      node2
    vote-5d88d47fc8-gbzbq   1/1       Running   0          1h        10.233.74.76     node4
    vote-5d88d47fc8-q4vj6   1/1       Running   0          1h        10.233.102.133   node1
    vote-5d88d47fc8-znd2z   1/1       Running   0          1m        10.233.71.20     node3

From the above output, you could see that the pods running vote app are currently equally distributed. Now, update pod definition to make it schedule only on nodes in zone bbb

file: k8s-code/pods/vote-pod.yml

    ....
     
    template:
    ...
      spec:
        containers:
          - name: app
            image: schoolofdevops/vote:v1
            ports:
              - containerPort: 80
                protocol: TCP
        nodeSelector:
          zone: 'bbb'

For this change, pod needs to be re created.

    kubectl apply -f vote-pod.yml

You would notice that, the moment you make that change, a new rollout kicks off, which will start redistributing the pods, now following the nodeSelector constraint that you added.

Watch the output of the following command

    watch kubectl get pods -o wide --selector="role=vote"
     

You will see the following while it transitions

    NAME                        READY     STATUS              RESTARTS   AGE       IP               NODE
    pod/vote-5d88d47fc8-6rflg   0/1       Terminating         0          5m        10.233.75.9      node2
    pod/vote-5d88d47fc8-gbzbq   0/1       Terminating         0          1h        10.233.74.76     node4
    pod/vote-5d88d47fc8-q4vj6   0/1       Terminating         0          1h        10.233.102.133   node1
    pod/vote-67d7dd8f89-2w5wl   1/1       Running             0          44s       10.233.75.10     node2
    pod/vote-67d7dd8f89-gm6bq   0/1       ContainerCreating   0          2s        <none>           node2
    pod/vote-67d7dd8f89-w87n9   1/1       Running             0          44s       10.233.102.134   node1
    pod/vote-67d7dd8f89-xccl8   1/1       Running             0          44s       10.233.102.135   node1
     

and after the rollout completes,

    NAME                    READY     STATUS    RESTARTS   AGE       IP               NODE
    vote-67d7dd8f89-2w5wl   1/1       Running   0          2m        10.233.75.10     node2
    vote-67d7dd8f89-gm6bq   1/1       Running   0          1m        10.233.75.11     node2
    vote-67d7dd8f89-w87n9   1/1       Running   0          2m        10.233.102.134   node1
    vote-67d7dd8f89-xccl8   1/1       Running   0          2m        10.233.102.135   node1
     

Exercise

Just like nodeSelector above, you could enforce a pod to run on a specific node using nodeName. Try using that property to run all pods for results application on node3

# LAB: Defining Node Affinity
Defining affinity and anti-affinity

We have discussed about scheduling a pod on a particular node using NodeSelector, but using node selector is a hard condition. If the condition is not met, the pod cannot be scheduled. Node/Pod affinity and anti-affinity solves this issue by introducing soft and hard conditions.

    required

    preferred

    DuringScheduling

    DuringExecution

Operators

    In

    NotIn

    Exists

    DoesNotExist

    Gt

    Lt

Node Affinity

Examine the current pod distribution

    kubectl get pods -o wide --selector="role=vote"
     

    NAME                    READY     STATUS    RESTARTS   AGE       IP               NODE
    vote-8546bbd84d-22d6x   1/1       Running   0          35s       10.233.102.137   node1
    vote-8546bbd84d-8f9bc   1/1       Running   0          1m        10.233.102.136   node1
    vote-8546bbd84d-bpg8f   1/1       Running   0          1m        10.233.75.12     node2
    vote-8546bbd84d-d8j9g   1/1       Running   0          1m        10.233.75.13     node2

and node labels

    kubectl get nodes --show-labels
     

    NAME      STATUS    ROLES         AGE       VERSION   LABELS
    node1     Ready     master,node   1d        v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node1,node-role.kubernetes.io/master=true,node-role.kubernetes.io/node=true,zone=bbb
    node2     Ready     master,node   1d        v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node2,node-role.kubernetes.io/master=true,node-role.kubernetes.io/node=true,zone=bbb
    node3     Ready     node          1d        v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node3,node-role.kubernetes.io/node=true,zone=aaa
    node4     Ready     node          1d        v1.10.4   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/hostname=node4,node-role.kubernetes.io/node=true,zone=aaa

Lets create node affinity criteria as

    Pods for vote app must not run on the master nodes

    Pods for vote app preferably run on a node in zone bbb

First is a hard affinity versus second being soft affinity.

file: vote-deploy.yaml

    ....
      template:
    ....
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v1
              ports:
                - containerPort: 80
                  protocol: TCP
     
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: node-role.kubernetes.io/master
                    operator: DoesNotExist
              preferredDuringSchedulingIgnoredDuringExecution:
                - weight: 1
                  preference:
                    matchExpressions:
                    - key: zone



# LAB: Defining affinity between applications with PodAffinity
Pod Affinity

Lets define pod affinity criteria as,

    Pods for vote and redis should be co located as much as possible (preferred)

    No two pods with redis app should be running on the same node (required)

    kubectl get pods -o wide --selector="role in (vote,redis)"
     

[sample output]

    NAME                     READY     STATUS    RESTARTS   AGE       IP               NODE
    redis-6555998885-4k5cr   1/1       Running   0          4h        10.233.71.19     node3
    redis-6555998885-fb8rk   1/1       Running   0          4h        10.233.102.132   node1
    vote-74c894d6f5-bql8z    1/1       Running   0          22m       10.233.74.78     node4
    vote-74c894d6f5-nnzmc    1/1       Running   0          21m       10.233.71.22     node3
    vote-74c894d6f5-ss929    1/1       Running   0          22m       10.233.74.77     node4
    vote-74c894d6f5-tpzgm    1/1       Running   0          22m       10.233.71.21     node3

file: vote-deploy.yaml

    ...
        template:
    ...
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote:v1
              ports:
                - containerPort: 80
                  protocol: TCP
     
          affinity:
    ...
     
            podAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
                - weight: 1
                  podAffinityTerm:
                    labelSelector:
                      matchExpressions:
                      - key: role
                        operator: In
                        values:
                        - redis
                    topologyKey: kubernetes.io/hostname

file: redis-deploy.yaml

    ....
      template:
    ...
        spec:
          containers:
          - image: schoolofdevops/redis:latest
            imagePullPolicy: Always
            name: redis
            ports:
            - containerPort: 6379
              protocol: TCP
          restartPolicy: Always
     
          affinity:
            podAntiAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                  - key: role
                    operator: In
                    values:
                    - redis
                topologyKey: "kubernetes.io/hostname"

apply

    kubectl apply -f redis-deploy.yaml
    kubectl apply -f vote-deploy.yaml
     

check the pods distribution

    kubectl get pods -o wide --selector="role in (vote,redis)"

[sample output ]

    NAME                     READY     STATUS    RESTARTS   AGE       IP             NODE
    redis-5bf748dbcf-gr8zg   1/1       Running   0          13m       10.233.75.14   node2
    redis-5bf748dbcf-vxppx   1/1       Running   0          13m       10.233.74.79   node4
    vote-56bf599b9c-22lpw    1/1       Running   0          12m       10.233.74.80   node4
    vote-56bf599b9c-nvvfd    1/1       Running   0          13m       10.233.71.25   node3
    vote-56bf599b9c-w6jc9    1/1       Running   0          13m       10.233.71.23   node3
    vote-56bf599b9c-ztdgm    1/1       Running   0          13m       10.233.71.24   node3

Observations from the above output,

    Since redis has a hard constraint not to be on the same node, you would observe redis pods being on differnt nodes (node2 and node4)

    since vote app has a soft constraint, you see some of the pods running on node4 (same node running redis), others continue to run on node 3

If you kill the pods on node3, at the time of scheduling new ones, scheduler meets all affinity rules

    $ kubectl delete pods vote-56bf599b9c-nvvfd vote-56bf599b9c-w6jc9 vote-56bf599b9c-ztdgm
    pod "vote-56bf599b9c-nvvfd" deleted
    pod "vote-56bf599b9c-w6jc9" deleted
    pod "vote-56bf599b9c-ztdgm" deleted
     
     
    $ kubectl get pods -o wide --selector="role in (vote,redis)"
    NAME                     READY     STATUS    RESTARTS   AGE       IP             NODE
    redis-5bf748dbcf-gr8zg   1/1       Running   0          19m       10.233.75.14   node2
    redis-5bf748dbcf-vxppx   1/1       Running   0          19m       10.233.74.79   node4
    vote-56bf599b9c-22lpw    1/1       Running   0          19m       10.233.74.80   node4
    vote-56bf599b9c-4l6bc    1/1       Running   0          20s       10.233.74.83   node4
    vote-56bf599b9c-bqsrq    1/1       Running   0          20s       10.233.74.82   node4
    vote-56bf599b9c-xw7zc    1/1       Running   0          19s       10.233.74.81   node4


# LAB: Using Taints and Tolerations
Taints and tolerations

    Affinity is defined for pods

    Taints are defined for nodes

You could add the taints with criteria and effects. Effetcs can be

Taint Specs:

    effect

        NoSchedule

        PreferNoSchedule

        NoExecute

    key

    value

    timeAdded (only written for NoExecute taints)

Observe the pods distribution

    $ kubectl get pods -o wide
    NAME                      READY     STATUS    RESTARTS   AGE       IP             NODE
    db-66496667c9-qggzd       1/1       Running   0          4h        10.233.74.74   node4
    redis-5bf748dbcf-gr8zg    1/1       Running   0          27m       10.233.75.14   node2
    redis-5bf748dbcf-vxppx    1/1       Running   0          27m       10.233.74.79   node4
    result-5c7569bcb7-4fptr   1/1       Running   0          4h        10.233.71.18   node3
    result-5c7569bcb7-s4rdx   1/1       Running   0          4h        10.233.74.75   node4
    vote-56bf599b9c-22lpw     1/1       Running   0          26m       10.233.74.80   node4
    vote-56bf599b9c-4l6bc     1/1       Running   0          8m        10.233.74.83   node4
    vote-56bf599b9c-bqsrq     1/1       Running   0          8m        10.233.74.82   node4
    vote-56bf599b9c-xw7zc     1/1       Running   0          8m        10.233.74.81   node4
    worker-7c98c96fb4-7tzzw   1/1       Running   1          4h        10.233.75.8    node2

Lets taint a node.

    kubectl taint node node2 dedicated=worker:NoExecute

after taining the node

    $ kubectl get pods -o wide
    NAME                      READY     STATUS    RESTARTS   AGE       IP               NODE
    db-66496667c9-qggzd       1/1       Running   0          4h        10.233.74.74     node4
    redis-5bf748dbcf-ckn65    1/1       Running   0          2m        10.233.71.26     node3
    redis-5bf748dbcf-vxppx    1/1       Running   0          30m       10.233.74.79     node4
    result-5c7569bcb7-4fptr   1/1       Running   0          4h        10.233.71.18     node3
    result-5c7569bcb7-s4rdx   1/1       Running   0          4h        10.233.74.75     node4
    vote-56bf599b9c-22lpw     1/1       Running   0          29m       10.233.74.80     node4
    vote-56bf599b9c-4l6bc     1/1       Running   0          11m       10.233.74.83     node4
    vote-56bf599b9c-bqsrq     1/1       Running   0          11m       10.233.74.82     node4
    vote-56bf599b9c-xw7zc     1/1       Running   0          11m       10.233.74.81     node4
    worker-7c98c96fb4-46ltl   1/1       Running   0          2m        10.233.102.140   node1

All pods running on node2 just got evicted.

Add toleration in the Deployment for worker.

File: worker-deploy.yml

    apiVersion: apps/v1
    .....
      template:
    ....
        spec:
          containers:
            - name: app
              image: schoolofdevops/vote-worker:latest
     
          tolerations:
            - key: "dedicated"
              operator: "Equal"
              value: "worker"
              effect: "NoExecute"

apply

    kubectl apply -f worker-deploy.yml
     

Observe the pod distribution now.

    $ kubectl get pods -o wide
    NAME                      READY     STATUS    RESTARTS   AGE       IP             NODE
    db-66496667c9-qggzd       1/1       Running   0          4h        10.233.74.74   node4
    redis-5bf748dbcf-ckn65    1/1       Running   0          3m        10.233.71.26   node3
    redis-5bf748dbcf-vxppx    1/1       Running   0          31m       10.233.74.79   node4
    result-5c7569bcb7-4fptr   1/1       Running   0          4h        10.233.71.18   node3
    result-5c7569bcb7-s4rdx   1/1       Running   0          4h        10.233.74.75   node4
    vote-56bf599b9c-22lpw     1/1       Running   0          30m       10.233.74.80   node4
    vote-56bf599b9c-4l6bc     1/1       Running   0          12m       10.233.74.83   node4
    vote-56bf599b9c-bqsrq     1/1       Running   0          12m       10.233.74.82   node4
    vote-56bf599b9c-xw7zc     1/1       Running   0          12m       10.233.74.81   node4
    worker-6cc8dbd4f8-6bkfg   1/1       Running   0          1m        10.233.75.15   node2

You should see worker being scheduled on node2

To remove the taint created above

    kubectl taint node node2 dedicate:NoExecute-
    
  # Exercise

1. In your Kubernetes cluster, Label one node with the label frontend and schedule the frontend deployment in the frontend node.

    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: frontend
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: frontend
            role: ui
        spec:
          containers:
          - image: schoolofdevops/frontend:latest
            imagePullPolicy: Always
            name: front-end
            ports:
            - containerPort: 8079
              protocol: TCP
            resources:
              requests:
                memory: "128Mi"
                cpu: "250m"
              limits:
                memory: "256Mi"
                cpu: "500m"
        [...]

2. Schedule the catalogue pods in the same node as frontend pod.

    kind: Deployment
    metadata:
      name: catalogue
      labels:
        app: catalogue
        env: dev
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: catalogue
      template:
        metadata:
          labels:
            app: catalogue
            env: dev
        spec:
          containers:
            - name: catalogue
              image: schoolofdevops/catalogue:v2
              imagePullPolicy: Always
              ports:
                - containerPort: 80

3. Make one of the node(ex. node 2) as unschedulable. Only carts pods should be schedulable on that node.

    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: carts
      labels:
        app: carts
        env: dev
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: carts
            env: dev
        spec:
          containers:
            - name: carts
              image: schoolofdevops/carts
              imagePullPolicy: Always
              ports:
                - containerPort: 80
# LAB 1: Helm Package Manager
Helm Package Manager

Install Helm

To install helm you can follow following instructions.

     curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
     chmod 700 get_helm.sh
     ./get_helm.sh

Verify the installtion is successful,

    helm --help

Set RBAC for Tiller

file: tiller-rbac.yaml

    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: tiller
      namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
      name: tiller
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: cluster-admin
    subjects:
      - kind: ServiceAccount
        name: tiller
        namespace: kube-system

Apply the ClusterRole and ClusterRoleBinding.

    kubectl apply -f tiller-rbac.yaml

Initialize


This is where we actually initialize Tiller in our Kubernetes cluster.

    helm init --service-account tiller

[sample output]

    Creating /root/.helm
    Creating /root/.helm/repository
    Creating /root/.helm/repository/cache
    Creating /root/.helm/repository/local
    Creating /root/.helm/plugins
    Creating /root/.helm/starters
    Creating /root/.helm/cache/archive
    Creating /root/.helm/repository/repositories.yaml
    Adding stable repo with URL: https://kubernetes-charts.storage.googleapis.com
    Adding local repo with URL: http://127.0.0.1:8879/charts
    $HELM_HOME has been configured at /root/.helm.
     
    Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.
     
    Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
    For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
    Happy Helming!
    
  # LAB 2: Install Wordpress with Helm
Install Wordpress with Helm

Search Helm repository for Wordpress chart

    helm search wordpress

Fetch the chart to your local environment and change directory.

    helm fetch --untar stable/wordpress
    cd wordpress

Create a copy of default vaules file and edit it.

    cp values.yaml my-values.yaml
    vim my-values.yaml

Run it as a dry run to check for errors.

    helm install --name blog --values my-values.yaml . --dry-run

Deploy the Wordpress stack.

    helm install --name blog --values my-values.yaml .
    
  # LAB 3: Install Prometheus with Helm
Install Prometheus with Helm

Official Prometheus Helm Chart repository.

https://github.com/helm/charts/tree/master/stable/prometheus


Official Grafana Helm Chart repository.

https://github.com/helm/charts/tree/master/stable/grafana

Grafana Deployment

Download Grafana charts to your local machine and change directory.

    helm fetch --untar stable/grafana
    cd grafana

Create a copy of default vaules file and edit it.

    cp values.yaml myvalues.yaml
    vim myvalues.yaml

Make sure your charts doesn't have any error.

helm install --name grafana --values myvalues.yaml --namespace instavote . --dry-run

Deploy Grafana on your K8s Cluster.

helm install --name grafana --values myvalues.yaml --namespace instavote .

Prometheus Deployment

Download Prometheus charts to your local machine and change directory.

    helm fetch --untar stable/prometheus
    cd prometheus

Create a copy of default vaules file and edit it.

    cp values.yaml myvalues.yaml
    vim myvalues.yaml

Make sure your charts doesn't have any error.

helm install --name prometheus --values myvalues.yaml --namespace instavote . --dry-run

Deploy Prometheus on your K8s Cluster.

    helm install --name prometheus --values myvalues.yaml --namespace instavote .



# Exercise

1. Install Jypterhub using Helm.

Reference: Install Jupterhub using Helm

2. Create helm charts for the Deployments and Services we have created for frontend and catalogue in the previous chapters.

3. Create your own repository for helm charts on github and use it as one of the helm repositories.


