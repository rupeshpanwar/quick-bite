<img width="894" alt="image" src="https://user-images.githubusercontent.com/75510135/145142966-2d101e95-239a-4ec4-b584-2a2da976a2ee.png">
<img width="780" alt="image" src="https://user-images.githubusercontent.com/75510135/145142991-5f4abeb3-b9c1-49d7-9929-c2b733874ece.png">
<img width="827" alt="image" src="https://user-images.githubusercontent.com/75510135/145143209-c2c03d3f-1765-48e7-a0b4-8ba2a83c6d1b.png">
<img width="638" alt="image" src="https://user-images.githubusercontent.com/75510135/145143363-bb511777-1e27-46fa-8cc3-bc55292f9ef2.png">
<img width="845" alt="image" src="https://user-images.githubusercontent.com/75510135/145143451-62fc8d41-af81-47b8-8f6b-b1538a463edd.png">
<img width="749" alt="image" src="https://user-images.githubusercontent.com/75510135/145143517-7a21af60-2d73-48d6-93b3-547ab0aa1dca.png">
<img width="737" alt="image" src="https://user-images.githubusercontent.com/75510135/145143711-270236d7-abc8-47ec-83b8-6fd507afc261.png">
<img width="749" alt="image" src="https://user-images.githubusercontent.com/75510135/145143739-2efbfca4-148e-45bc-a9ac-6251b9cdf211.png">
```
$ kubectl create deployment web --image nginx -o yaml --dry-run
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: web
  name: web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: web
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
```
```
$ kubectl create namespace awesome-app -o yaml --dry-run
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: awesome-app
spec: {}
status: {}
```
<img width="859" alt="image" src="https://user-images.githubusercontent.com/75510135/145144118-43db7a4e-dd2d-4d24-ba82-4bbc8728460d.png">

- Hardway
<img width="812" alt="image" src="https://user-images.githubusercontent.com/75510135/145144405-326fd77e-9e6f-4622-b7f2-aaa0231458a7.png">

```
$ kubectl api-resources
NAME                              SHORTNAMES   APIGROUP                       NAMESPACED   KIND
bindings                                                                      true         Binding
componentstatuses                 cs                                          false        ComponentStatus
configmaps                        cm                                          true         ConfigMap
endpoints                         ep                                          true         Endpoints
events                            ev                                          true         Event
limitranges                       limits                                      true         LimitRange
namespaces                        ns                                          false        Namespace
nodes                             no                                          false        Node
persistentvolumeclaims            pvc                                         true         PersistentVolumeClaim
persistentvolumes                 pv                                          false        PersistentVolume
pods                              po                                          true         Pod
podtemplates                                                                  true         PodTemplate
replicationcontrollers            rc                                          true         ReplicationController
resourcequotas                    quota                                       true         ResourceQuota
secrets                                                                       true         Secret
serviceaccounts                   sa                                          true         ServiceAccount
services                          svc                                         true         Service
mutatingwebhookconfigurations                  admissionregistration.k8s.io   false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io   false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io           false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io         false        APIService
controllerrevisions                            apps                           true         ControllerRevision
daemonsets                        ds           apps                           true         DaemonSet
deployments                       deploy       apps                           true         Deployment
replicasets                       rs           apps                           true         ReplicaSet
statefulsets                      sts          apps                           true         StatefulSet
tokenreviews                                   authentication.k8s.io          false        TokenReview
localsubjectaccessreviews                      authorization.k8s.io           true         LocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io           false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io           false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io           false        SubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling                    true         HorizontalPodAutoscaler
cronjobs                          cj           batch                          true         CronJob
jobs                                           batch                          true         Job
certificatesigningrequests        csr          certificates.k8s.io            false        CertificateSigningRequest
leases                                         coordination.k8s.io            true         Lease
endpointslices                                 discovery.k8s.io               true         EndpointSlice
events                            ev           events.k8s.io                  true         Event
ingresses                         ing          extensions                     true         Ingress
ingresses                         ing          networking.k8s.io              true         Ingress
networkpolicies                   netpol       networking.k8s.io              true         NetworkPolicy
runtimeclasses                                 node.k8s.io                    false        RuntimeClass
poddisruptionbudgets              pdb          policy                         true         PodDisruptionBudget
podsecuritypolicies               psp          policy                         false        PodSecurityPolicy
clusterrolebindings                            rbac.authorization.k8s.io      false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io      false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io      true         RoleBinding
roles                                          rbac.authorization.k8s.io      true         Role
priorityclasses                   pc           scheduling.k8s.io              false        PriorityClass
csidrivers                                     storage.k8s.io                 false        CSIDriver
csinodes                                       storage.k8s.io                 false        CSINode
storageclasses                    sc           storage.k8s.io                 false        StorageClass
volumeattachments                              storage.k8s.io                 false        VolumeAttachment
```

