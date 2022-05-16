# https://github.com/kubernetes/dashboard
# on master node
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

root@cks-master:~# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created


# check new ns get created
k get ns

# check pods, svc under new dashboard
k -n kubernetes-dashboard get pod,svc

# below deployment is created during above installation
k -n kubernetes-dashboard edit deploy kubernetes-dashboard

# below service is created during above installation
k -n kubernetes-dashboard edit svc kubernetes-dashboard

# below service account got created during istallation
k -n kubernetes-dashboard get sa

# to find the view 
k get clusterroles | grep view

# check before creating the resource
k -n kubernetes-dashboard create rolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view -oyaml --dry-run=client

# create RBAC - rolebinding to map to ns kubernetes-dashboard to view the resource under this ns
k -n kubernetes-dashboard create rolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view

# create RBAC - Cluster rolebinding to map to ns kubernetes-dashboard to view ALL clusterwide resource under this ns
k -n kubernetes-dashboard create clusterrolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view

