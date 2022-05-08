<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>


<details>
<summary>Play with PODS</summary>
<br>

  ```
       k run hello-ctr --image nginx --port 8080
  521  k get pods -w
  522  k get pods -o wide
  525  k get pods hello-ctr -o yaml
  528  k describe pods hello-ctr
  531  k exec hello-ctr -- ps aux
  532  k exec hello-ctr -- ls .
  533  k exec hello-ctr -it -- sh
  534  k logs hello-ctr
  535  k delete pod hello-ctr
  ```
</details>

<details>
<summary>Deployment</summary>
<br>

  ```
    544  k -f deploy.yml create
  547  kubectl get deploy hello-deploy
  548  kubectl describe deploy hello-deploy
  
  549  kubectl get rs
  550  kubectl describe rs hello-deploy-65cbc9474c
  
  551  vi svc.yaml
  553  kubectl -f svc.yaml create
  554  kubectl get svc
  555  kubectl get svc -o wide
  
  556  curl 10.84.6.156:30001
  557  curl http://10.84.6.156:30001
  
  558  k get pods -o wide
  559  curl gke-cluster-cka-default-pool-13966d3c-crgq:30001
  561  ping 10.80.2.7
  562  curl http://10.80.2.7:30001
  
  564  vi deploy.yml
  565  kubectl -f deploy.yml apply
  566  kubectl rollout status deploy hello-deploy --record

  568  kubectl get deploy

  571  kubectl rollout history deploy hello-deploy

  576  kubectl get rs
  577  kubectl describe rs hello-deploy-59866ff45
  
  579  kubectl rollout history deploy hello-deploy
  580  kubectl rollout undo deploy hello-deploy --to-revision=2
  581  kubectl rollout status deploy hello-deploy
  582  kubectl get deploy
  583  kubectl get rs
  584  kubectl get svc
  585  kubectl delete -f deploy.yml -f svc.yaml
  586  kubectl get deploy,svc,pods
  ```
</details>

<details>
<summary>Service</summary>
<br>

  ```
  610  kubectl expose deploy web-deploy --name web-svc --target-port 8080 --type NodePort
  611  k get svc
  612  k describe svc web-svc
  613  k -f dummydep.yml delete
  614  k delete svc web-svc
  615  k -f dummydep.yml create
  616  vi dummysvc.yml
  617  k -f dummysvc.yml create
  618  k delete svc hello-svc
  619  k delete deploy web-deploy
  622  kubectl get all -n kube-system | grep dns
  623  kubectl get all -n kube-system -o wide | grep dns
  624  kubectl describe service/kube-dns
  625  kubectl describe svc service/kube-dns
  626  kubectl describe svc service/kube-dns -n kube-system
  627  kubectl describe svc kube-dns -n kube-system
  628  kubectl get ep kube-dns -n kube-system
  630  vi sdexam.yml
  631  k -f sdexam.yml create
  632  k get all -n dev
  633  k get all -n dev
  634  k get all -n prod
  635  k exec -it jump -n dev -- bash
  636  kubectl get all -n kube-system | grep dns
  637  kubectl logs kube-dns-697dc8fc8b-kc4gt -n kube-system
  638  kubectl logs pod/kube-dns-697dc8fc8b-kc4gt -n kube-system
  639  kubectl logs pod/kube-dns-697dc8fc8b-chmm2 -n kube-system
  640  kubectl logs pod  pod/kube-dns-697dc8fc8b-chmm2 -n kube-system
  641  kubectl logs pod/kube-dns-697dc8fc8b-chmm2 --container kubedns -n kube-system
  642  kubectl get all -n kube-system | grep dns
  644  kubectl get service/kube-dns -n kube-system
  645  kubectl get ep kube-dns -n kube-system
  648  kubectl run -it dnsutils --image gcr.io/kubernetes-e2e-test-images/dnsutils:1.3
  649  kubectl get svc kubernetes
  ```
