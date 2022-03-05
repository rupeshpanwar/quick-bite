- https://kubernetes.io/docs/concepts/services-networking/network-policies/



<details>
<summary>Introduction</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156877486-eb4af612-b7cc-431c-985d-492f4a56e04c.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/156877522-bef1a179-84b7-4e6a-bb7e-9138117f0b1d.png)

  ## Network Policy rule
  
  ![image](https://user-images.githubusercontent.com/75510135/156877638-2bca7589-3187-4c98-884b-2bb50983f3db.png)

  ![image](https://user-images.githubusercontent.com/75510135/156877660-710add6a-043f-46cd-b8af-e202e61dc62f.png)

  ![image](https://user-images.githubusercontent.com/75510135/156877688-8a9d0f18-d5fd-48dd-a6f5-769c5e085718.png)

  ![image](https://user-images.githubusercontent.com/75510135/156877706-9eb1247b-56b5-4f99-a55d-f7a3db689909.png)

  
</details>


<details>
<summary>Examples</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156877906-ab3c71ef-d950-4e8e-9266-b7f9ac5e9fae.png)

  ![image](https://user-images.githubusercontent.com/75510135/156877933-9884808f-0562-445e-ba79-258bec66ece8.png)

  ![image](https://user-images.githubusercontent.com/75510135/156877951-fabbb1ac-359e-4a02-9684-f2112fdb87f5.png)

  ![image](https://user-images.githubusercontent.com/75510135/156877967-d8df9462-b160-49b1-9f59-d3d176037b24.png)

  
</details>


<details>
<summary>Default Deny Network Policy</summary>
<br>
  
  ![image](https://user-images.githubusercontent.com/75510135/156878403-2141cc04-572d-4821-b6fe-b87e18fdbd97.png)

  ```
  # get the nodes
k get nodes

# create frontend pod
k run frontend --image=nginx

# create backend pod
k run backend --image=nginx

# expose pods to service to access
k expose pod frontend --port 80

k expose pod backend --port 80

# list pods n service
k get pods,svc

# try to access each pods
k exec frontend -- curl backend

k exec backend -- curl frontend

# create default-deny.yml network policy
# https://kubernetes.io/docs/concepts/services-networking/network-policies/
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress

# create the network policy
k -f default-deny.yml create

# try to access the pods again
k exec frontend -- curl backend
  ```
</details>


<details>
<summary>Allow Network Policy</summary>
<br>

  - Based on POD SELECTOR
  
  ![image](https://user-images.githubusercontent.com/75510135/156879007-21e9f834-2510-4bcb-9df8-2ca16a4c52f6.png)
  
  ```
  # command summary
   110  vi backend.yml
  111  k -f backend.yml apply
  112  k exec backend -- curl 10.44.0.3
  113  ls
  114  cp default-policy.yml crassanda-deny.yml
  115  vi crassanda-deny.yml
  116  k -f crassanda.yml create
  117  k -f crassanda-deny.yml create
  118  cp backend.yml crassanda.yml
  119  vi crassanda.yml
  120  k -f crassanda.yml create
  121  vi edit ns default
  122  ls
  123  ls /tmp/
  124  k ns default create
  125  k create ns default
  126  vi edit ns default
  127  k config view
  128  k edit ns default
  129  k exec backend -- curl 10.44.0.3
  
  # Create Egress policy - frontend.yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: frontend
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
            run: backend

# create the policy for frontend
k -f frontend.yml create

# Create Ingress policy - frontend.yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
            run: frontend
 
 # create the policy for frontend
k -f frontend.yml create

# check the connectivity 

k exec frontend -- curl backend

# get the ip of pods
k get pod --show-labels -owide

# then try with ip 

k exec frontend -- curl 10.44.0.2

# while reverse connection is not possible 
k exec backend -- curl 10.44.0.1

  ```

</details>



<details>
<summary>Allow Pods to talk to Database pods</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156879831-7666e698-b882-4305-9829-541604142e72.png)
  
  ```
  # create a ns for backend DB - cassandra

k create ns cassandra

# add a label to namespace 
k create ns cassandra
k edit ns cassandra

apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: "2022-03-05T11:01:55Z"
  labels:
    kubernetes.io/metadata.name: cassandra
    ns: cassandra
  name: cassandra
  resourceVersion: "677787"
  uid: b9c41feb-829e-4866-8769-05a6cf305900
spec:
  finalizers:
  - kubernetes
status:
  phase: Active


  # now create the backend in Cassandra ns
  k -n cassandra run cassandra --image=nginx

  # get the ip of backend 
  k -n cassandra get pod cassandra -owide

  # try to curl from backend pod to DB
  k exec backend -- curl 10.44.0.3

  # add egress policy to backend to reach DB pod
  # allows backend pods to have incoming traffic from frontend pods and to cassandra namespace
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: backend
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            run: frontend
  egress:
    - to:
      - namespaceSelector:
          matchLabels:
            ns: cassandra
# now apply the policy
k -f backend.yml apply

# now try to test the connection and it allows the traffic

 k exec backend -- curl 10.44.0.3


# now create default deny for crassanda
cp default-policy.yml crassanda-deny.yml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: crassanda-deny
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress

# create the policy
  k -f crassanda-deny.yml create


# now try to test the connection and it doesn't allow the traffic

 k exec backend -- curl 10.44.0.3

 # let us create Ingress policy for crassand

 cp backend.yml crassanda.yml

 # edit it
 # allows cassandra pods having incoming connection from backend namespace
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cassandra
  namespace: cassandra
spec:
  podSelector:
    matchLabels:
      run: cassandra
  policyTypes:
    - Ingress
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            ns: default

# create now 
k -f crassanda.yml create

##OPS add default label to existing ns
location => "/tmp/kubectl-edit-212103523.yaml"

k edit ns default


apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: "2022-02-27T09:58:30Z"
  labels:
    kubernetes.io/metadata.name: default
    ns: default
  name: default
  resourceVersion: "203"
  uid: 9d6cb88c-e4b8-4629-9bea-2fda7b2f1a30
spec:
  finalizers:
  - kubernetes
status:
  phase: Active


 # test the connectivity 

 k exec backend -- curl 10.44.0.3
 
  ```

</details>



