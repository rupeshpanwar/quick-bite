<details>
<summary>Introduction</summary>
<br>

  <img width="987" alt="image" src="https://user-images.githubusercontent.com/75510135/163708919-6a7ff22c-65da-4db3-89e9-4ccf0fc678b8.png">

  <img width="984" alt="image" src="https://user-images.githubusercontent.com/75510135/163708928-9c1765de-01bd-4e78-8323-409d3c72c244.png">

  <img width="885" alt="image" src="https://user-images.githubusercontent.com/75510135/163708944-b5286f3d-01ae-42fd-a9b0-fd2a2b821aff.png">

  <img width="896" alt="image" src="https://user-images.githubusercontent.com/75510135/163708956-7aaaf6ee-b827-46b1-8a57-900f398aeed7.png">

  - Replicaset manage pods via label & selectors
  <img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/163708993-23521b68-0b3d-4b90-9f29-15d7cc3ff8f5.png">

  <img width="1010" alt="image" src="https://user-images.githubusercontent.com/75510135/163709065-88dad6e4-7c35-4a38-b846-c2d24b913e4d.png">

</details>


<details>
<summary>ReplicaSet Loop</summary>
<br>

  <img width="866" alt="image" src="https://user-images.githubusercontent.com/75510135/163709111-44627b58-a570-4e72-9668-ed8bfcad2471.png">

</details>


<details>
<summary>Replicaset - sneekpeek - yml</summary>
<br>

  <img width="975" alt="image" src="https://user-images.githubusercontent.com/75510135/163709183-a1134385-12d0-4663-89f7-4fc4b5f9f757.png">

  <img width="966" alt="image" src="https://user-images.githubusercontent.com/75510135/163709234-76fd2516-d0e9-4b0f-9cbe-9d0968c3a2fc.png">

  
</details>


<details>
<summary>Replicaset- tasks</summary>
<br>

  <img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/163709332-aa030bc1-073f-4309-89d9-1ef97bb11556.png">

  
</details>


<details>
<summary>Replicaset - Exercise</summary>
<br>

  ```
         Reference:                                                                                      
        * ----------                                                                                      
        * https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/                
        * https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/#how-a-replicaset-works    


        # frontend.yaml
        apiVersion: apps/v1
        kind: ReplicaSet
        metadata:
          name: frontend
          labels:
            app: guestbook
            tier: frontend
        spec:
          # modify replicas according to your case
          replicas: 3
          selector:
            matchLabels:
              tier: frontend
          template:
            metadata:
              labels:
                tier: frontend
            spec:
              containers:
              - name: php-redis
                image: gcr.io/google_samples/gb-frontend:v3


        ***************************************************************************************************


        # 2. Deploy ReplicaSet
        -----------------------
        kubectl apply -f <FILENAME.YAML>
        or 
        kubectl create -f <FILENAME.YAML>

        ***************************************************************************************************

        # 3. Display ReplicaSet (rs)
        ----------------------------
        kubectl get rs 
        kubectl get rs <RS-NAME> -o wide
        kubectl get rs <RS-NAME> -o yaml
        kubectl get rs -l <LABEL>     


        ***************************************************************************************************

        # 4. Displaying Pods 
        ---------------------
        kubectl get pods
        kubectl get pods -l <LABEL>  

        ***************************************************************************************************


        # 5. Print Details of ReplicaSet
        --------------------------------
        kubectl describe rs <RS-NAME>


        ***************************************************************************************************


        # 6. Scaling Applications
        -------------------------
        kubectl scale rs <RS-NAME> --replicas=[COUNT]     


        ***************************************************************************************************


        # 7. Editing ReplicaSet
        -----------------------
        kubectl edit rs <RS-NAME>      


        ***************************************************************************************************


        # 8. Running operations directly on the YAML file
        --------------------------------------------------
        SYNTAX: kubectl [OPERATION] –f [FILE-NAME.yaml]

        kubectl get –f [FILE-NAME.yaml]
        kubectl describe –f [FILE-NAME.yaml]
        kubectl edit –f [FILE-NAME.yaml]
        kubectl delete –f [FILE-NAME.yaml]
        kubectl create –f [FILE-NAME.yaml]


        ***************************************************************************************************


        # 9. Deleting ReplicaSet
        -------------------------
        kubectl delete rs <RS-NAME>

  ```
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