</details>

<details>
<summary>Configmap</summary>
<br>

  ```
  kubectl create cm testmap1 --from-literal shortname=msb.com --from-literal longname=magicbox.com
  695  kubectl get cm
  696  kubectl get cm testmap1
  697  kubectl describe cm testmap1
  698  echo  "this configmap from a file" > configmapfile.txt
  699  ls
  700  k create cm fileconfigmap --from-file configmapfile.txt
  701  k get cm
  702  k describe cm fileconfigmap
  703  k get cm configmapfile.txt -o yaml
  704  k get configmap fileconfigmap -o yaml
  705  vi multimap.yaml
  706* k -f multimap.yaml creat
  707  vi confmap.yaml
  708  k -f confmap.yaml create
  709  k get cm
  710  k describe cm test-conf -o yaml
  711  k describe cm test-conf -o yaml
  712  k describe cm test-conf
  713  vi multimap.yaml
  714  vi envconfigmap.yaml
  715  k -f envconfigmap.yaml create
  716  k get pods
  717  k exec envpod -- env | grep NAME
  718  k get pods
  719  vi envconfigmap.yaml
  720  k -f envconfigmap.yaml apply
  721  k -f envconfigmap.yaml apply
  722  k -f envconfigmap.yaml create
  723  k get pods
  724  k exec envpod -- env | grep NAME
  725  k describe pod envpod
  726  k logs  envpod
  727  k logs  envpod -c args1
  728  vi argsconfigmap.yaml
  729  k -f argsconfigmap.yaml create
  730  vi argscm.yaml
  731  k -f argscm.yaml create
  732  k delete pod envpod
  733  k -f argscm.yaml create
  734  k get pods
  735  k logs envpod -- env | grep NAME
  736  k logs envpod -c args1
  737  k logs envpod
  738  vi volconfigmap.yaml
  739  k -f volconfigmap.yaml create
  740  k get pods
  741  k get pods
  742  k exec cmvol -- ls /etc/name
  743  k exec cmvol -it -- bash
  ```
</details>

<details>
<summary>Statefulset</summary>
<br>

  ```
    vi app.yaml
  746  vi gcp-sc.yaml
  747  kubectl -f gcp-sc.yaml create
  748  kubectl get sc
  749  vi headless-svc.yml
  750  k -f headless-svc.yml create
  751  k get svc
  752  k get ep
  753  vi sts.yml
  754  k -f sts.yml create
  755  k get sts -w
  756  k get pvc
  757  k get ep
  758  vi jumpingpod.yml
  759  k -f jumpingpod.yml create
  760  k get pods
  761  k get pods
  762  k get pods
  763  k exec jump-pod -it -- bash
  764  vi sts.yml
  765  k -f sts.yml apply
   vi sts.yml
  765  k -f sts.yml apply
  766  k create --save-config sts.yml
  767  k create --save-config sts.yml -f
  768  k create --save-config -f sts.yml
  769  k apply --save-config -f sts.yml
  770  k apply -f sts.yml --save-config
  771  k apply -f sts.yml
  772  k get sts -w
  773  k get sts -w
  774  k get pods -w
  775  k get pvc
  776  k get sts
  777  k get rs
  778  k describe pvc pvc-643aeae2-834f-45cf-8b8a-790754b8c9f1 | grep Mounted
  779  k describe pvc webroot-tkb-sts-2 | grep Mounted
  780  k describe pvc webroot-tkb-sts-2 | grep M
  781  kubectl explain sts.spec.updateStrategy
  782  k get pods
  783  k delete pod tkb-sts-0
  784  k get pods -w
  785  k describe pod tkb-sts-0 | grep ClaimName
  786  k scale sts --replicas 0
  787  k scale sts tkb-sts --replicas=0
  788  k get pods -w
  789  k get sts
  790  k delete sts tkb-sts
  ```
</details>

