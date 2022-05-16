  k get sa,secrets
  k describe sa default
  k create sa accessor
  k get sa,secrets
  k describe sa accessor
  k describe secret accessor-token-vqbhz
  k run accessor --image=nginx --dry-run=client -oyaml
  k run accessor --image=nginx --dry-run=client -oyaml > accessor.yml
  vi accessor.yml
  k -f accessor.yml create
  k exec -it access -- bash
  k exec -it accessor -- bash
  k get pod
  k get pod -w
  clear
  k exec -it accessor -- bash
  mount | grep sec


  # disable service account
  # https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
    vi accessor.yml
    k -f accessor.ym replace --force
    k -f accessor.yml replace --force
    k exec -it accessor -- bash
    k edit pod accessor


# limit service account via RBAC
  k auth can-i delete secrets --as system:serviceaccount:default:accessor
  k create clusterrolebinding accessor --clusterrole edit --serviceaccount default:accessor
  k auth can-i delete secrets --as system:serviceaccount:default:accessor