```
$ kubectl api-versions
admissionregistration.k8s.io/v1
admissionregistration.k8s.io/v1beta1
apiextensions.k8s.io/v1
apiextensions.k8s.io/v1beta1
apiregistration.k8s.io/v1
apiregistration.k8s.io/v1beta1
apps/v1
authentication.k8s.io/v1
authentication.k8s.io/v1beta1
authorization.k8s.io/v1
authorization.k8s.io/v1beta1
autoscaling/v1
autoscaling/v2beta1
autoscaling/v2beta2
batch/v1
batch/v1beta1
certificates.k8s.io/v1beta1
coordination.k8s.io/v1
coordination.k8s.io/v1beta1
discovery.k8s.io/v1beta1
events.k8s.io/v1beta1
extensions/v1beta1
networking.k8s.io/v1
networking.k8s.io/v1beta1
node.k8s.io/v1beta1
policy/v1beta1
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
scheduling.k8s.io/v1
scheduling.k8s.io/v1beta1
storage.k8s.io/v1
storage.k8s.io/v1beta1
v1
```
<img width="750" alt="image" src="https://user-images.githubusercontent.com/75510135/145148137-bcd5193f-e851-4e0e-b9d8-ac3a5372c77b.png">

<img width="716" alt="image" src="https://user-images.githubusercontent.com/75510135/145148742-8d092f40-2f89-4d1f-aaa9-57d12680e734.png">
- Tips
<img width="744" alt="image" src="https://user-images.githubusercontent.com/75510135/145148784-c52b2a6d-54e9-43d6-b42d-bdbf88a6862d.png">

<img width="711" alt="image" src="https://user-images.githubusercontent.com/75510135/145148883-3ba9f203-ea82-438c-8773-48a64d9c23af.png">

<img width="798" alt="image" src="https://user-images.githubusercontent.com/75510135/145148953-4727b036-fcba-4fb8-ac49-4f4d53c9b628.png">

- server , dry-run
<img width="692" alt="image" src="https://user-images.githubusercontent.com/75510135/145149094-a87082b1-b1f4-439f-8903-ab75d6eeeabc.png">

<img width="658" alt="image" src="https://user-images.githubusercontent.com/75510135/145149133-56989596-3f8f-466e-ba37-8d693d8af3e7.png">

<img width="693" alt="image" src="https://user-images.githubusercontent.com/75510135/145149175-eb854179-5ac9-4f40-80ed-67f223c00e36.png">
<img width="743" alt="image" src="https://user-images.githubusercontent.com/75510135/145149645-eeb7b747-c5d3-436f-95a4-0a4f11150d3c.png">
<img width="750" alt="image" src="https://user-images.githubusercontent.com/75510135/145149889-9db1e34d-a632-4a3d-99b1-92da52545d47.png">
- Kubectl Diff
<img width="677" alt="image" src="https://user-images.githubusercontent.com/75510135/145150037-0fa92c43-385c-4339-b36d-438ab9e5c573.png">

<img width="479" alt="image" src="https://user-images.githubusercontent.com/75510135/145150326-1313b195-4e54-4bad-b0b5-85b43c66fa19.png">

```
   13  kubectl apply -f just-a-pod.yaml 
   14  vi just-a-pod.yaml 
   16  kubectl diff -f just-a-pod.yaml 
   ```


