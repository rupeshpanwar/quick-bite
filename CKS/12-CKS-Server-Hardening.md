<details>
<summary>Introduction</summary>
<br>
    
  <img width="780" alt="image" src="https://user-images.githubusercontent.com/75510135/156912400-44997752-7be4-4af1-8e7b-e4ca2cdcf49f.png">

  <img width="782" alt="image" src="https://user-images.githubusercontent.com/75510135/156912410-983c6ba5-ce05-439b-8caa-eca5504897f1.png">

  <img width="764" alt="image" src="https://user-images.githubusercontent.com/75510135/156912415-68ea89db-b689-4806-8242-e0408f7f5ed5.png">

  -  RBAC
  <img width="965" alt="image" src="https://user-images.githubusercontent.com/75510135/156912438-808fddae-09bf-4828-b03b-e57d05e52061.png">

  <img width="969" alt="image" src="https://user-images.githubusercontent.com/75510135/156912448-36983ee1-3681-464e-af4f-e6d28399ec3d.png">

  <img width="975" alt="image" src="https://user-images.githubusercontent.com/75510135/156912465-8fc43a2f-6b72-4d61-a95e-fd09e4a92e0d.png">

  <img width="787" alt="image" src="https://user-images.githubusercontent.com/75510135/156912469-b3c59087-844a-462d-b05f-a960557c8f6a.png">

  - RBAC => Role => RoleBinding
  
  <img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/156912484-33a0c70d-e849-4eb3-959a-c91541d7c0e9.png">

  <img width="868" alt="image" src="https://user-images.githubusercontent.com/75510135/156912491-081aae34-3f56-43f1-a516-9de575ef3b01.png">

  <img width="893" alt="image" src="https://user-images.githubusercontent.com/75510135/156912502-a5758101-226a-4613-972b-515e41efc77f.png">

  <img width="805" alt="image" src="https://user-images.githubusercontent.com/75510135/156912508-da5442dd-6bba-40dc-a8ce-3b2cf69535b8.png">

  - Permissions
  
  <img width="892" alt="image" src="https://user-images.githubusercontent.com/75510135/156912519-e907418e-ffa2-4745-80fc-1a3a4d9634f9.png">

  
</details>

<details>
<summary>Create Role n Rolebinding</summary>
<br>

  - Scenario
  
  <img width="981" alt="image" src="https://user-images.githubusercontent.com/75510135/156912687-6d026f1f-46b0-48d0-919d-c4eba5792377.png">

  ```
  root@cks-master:~# k create ns red
namespace/red created
root@cks-master:~# k create ns blue
namespace/blue created
root@cks-master:~# k -n red create role secret-manager --verb=get --resource=secrets -oyaml --dry-run=client
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: null
  name: secret-manager
  namespace: red
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
root@cks-master:~# k -n red create rolebinding secret-manager --role=secret-manager --user=jane -oyaml --dry-run=client
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: null
  name: secret-manager
  namespace: red
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: secret-manager
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: jane
  
root@cks-master:~# k -n red create rolebinding secret-manager --role=secret-manager --user=jane
rolebinding.rbac.authorization.k8s.io/secret-manager created
  
root@cks-master:~# k -n red create role secret-manager --verb=get --resource=secrets
role.rbac.authorization.k8s.io/secret-manager created
root@cks-master:~#
  
  root@cks-master:~# k -n blue create role secret-manager --verb=get --verb=list --resource=secrets
role.rbac.authorization.k8s.io/secret-manager created
  
root@cks-master:~# k -n blue create rolebinding secret-manager --role=secret-manager --user=jane
rolebinding.rbac.authorization.k8s.io/secret-manager created
  
  root@cks-master:~# k -n red auth can-i create pods --as jane
no
root@cks-master:~# k -n red auth can-i create pods --as jane # no
no
root@cks-master:~# k -n red auth can-i get secrets --as jane # yes
yes
root@cks-master:~# k -n red auth can-i list secrets --as jane # no
no
root@cks-master:~#
root@cks-master:~# k -n blue auth can-i list secrets --as jane # yes
yes
root@cks-master:~# k -n blue auth can-i get secrets --as jane # yes
yes

root@cks-master:~# k -n default auth can-i get secrets --as jane #no
no
root@cks-master:~#
  
  ```
  
</details>


<details>
<summary>Clusterrole and ClusterRoleBinding</summary>
<br>

  <img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/156913064-e5049ccb-a515-46af-8754-631849914d5d.png">

  ```
  k create clusterrole deploy-deleter --verb=delete --resource=deployment

k create clusterrolebinding deploy-deleter --clusterrole=deploy-deleter --user=jane

k -n red create rolebinding deploy-deleter --clusterrole=deploy-deleter --user=jim


# test jane
k auth can-i delete deploy --as jane # yes
k auth can-i delete deploy --as jane -n red # yes
k auth can-i delete deploy --as jane -n blue # yes
k auth can-i delete deploy --as jane -A # yes
k auth can-i create deploy --as jane --all-namespaces # no



# test jim
k auth can-i delete deploy --as jim # no
k auth can-i delete deploy --as jim -A # no
k auth can-i delete deploy --as jim -n red # yes
k auth can-i delete deploy --as jim -n blue # no
  
  ```
</details>
