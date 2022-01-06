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

