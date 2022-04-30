<details>
<summary>Introuction</summary>
<br>
  
  <img width="956" alt="image" src="https://user-images.githubusercontent.com/75510135/166089050-29a60d0b-3e51-4799-9187-ce56ff541b82.png">

  <img width="964" alt="image" src="https://user-images.githubusercontent.com/75510135/166089031-87c1249b-e850-4c30-a4ae-4e295c57d1a6.png">

  <img width="961" alt="image" src="https://user-images.githubusercontent.com/75510135/166089021-7fb694ab-90bf-47f0-aa67-d57f49b2428e.png">

</details>

<details>
<summary>Scale up - TASKS</summary>
<br>
  
  <img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/166089723-e15ad5da-e7ff-44c8-b97a-a98d22152ea1.png">

  <img width="1021" alt="image" src="https://user-images.githubusercontent.com/75510135/166089697-ee25ac71-9a3a-4ee4-b4df-a20d739fcadc.png">

  <img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/166089182-37f47e7b-bd1e-481b-b67d-4521ac8c4af0.png">

</details>

<details>
<summary>Scale down - TASKS</summary>
<br>

  <img width="1000" alt="image" src="https://user-images.githubusercontent.com/75510135/166089165-d49a9e82-8080-43d1-895c-eccefadf17e0.png">

</details>



<details>
<summary>Excercise</summary>
<br>
  
       ```
          * Reference:                                                                                      *
        * ----------                                                                                      *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment      *
        * https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/#scaling-your-application
        *                                                                                                 *
    


        1. Creating Deployment "Imperatively" (from command line):
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        kubectl create deployment NAME --image=[IMAGE-NAME] --replicas=[NUMBER]

        Ex:
        kubectl create deployment nginx-deploy --image=nginx --replicas=3

        ***************************************************************************************************


        2. Scaling Deployment using "kubectl scale" command:
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        kubectl scale deployment nginx-deploy --replicas=[NEW-REPLICA-COUNT]


        ***************************************************************************************************


        3. Validate the Replica Count:
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        kubectl get deploy nginx-deploy 
        kubectl get rs nginx-deploy
        kubect get pods -o wide

```
</details>

<details>
<summary>Practice </summary>
<br>
  
    ```
          * Reference:                                                                                      *
        * ----------                                                                                      *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment      *
        * https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/#scaling-your-application
        *                                                                                                 *
        ***************************************************************************************************

        In this Exercise:
        -----------------
        You will deploy sample application, then you will scale-up and scale-down applications.

        NOTE: 
        -----
        a. To successfully finish this exercise, It is important to go through Deployment and Scaling Applications Concept and Demo videos in this series.
        b. You can refer to Kuberenetes Docs for help when needed.


        ***************************************************************************************************

        STEP-1: Create Deployment:
        --------------------------
        a. Create Deployment with below configuration using "kubectl create..." command

        Deployment Name: nginx-deploy
        Container Image: nginx
        Replicas: 3

        ***************************************************************************************************


        STEP-2: Scale-UP Deployments:
        -----------------------------
        a. Scale up "nginx-deploy" deployment from 3 to 5 replicas by running "...scale..." command
        b. Display "nginx-deploy" deployment and ensure "Ready" is 5/5.


        ***************************************************************************************************

        STEP-3: Scale-DOWN Deployments:
        -------------------------------
        a. Scale-DOWN "nginx-deploy" deployment from 5 to 3 replicas by running "...scale..." command
        b. Display "nginx-deploy" deployment and ensure "Ready" is 3/3.


        ***************************************************************************************************


        STEP-4: Delete the Deployment:
        ------------------------------
        a. Delete the "nginx-deploy" deployment. 
        b. Display Deployment, ReplicaSet and Pods. Ensure "nginx-deploy" Deployemnt is related. Also related ReplicaSet and Pods
    ```
</details>


