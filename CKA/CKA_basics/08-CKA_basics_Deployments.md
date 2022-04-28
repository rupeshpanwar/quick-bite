
<details>
<summary>Introduction</summary>
<br>

  <img width="450" alt="image" src="https://user-images.githubusercontent.com/75510135/165760147-b43eb0b9-d529-4e6a-ad90-80424679596e.png">
  
  <img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/165763136-c2d60882-935a-48b9-a9c5-c12b518275fc.png">

  <img width="941" alt="image" src="https://user-images.githubusercontent.com/75510135/165763025-5049fcc7-6a54-4306-a8c7-0a7383412a0c.png">

  <img width="811" alt="image" src="https://user-images.githubusercontent.com/75510135/165762959-c31435ce-23ef-4efc-98ec-395e376924fe.png">

  
</details>

<details>
<summary>Deployment Strategy</summary>
<br>

  <img width="1005" alt="image" src="https://user-images.githubusercontent.com/75510135/165764807-d9f10c74-5945-456a-accb-465f9f1c3600.png">

  <img width="814" alt="image" src="https://user-images.githubusercontent.com/75510135/165764864-42937591-410b-4fdf-ade0-42418ed49993.png">

  
  <img width="887" alt="image" src="https://user-images.githubusercontent.com/75510135/165764738-9608c7cd-e5f7-443e-b2a2-4ede9863a9c4.png">

  
  <img width="1022" alt="image" src="https://user-images.githubusercontent.com/75510135/165764649-ed8881db-ead8-43c8-a9a9-9ff7eb27e61d.png">

  <img width="986" alt="image" src="https://user-images.githubusercontent.com/75510135/165764554-cda13cee-c7fe-456c-99d5-d10d739c01ae.png">

  
  <img width="982" alt="image" src="https://user-images.githubusercontent.com/75510135/165764460-74e292d7-8b31-4e73-86ec-bf726f2cf198.png">

  
</details>


<details>
<summary>Deployment - yaml file & Tasks</summary>
<br>
  
  <img width="992" alt="image" src="https://user-images.githubusercontent.com/75510135/165766529-3896ba0a-324a-4c9f-96d3-818b4a9f57fe.png">


  <img width="909" alt="image" src="https://user-images.githubusercontent.com/75510135/165766397-aba2ca6b-ec4a-4d6a-8247-f7349fcdab6e.png">
  
  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/165767454-b8c15c1a-bf53-43c0-8adc-94c9b388b326.png">


</details>

<details>
<summary>Practice - Deployments</summary>
<br>
    
  ```
    * Reference:                                                                                      *
    * ----------                                                                                      *
    * https://www.redhat.com/en/topics/containers/what-is-kubernetes-deployment                       *                
    * https://cloud.google.com/kubernetes-engine/docs/concepts/deployment                             *
    * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/                           *
    * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment     *
    * https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/                   *
    * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#pausing-and-resuming-a-deployment
    

    1. Creating Deployment Declaratively (Using YAML file)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # nginx-deploy.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deploy
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: nginx-app
      template:
        metadata:
          name: nginx-pod
          labels:
            app: nginx-app
        spec:
          containers:
          - name: nginx-container
            image: nginx:1.18
            ports:
            - containerPort: 80


    Deploying
    ---------
    kubectl apply -f nginx-deploy.yaml
    # 
    kubectl create -f nginx-deploy.yaml


    ***************************************************************************************************


    2. Creating Deployment "Imperatively" (from command line):
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kubectl create deployment NAME --image=[IMAGE-NAME] --replicas=[NUMBER]


    For dry-run: It tests to ensure were there any issues. Will NOT create the Object:
    ----------------------------------------------------------------------------------
    kubectl create deployment NAME --image=[IMAGE-NAME] --replicas=[NUMBER] --dry-run=client

    Ex:
    kubectl create deployment redis-deploy --image=redis --replicas=3 --dry-run=client

    Exporting Dry-run output to YAML format:
    ----------------------------------------
    kubectl create deployment nginx-deploy --image=nginx --replicas=2 --dry-run=client -o yaml

    Ex:
    kubectl create deployment redis-deploy --image=redis --replicas=3 --dry-run=client -o yaml
    kubectl create deployment redis-deploy --image=redis --replicas=3 --dry-run=client -o yaml > redis-deploy.yaml

    CKA/CKAD TIP: 
    -------------
    Due to time sensitive in the Exam, It is better to generate to Deployment YAML using above command.
    Instead of writing complete Deployment YAML. It saves lot of time.


    ***************************************************************************************************


    3. Displaying Deployment
    ~~~~~~~~~~~~~~~~~~~~~~~~~

    kubectl get deploy <NAME>
    kubectl get deploy <NAME> -o wide
    kubectl get deploy <NAME> -o yaml

    kubectl describe deploy <NAME>


    ***************************************************************************************************


    4. Print Details of Pod Created by this Deployment
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kubectl get pods --show-labels
    kubectl get pods -l [LABEL]

    EX: kubectl get pods -l app=nginx-app


    ***************************************************************************************************


    5. Print Details of ReplicaSet Created by this Deployment:
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    kubectl get rs --show-labels
    kubectl get rs -l [LABEL]

    EX: kubectl get rs -l app=nginx-app


    ***************************************************************************************************


    6. Scaling Applications:
    ~~~~~~~~~~~~~~~~~~~~~~~~
    kubectl scale deploy [DEPLOYMENT-NAME] --replicas=[COUNT]     # Update the replica-count to 5


    ***************************************************************************************************


    7. Edit the Deployment:
    ~~~~~~~~~~~~~~~~~~~~~~~
    kubectl edit deploy [DEPLOYMENT-NAME]


    ***************************************************************************************************


    8. Running operations directly on the YAML file:
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    SYNTAX: kubectl [OPERATION] –f [FILE-NAME.yaml]

    kubectl get –f [FILE-NAME.yaml]
    kubectl describe –f [FILE-NAME.yaml]
    kubectl edit –f [FILE-NAME.yaml]
    kubectl delete –f [FILE-NAME.yaml]
    kubectl create –f [FILE-NAME.yaml]



    ***************************************************************************************************


    9. Delete the Deployment:
    ~~~~~~~~~~~~~~~~~~~~~~~~~
    kubectl delete deploy <NAME>

    kubectl get deploy
    kubectl get rs
    kubectl get pods

  ```
