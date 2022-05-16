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

