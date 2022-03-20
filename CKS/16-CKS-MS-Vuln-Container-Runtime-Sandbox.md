- https://kubernetes.io/docs/concepts/containers/runtime-class/
<details>
<summary>Introduction</summary>
<br>
  
  <img width="907" alt="image" src="https://user-images.githubusercontent.com/75510135/159158772-8e51568f-8a74-4e2b-a605-fc5ad18a5260.png">

  <img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/159158784-eec2533a-c343-4dbb-af4e-b045e5e4f7ac.png">

  <img width="991" alt="image" src="https://user-images.githubusercontent.com/75510135/159158813-30649c59-6557-4223-876f-01ed0f8d754f.png">

  <img width="883" alt="image" src="https://user-images.githubusercontent.com/75510135/159158834-2decfeac-f8a9-44d6-851e-9ec924a011e9.png">

  
</details>

<details>
<summary>Container call Linux kernel & OCI- Open Container Initiative </summary>
<br>

  <img width="532" alt="image" src="https://user-images.githubusercontent.com/75510135/159159304-54903613-ba71-42dd-9a3d-180063b3afcc.png">

  <img width="819" alt="image" src="https://user-images.githubusercontent.com/75510135/159159463-363bcd84-b952-44a4-a205-25fa43de3e88.png">

  <img width="760" alt="image" src="https://user-images.githubusercontent.com/75510135/159159475-34a51a26-f975-4c68-822e-8ee4362e1216.png">

  <img width="857" alt="image" src="https://user-images.githubusercontent.com/75510135/159159503-5b13c259-d9b2-4bb6-aa15-5c6792442a43.png">

  <img width="905" alt="image" src="https://user-images.githubusercontent.com/75510135/159159511-262a8240-150a-4872-b355-07dbff4f0f24.png">

  <img width="693" alt="image" src="https://user-images.githubusercontent.com/75510135/159159587-85111863-c273-449a-82f6-a361c5b2005c.png">


</details>


<details>
<summary>Kata Container , gVisor</summary>
<br>

  <img width="770" alt="image" src="https://user-images.githubusercontent.com/75510135/159159604-3eee27ca-54b1-496f-a224-4c323241f3f1.png">

  <img width="719" alt="image" src="https://user-images.githubusercontent.com/75510135/159159704-145b358f-0b6b-40ea-b31f-f591aec2c42f.png">

  <img width="838" alt="image" src="https://user-images.githubusercontent.com/75510135/159159719-433034db-2677-49fa-be07-d7b56c4f3fc6.png">

    - create a runtime class for gvisor
  <img width="973" alt="image" src="https://user-images.githubusercontent.com/75510135/159159923-5c5c7567-ad52-4e8d-9545-7ec7311e3b38.png">
    
  <img width="677" alt="image" src="https://user-images.githubusercontent.com/75510135/159159996-32e52bbe-a433-4382-a898-597c38d9b8f9.png">

  - create pod now 
    k run gvisor --image=nginx -oyaml --dry-run=client > gvisor.yml
  
    <img width="707" alt="image" src="https://user-images.githubusercontent.com/75510135/159160057-acc1e626-81f0-4ea0-97d0-023ad57b2c4c.png">

    <img width="390" alt="image" src="https://user-images.githubusercontent.com/75510135/159160211-7eed8336-7f76-4efc-849f-87fb4c9facbf.png">
  
  - install gvisor 
  
  > bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/course-content/microservice-vulnerabilities/container-runtimes/gvisor/install_gvisor.sh)
              
    
 - create below pod 
      ```         
      apiVersion: node.k8s.io/v1
      kind: RuntimeClass
      metadata:
        name: gvisor
      handler: runsc
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        labels:
          run: gvisor
        name: gvisor
      spec:
        runtimeClassName: gvisor
        containers:
          - image: nginx
            name: gvisor
            resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
       ```        
</details>

<details>
<summary>Add-on</summary>
<br>

  <img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/159164172-1c3a8918-6632-444a-8b74-542ee68bddfa.png">

  <img width="782" alt="image" src="https://user-images.githubusercontent.com/75510135/159164186-d34a9b88-bdc1-4eae-b685-968093d42f81.png">

  <img width="735" alt="image" src="https://user-images.githubusercontent.com/75510135/159164211-7de9876b-5bf2-448b-8f68-3a15fe7fc291.png">

  
  
</details>
