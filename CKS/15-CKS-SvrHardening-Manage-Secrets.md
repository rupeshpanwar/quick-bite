
<details>
<summary>Introduction</summary>
<br>
  
  <img width="840" alt="image" src="https://user-images.githubusercontent.com/75510135/158044775-1015a660-9a00-4706-8d2b-47a754c725fd.png">

  - Generic way
  <img width="987" alt="image" src="https://user-images.githubusercontent.com/75510135/158044795-f973c13c-3fe1-4391-a481-707a6c943174.png">

  - Alternative way
  <img width="964" alt="image" src="https://user-images.githubusercontent.com/75510135/158044804-7b49db3b-cd93-4ff9-bbb8-19960946bdeb.png">

  - Decoupled way
  <img width="960" alt="image" src="https://user-images.githubusercontent.com/75510135/158044820-f930f90e-2fd1-4a4a-87c5-a079a4ae46e5.png">

  
</details>


<details>
<summary>Simple scenario - using Env var n Username as secret</summary>
<br>

  <img width="784" alt="image" src="https://user-images.githubusercontent.com/75510135/158047320-24b38645-2079-4e06-8cfa-6f04c6159351.png">

      k create secret generic secret1 --from-literal user=admin
      secret/secret1 created
  
      k create secret generic secret2 --from-literal pass=1234
      secret/secret2 created
  
   - create pod and set above created secrets
  ```
      k run pod --image nginx -oyaml --dry-run=client > pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: pod
        name: pod
      spec:
        containers:
        - image: nginx
          name: pod
          resources: {}
          volumeMounts:
          - name: secret1
            mountPath: "/etc/scret1"
            readOnly: true
        volumes:
        - name: secret1
          secret:
            secretName: secret1
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
  
     ==========
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: pod
        name: pod
      spec:
        containers:
        - image: nginx
          name: pod
          resources: {}
          env:
            - name: secret2
              valueFrom:
                secretKeyRef:
                  name: secret2
                  key: mykey
          volumeMounts:
          - name: secret1
            mountPath: "/etc/scret1"
            readOnly: true
        volumes:
        - name: secret1
          secret:
            secretName: secret1
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
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
