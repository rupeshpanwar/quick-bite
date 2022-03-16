
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
  - grab the PAss
  <img width="471" alt="image" src="https://user-images.githubusercontent.com/75510135/158083001-099be168-b83e-45ba-b766-d27ae9158f48.png">
- run crictl cmds
  
    crictl ps
    crictl inspect container-id
  
  <img width="632" alt="image" src="https://user-images.githubusercontent.com/75510135/158702771-a122a675-9670-4fe8-a795-335865565431.png">

  <img width="1010" alt="image" src="https://user-images.githubusercontent.com/75510135/158702917-0b0fb9e9-81dc-4858-8d45-b24f64d67a4e.png">

  - pipe into vi to find the pid of container
      crictl inspect container-id | vi -
  <img width="755" alt="image" src="https://user-images.githubusercontent.com/75510135/158703174-7ecacb60-0c6c-4602-b8ac-dc5a77b2a3c7.png">

  <img width="792" alt="image" src="https://user-images.githubusercontent.com/75510135/158703558-00bef2d7-b9c4-453b-b310-0027f59f7732.png">

       ps aux | grep 5434
       ls /proc/5434/root/
       find /proc/5434/root/etc/secret1
       cat /proc/5434/root/etc/secret1/user
  
</details>


<details>
<summary>Hack Secrets in ETCD</summary>
<br>
  
  <img width="940" alt="image" src="https://user-images.githubusercontent.com/75510135/158704655-a4e474c2-283e-46fb-862e-d97099c25df8.png">

  - etcd client
    ETCD_API=3 etcdctl
  
  - to check the etcd health
    ETCD_API=3 etcdctl endpoint health
  
  - find the api server then use the certs to connect to etcd
    cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep etcd
  
  <img width="718" alt="image" src="https://user-images.githubusercontent.com/75510135/158705115-0828b09f-e251-4420-af09-c3ec2004bfa5.png">

     ETCD_API=3 etcdctl --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --key /etc/kubernetes/pki/apiserver-etcd-client.key --cacert /etc/kubernetes/pki/etcd/ca.crt endpoint health
  
  <img width="722" alt="image" src="https://user-images.githubusercontent.com/75510135/158705263-f35f4882-fc5a-40f2-9a05-46edb0d0aba0.png">

  
  - now to get the secret from ETCD
  
    ETCD_API=3 etcdctl --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --key /etc/kubernetes/pki/apiserver-etcd-client.key --cacert /etc/kubernetes/pki/etcd/ca.crt get /registry/secrets/default/secret2
  
  <img width="718" alt="image" src="https://user-images.githubusercontent.com/75510135/158705536-b83dea23-f2a8-4db9-853c-8640f945db44.png">

  <img width="714" alt="image" src="https://user-images.githubusercontent.com/75510135/158705584-b9cff8b9-37ad-40d0-aa93-3a90b2e84f5d.png">

  
  
</details>


<details>
<summary>Encrypt secrets in ETCD</summary>
<br>
  
  - API Server is responsible for all sorts of Encryption in ETCD
  
  <img width="655" alt="image" src="https://user-images.githubusercontent.com/75510135/158706353-d363ece6-d900-48e5-954e-1d593f25b167.png">

  - identity is used for Encryption on save(here its not)
  
  <img width="866" alt="image" src="https://user-images.githubusercontent.com/75510135/158706576-64ce0690-f295-498b-a3c4-3f84d90e462d.png">

  - To encrypt all the secrets , use below command 
  <img width="803" alt="image" src="https://user-images.githubusercontent.com/75510135/158706706-a513c136-ecfe-4a6d-a5e1-55310a4bdc29.png">

  - Now, to decrypt 
  <img width="851" alt="image" src="https://user-images.githubusercontent.com/75510135/158706767-89df79ac-46c0-4919-97e1-e36cfa8fb252.png">

</details>


<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
