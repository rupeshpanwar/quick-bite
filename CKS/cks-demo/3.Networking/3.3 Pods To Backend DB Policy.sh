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
 