- https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


<details>
<summary>Introduction</summary>
<br>

  <img width="827" alt="image" src="https://user-images.githubusercontent.com/75510135/159164452-9131c828-bb7d-48c7-9ba4-f3e472f34810.png">

  <img width="939" alt="image" src="https://user-images.githubusercontent.com/75510135/159164479-8176cf5b-3150-4929-85a4-e890622e66c0.png">

  <img width="781" alt="image" src="https://user-images.githubusercontent.com/75510135/159164499-b2ed22ea-8323-425e-ba68-afd63d6f1ff3.png">

  <img width="723" alt="image" src="https://user-images.githubusercontent.com/75510135/159164517-300629fd-c78f-4325-9c48-d91915ac8f55.png">

  
</details>

<details>
<summary>Set Container User & Group</summary>
<br>
  
  - set user & group under which container process should be running
  > k run pod --image=busybox --command -oyaml --dry-run=client > pod.yml -- sh -c 'sleep 1d'
  
    root@cks-master:~# cat pod.yml
    apiVersion: v1
    kind: Pod
    metadata:
      creationTimestamp: null
      labels:
        run: pod
      name: pod
    spec:
      containers:
      - command:
        - sh
        - -c
        - sleep 1d
        image: busybox
        name: pod
        resources: {}
      dnsPolicy: ClusterFirst
      restartPolicy: Always
    status: {}
  
  - add security at pod level
  <img width="824" alt="image" src="https://user-images.githubusercontent.com/75510135/159164935-7e3f0034-8f74-4089-845e-165deeb6889e.png">

  <img width="325" alt="image" src="https://user-images.githubusercontent.com/75510135/159165013-86d5f000-5b1a-4048-a531-4fd7c85f2d67.png">

  - create the pod n check the user permission
  <img width="424" alt="image" src="https://user-images.githubusercontent.com/75510135/159165204-96a5f3d5-a2d6-4cc9-a260-298adf756431.png">

  - run container as Non-root user
  <img width="304" alt="image" src="https://user-images.githubusercontent.com/75510135/159165396-6783ff86-1b81-4d99-af0b-44662426dc46.png">

  
</details>


<details>
<summary>Privileged Container</summary>
<br>

  <img width="916" alt="image" src="https://user-images.githubusercontent.com/75510135/159165985-114c7d3e-30ba-4415-b765-e9c09a32a8ba.png">

  <img width="785" alt="image" src="https://user-images.githubusercontent.com/75510135/159165996-a16d20e1-80fa-40c6-9176-d39cecd5514e.png">

  
</details>


<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>

