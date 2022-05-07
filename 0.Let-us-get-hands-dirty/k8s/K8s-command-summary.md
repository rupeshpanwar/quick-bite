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
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
