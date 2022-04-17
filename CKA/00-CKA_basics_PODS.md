
- https://kubernetes.io/docs/concepts/workloads/pods/

- https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/

- https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/

- https://kubernetes.io/docs/tasks/configure-pod-container/

- https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/

<details>
<summary>Pods - sneekpeek</summary>
<br>

  <img width="936" alt="image" src="https://user-images.githubusercontent.com/75510135/163707608-5b22c41c-d885-45ee-9d43-8225220c9b5a.png">
  <img width="787" alt="image" src="https://user-images.githubusercontent.com/75510135/163707671-029eca89-7984-4cdb-9a4f-0842dd36db9a.png">

  <img width="1016" alt="image" src="https://user-images.githubusercontent.com/75510135/163707793-0c6d2e24-5c3e-4437-a304-599c9712d40a.png">

  <img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/163707823-ecd17335-5ce2-4bb8-b57a-a05d3d2940ff.png">

</details>

<details>
<summary>Pods - LifeCycle</summary>
<br>

  <img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/163707879-6d3bd30f-192f-45b5-9fb1-2a8db468805a.png">

</details>

<details>
<summary>Pod - yaml</summary>
<br>

  <img width="995" alt="image" src="https://user-images.githubusercontent.com/75510135/163707937-71694de5-4195-4c8b-8037-801cc4f53071.png">

  <img width="1008" alt="image" src="https://user-images.githubusercontent.com/75510135/163707954-6155cc3d-58fa-4eae-add5-8ab78983c9b1.png">

  <img width="1001" alt="image" src="https://user-images.githubusercontent.com/75510135/163707960-b30b68a9-b07a-49e4-b8c2-d30c3c72fe81.png">

  <img width="641" alt="image" src="https://user-images.githubusercontent.com/75510135/163707974-101504fb-7ddb-4609-9f73-4e0ac4ae0506.png">

  <img width="735" alt="image" src="https://user-images.githubusercontent.com/75510135/163707985-c620d96b-44a3-412e-930d-cced86ead4eb.png">

  
</details>

<details>
<summary>API Version</summary>
<br>

  <img width="1009" alt="image" src="https://user-images.githubusercontent.com/75510135/163708026-d854a1dd-0027-48be-8a5c-84b30e65ae2b.png">


</details>

<details>
<summary>Pod - Tasks</summary>
<br>

  <img width="1032" alt="image" src="https://user-images.githubusercontent.com/75510135/163708184-214d7673-d9f0-4c04-bcdd-fe982725340e.png">

</details>

<details>
<summary>Pods - practices</summary>
<br>
```
             References:                                                                                     
                                                                                       
          * https://kubernetes.io/docs/concepts/workloads/pods/                                             
          * https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/                               
          * https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/                            
          * https://kubernetes.io/docs/tasks/configure-pod-container/                                       
          * https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/ 
          
          1. Pod YAML with Environment Variables
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          # nginx-pod.yaml
          apiVersion: v1
          kind: Pod
          metadata:
            name: nginx-pod
            labels:
              app: nginx
              tier: dev
          spec:
            containers:
            - name: nginx-container
              image: nginx:1.18
              env:
              - name: DEMO_GREETING
                value: "Hello from the environment"
              - name: DEMO_FAREWELL
                value: "Such a sweet sorrow"



          ***************************************************************************************************


          # 2. Deploy Pods
          ~~~~~~~~~~~~~~~~~
          kubectl apply -f <FILENAME.YAML>
          (or) 
          kubectl create -f <FILENAME.YAML>


          ***************************************************************************************************


          # 3. Display Pods
          ~~~~~~~~~~~~~~~~~
          kubectl get pods
          kubectl get pods -o wide  # Print wide output of the Pod

          kubectl get pods -n <NAME-SPACE>     # Print Pods in particular NameSpace
          kubectl get pods -A                  # Print Pods in all namespace

          kubectl get pods <POD-NAME>
          kubectl get pods <POD-NAME> -o yaml  
          kubectl get pods <POD-NAME> -o json

          kubectl get pods --show-labels
          kubectl get pods -l app=nginx        # Print Pods with particular label


          ***************************************************************************************************


          # 4. Print Details of Pod
          ~~~~~~~~~~~~~~~~~~~~~~~~~~
          kubectl describe pods <POD-NAME>     


          ***************************************************************************************************


          # 5. Editing Pod which is running
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          kubectl edit pods <POD-NAME>
          kubectl describe pods nginx-pod | grep Image

          ***************************************************************************************************


          # 6. Print Pod Logs
          ~~~~~~~~~~~~~~~~~~~
          kubectl logs <POD-NAME>
          kubectl logs <POD-NAME> -n <NAME-SPACE>

          ***************************************************************************************************


          # 7. Displaying Pods by Resource Usage
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

          NOTE: Metrics-Server
          ~~~~~~~~~~~~~~~~~~~~
          a. To run below top commands, you need to have "Metrics-Server" Installed. 
          b. For step-by-step demo and instructions please refer to the "Installing Metrics Server" lecture & demos that you find in "Troubleshooting" section in this series.
          https://www.udemy.com/course/ultimate-cka-certified-kubernetes-administrator/learn/lecture/26854680#questions
          c. Again, below are the high-level steps.

          Installing Metrics-Server:
          --------------------------
          git clone https://github.com/kubernetes-sigs/metrics-server.git

          kubectl apply -k metrics-server/manifests/test/

          NOTE: If you encounter any Image error, try updating imagePullPolicy: Always 
          in metrics-server/manifests/test/patch.yaml

          Give it a minute to gather the data and then run below Top Commands:

          Top Command to find the CPU and Memory Usage of Pods, Nodes and Containers:
          ---------------------------------------------------------------------------
          kubectl top pods
          kubectl top pods -A
          kubectl top pods -A --sort-by memory
          kubectl top pods -A --sort-by cpu
          kubectl top pods -n [name-space]  --sort-by cpu 
          kubectl top pods -n [name-space]  --sort-by memory
          kubectl top pods -n [name-space]  --sort-by memory > mem-usage.txt

          ***************************************************************************************************


          # 8. Running operations directly on the YAML file
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

          SYNTAX: kubectl [OPERATION] –f [FILE-NAME.yaml]

          kubectl get –f [FILE-NAME.yaml]
          kubectl describe –f [FILE-NAME.yaml]
          kubectl edit –f [FILE-NAME.yaml]
          kubectl delete –f [FILE-NAME.yaml]
          kubectl apply –f [FILE-NAME.yaml]


          ***************************************************************************************************


          # 9. Deleting Pod
          ~~~~~~~~~~~~~~~~~
          kubectl delete pods <POD-NAME>


          ***************************************************************************************************
```
</details>

