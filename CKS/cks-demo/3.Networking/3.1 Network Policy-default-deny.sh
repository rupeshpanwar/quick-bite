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