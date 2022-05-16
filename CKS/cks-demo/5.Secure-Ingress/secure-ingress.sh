# delete prev created resources
  k -f default-policy.yml delete
  k -f crassanda-deny.yml  delete
k get pods
k delete ns crassanda

# create nginx resources
wget https://github.com/rupeshpanwar/cks-course-environment/raw/master/course-content/cluster-setup/secure-ingress/nginx-ingress-controller.yaml

k -f nginx-ingress-controller.yaml create

namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created

# list the resources and ns
k get ns

 k -n ingress-nginx get pods,svc

 NAME                   STATUS   AGE
default                Active   6d5h
ingress-nginx          Active   3m45s
kube-node-lease        Active   6d5h
kube-public            Active   6d5h
kube-system            Active   6d5h
kubernetes-dashboard   Active   101m

NAME                                            READY   STATUS      RESTARTS   AGE
pod/ingress-nginx-admission-create-sr6gh        0/1     Completed   0          4m3s
pod/ingress-nginx-admission-patch-wlg52         0/1     Completed   1          4m3s
pod/ingress-nginx-controller-65c848c6b5-9sld8   1/1     Running     0          4m3s

NAME                                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/ingress-nginx-controller             NodePort    10.111.2.1   <none>        80:31902/TCP,443:31485/TCP   4m3s
service/ingress-nginx-controller-admission   ClusterIP   10.96.20.2     <none>        443/TCP                      4m3s

# check the ingress resource 
 k get ing

# access the nodeport via worker node public-ip
 curl http://35.240.145.48:31902

 # create 2 services for routes 
wget https://github.com/rupeshpanwar/cks-course-environment/raw/master/course-content/cluster-setup/secure-ingress/secure-ingress-step1.yaml

  k -f secure-ingress-step1.yaml create

# let us now create 2 pods and expose to these 2 services created above
k run pod1 --image=nginx
k run pod2 --image=httpd

k expose pod pod1 --port 80 --name service1
k expose pod pod2 --port 80 --name service2

# Now access the services via worker node public-ip
curl http://35.240.145.48:31902/service1
curl http://35.240.145.48:31902/service2


# Secure Ingress Process

 k get svc -n ingress-nginx

 NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             NodePort    10.111.232.132   <none>        80:31902/TCP,443:31485/TCP   64m
ingress-nginx-controller-admission   ClusterIP   10.96.20.220     <none>        443/TCP                      64m

# curl the https port 

curl https://35.240.145.48:31485/service2 -kv

* Server certificate:
*  subject: O=Acme Co; CN=Kubernetes Ingress Controller Fake Certificate
*  start date: Mar  5 15:36:18 2022 GMT
*  expire date: Mar  5 15:36:18 2023 GMT
*  issuer: O=Acme Co; CN=Kubernetes Ingress Controller Fake Certificate
*  SSL certificate verify result: unable to get local issuer certificate (20), continuing anyway.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)

# generate cert & key
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
	# Common Name: secure-ingress.com

oot@cks-master:~# ls
Dockerfile   crassanda-deny.yml  frontend.yml                   secure-ingress-step1.yaml
backend.yml  crassanda.yml       key.pem                        secure-ingress-step2.yaml
cert.pem     default-policy.yml  nginx-ingress-controller.yaml

# now create secret in K8s

root@cks-master:~# k create secret tls secure-ingress --cert=cert.pem --key=key.pem
secret/secure-ingress created

root@cks-master:~# k get ing,secret
NAME                                       CLASS   HOSTS   ADDRESS      PORTS   AGE
ingress.networking.k8s.io/secure-ingress   nginx   *       10.148.0.3   80      39m

NAME                         TYPE                                  DATA   AGE
secret/default-token-vzx4x   kubernetes.io/service-account-token   3      6d6h
secret/secure-ingress        kubernetes.io/tls                     2      3s

# edit the ingress file

wget https://github.com/rupeshpanwar/cks-course-environment/raw/master/course-content/cluster-setup/secure-ingress/secure-ingress-step2.yaml

k -f apply

# curl the site again
curl https://secure-ingress.com:31485/service2 -k --resolve secure-ingress.com:31485:35.240.145.48