</details>


<details>
<summary>Exercise - Deployment</summary>
<br>

  ```
          * Reference:                                                                                      *
        * ----------                                                                                      *
        * https://www.redhat.com/en/topics/containers/what-is-kubernetes-deployment                       *                
        * https://cloud.google.com/kubernetes-engine/docs/concepts/deployment                             *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/                           *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment     *
        * https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/                   *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#pausing-and-resuming-a-deployment
        *                                                                                                 *
        ***************************************************************************************************

        In this exercise:
        ------------------
        You will create the Deployment and then perform various activities that we perform every day.

        NOTE: 
        -----
        a. To successfully finish this exercise, It is important to go through Deployment Concept and Demo videos in this series.
        b. You can refer to Kuberenetes Docs for help when needed.


        ***************************************************************************************************

        STEP-1: Create Deployment:
        --------------------------
        a. Create Deployment with below configuration using "kubectl create..." command

        Deployment Name: nginx-deploy
        Container Image: nginx
        Replicas: 3


        ***************************************************************************************************


        STEP-2. Display/Validate Deployment:
        ------------------------------------
        a. Display all deployments (in the default namespace)
        b. Display "nginx-deploy". Ensure "Ready" "3/3", and "Up-to-date" and "Available" is 3.
        c. Display "nginx-deploy" deployment with wide-output.
        d. Display complete details of "nginx-deploy" deployment using "...describe..." command

        e. Display the "nginx-deploy" details and redirect the output to "YAML" format
        f. Display the "nginx-deploy" details and redirect the output to "JSON" format

        g. Display Labels of "nginx-deploy" deployment

        h. Display ReplicaSet created by "nginx-deploy"
        i. Display Pods created by "nginx-deploy" 


        ***************************************************************************************************

        STEP-3: Edit the Deployment:
        ----------------------------
        a. Edit the "nginx-deploy" deployment by running "...edit..." command
        b. Update "replicas" count from 3 to 5 and save the file.
        c. Display "nginx-deploy" deployment. Ensure "Ready" "5/5", and "Up-to-date" and "Available" is 5.


        ***************************************************************************************************

        STEP-4: Scale Down Applications:
        --------------------------------
        a. Scale down "nginx-deploy" replicas from 5 to 3 by running "...scale..." command.


        ***************************************************************************************************


        STEP-5: Delete the Deployment:
        ------------------------------
        a. Delete the "nginx-deploy" deployment. 
        b. Display Deployment, ReplicaSet and Pods. Ensure "nginx-deploy" Deployemnt is related. Also related ReplicaSet and Pods

  ```
</details>

- https://www.redhat.com/en/topics/containers/what-is-kubernetes-deployment

- https://cloud.google.com/kubernetes-engine/docs/concepts/deployment

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment

- https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#pausing-and-resuming-a-deployment
