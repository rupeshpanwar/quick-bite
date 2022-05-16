```
Cluster - Autoscaling

517  gcloud container clusters get-credentials devops25 --zone asia-east1-a --project united-option-342608
  518  hostname
  519  git clone https://github.com/rupeshpanwar/k8s-specs.git
  520  k get nodoes
  521  k get nodes
  522  cd k8s-specs/
  523  ls
  524  ls scaling/
  525  cat scaling/go-demo-5-many.yml
  526  kubectl apply     -f scaling/go-demo-5-many.yml     --record
  527  kubectl -n go-demo-5 get hpa
  528  kubectl -n go-demo-5 get hpa
  529  kubectl -n go-demo-5 pods
  530  kubectl -n go-demo-5 get pods
  531  kubectl -n go-demo-5 get pods
  532  kubectl -n go-demo-5 get pods
  533  kubectl -n go-demo-5 get pods
  534  kubectl -n go-demo-5 get pods
  535  kubectl -n kube-system get cm     cluster-autoscaler-status     -o yaml
  536  ubectl -n go-demo-5     describe pods     -l app=api     | grep cluster-autoscaler
  537  kubectl -n go-demo-5     describe pods     -l app=api     | grep cluster-autoscaler
  538  kubectl get nodes
  539  vi scaling/go-demo-5.yml
  540  kubectl apply     -f scaling/go-demo-5.yml     --record
  541  kubectl -n go-demo-5 get hpa
  542  kubectl -n go-demo-5 rollout status     deployment api
  543  kubectl -n go-demo-5 get pods
  544  kubectl get nodes
  545  kubectl -n kube-system     get configmap     cluster-autoscaler-status     -o yaml
  546  kubectl -n kube-system     get configmap     cluster-autoscaler-status     -o yaml
  547  kubectl get nodes
```
