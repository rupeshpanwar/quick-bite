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
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
