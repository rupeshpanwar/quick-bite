<details>
<summary>Introduction</summary>
<br>

  <img width="1007" alt="image" src="https://user-images.githubusercontent.com/75510135/166087228-ba901a8b-6931-4219-a1de-8f3830446510.png">

  
</details>

<details>
<summary>Rolling Update - yaml</summary>
<br>

  <img width="890" alt="image" src="https://user-images.githubusercontent.com/75510135/166087248-f5b568cd-2bc5-4674-ba4c-bdf8b61522fe.png">

  
</details>


<details>
<summary>Rollback</summary>
<br>

  <img width="843" alt="image" src="https://user-images.githubusercontent.com/75510135/166087262-d0723a82-c746-4b15-9ad4-72455ab9ab2a.png">

</details>


<details>
<summary>How to - Rolling update</summary>
<br>

  <img width="1018" alt="image" src="https://user-images.githubusercontent.com/75510135/166087316-7a446a76-7603-4364-97c9-9fde05c9bea0.png">

  <img width="1021" alt="image" src="https://user-images.githubusercontent.com/75510135/166087365-0fb2eeae-770a-486e-9cb8-0a696308da95.png">

  <img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/166087397-4bb01d7d-294c-4f4c-97c3-86db91a9263a.png">

  
</details>

<details>
<summary>How to - Rollback</summary>
<br>

  <img width="990" alt="image" src="https://user-images.githubusercontent.com/75510135/166087462-f4e2e493-11b8-4a33-a1a9-b90fd48f63c7.png">

  <img width="1014" alt="image" src="https://user-images.githubusercontent.com/75510135/166087471-5e20be8d-fb3a-48fb-a481-f0aba87a4266.png">

  
</details>
  
<details>
<summary>Practice - time => rollingUPDATE and rollBACK</summary>
<br>

        ```
              * Reference:                                                                                      *
            * ----------                                                                                      *
            * https://cloud.google.com/kubernetes-engine/docs/how-to/updating-apps                            *
            * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment *
            * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#checking-rollout-history-of-a-deployment
            * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-to-a-previous-revision
            * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment *
            *                                                                                                 *
            ***************************************************************************************************

            In this Demo:
            -------------
            We will create deploy sample application. Next we will update deployment by setting new Image version.
            What if we incorrectly put Image version? we will rollout. You will also learn about rolling back.

            ***************************************************************************************************


            1. Creating Deployment "Imperatively" (from command line):
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            kubectl create deployment NAME --image=[IMAGE-NAME] --replicas=[NUMBER]

            EX: 
            kubectl create deployment nginx-deploy --image=nginx:1.18 --replicas=4


            ***************************************************************************************************


            2. Upgrading Deployment with new Image:
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            kubectl set image deploy [DEPLOYMENT-NAME] [CONTAINER-NAME]=[CONTAINER-IMAGE]:[TAG] --record

            EX: 
            kubectl set image deploy nginx-deploy nginx=nginx:1.91 --record


            ***************************************************************************************************


            3. Checking Rollout Status:
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~

            kubectl rollout status deploy [DEPLOYMENT-NAME]

            EX: 

            kubectl rollout status deploy nginx-deploy
            Waiting for deployment "nginx-deploy" rollout to finish: 2 out of 4 new replicas have been updated...

            NOTE: There is some issue. To dig deep, let's check rollout history.


            ***************************************************************************************************


            4. Checking Rollout History:
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~

            kubectl rollout history deploy [DEPLOYMENT-NAME]

            # EX: 
            # root@master:~# kubectl rollout history deploy nginx-deploy
            # deployment.apps/nginx-deploy
            # REVISION  CHANGE-CAUSE
            # 1         kubectl set image deploy nginx-deploy nginx-container=nginx:1.91 --record=true
            # 2         kubectl set image deploy nginx-deploy nginx=nginx:1.91 --record=true

            # NOTE: From the output, you can see the commands that are run previously. 
            # If you notice, Image tag we used is 1.91 instead of 1.19. Let's rollback!

            # You can confirm the same from by running

            kubectl get deploy nginx-deploy -o wide


            ***************************************************************************************************


            4. Doing previous rollout "undo":
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            kubectl rollout undo deployment/[DEPLOYMENT-NAME]
            (OR)
            kubectl rollout undo deployment [DEPLOYMENT-NAME] --to-revision=[DESIRED-REVISION-NUMBER]

            kubectl rollout status deployment/[DEPLOYMENT-NAME]

            kubectl get deploy [DEPLOYMENT-NAME] -o wide


            ***************************************************************************************************


            5. Doing Rollout with correct Image version: 
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            kubectl set image deploy [DEPLOYMENT-NAME] [CONTAINER-NAME]=[CONTAINER-IMAGE]:[TAG] --record

            kubectl rollout status deploy [DEPLOYMENT-NAME]

            kubectl get deploy [DEPLOYMENT-NAME] -o wide
  ```
</details>
  
<details>
<summary>Exercise - rollingUpdate and rolloutBACK</summary>
<br>

  ```
        * Reference:                                                                                      *
        * ----------                                                                                      *
        * https://cloud.google.com/kubernetes-engine/docs/how-to/updating-apps                            *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment *
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#checking-rollout-history-of-a-deployment
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-to-a-previous-revision
        * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment *
        *                                                                                                 *
        ***************************************************************************************************

        In this Exercise:
        -----------------
        a. You will create deploy sample application. Next we will update deployment by setting new Image version.
        b. What if we incorrectly put Image version? we will "undo" rollout. You will also learn about rolling back.

        NOTE: 
        -----
        a. To successfully finish this exercise, It is important to go through Rolling Update & Rolling Back Concept and Demo videos in this series.
        b. You can refer to Kuberenetes Docs for help when needed.

        ***************************************************************************************************


        STEP-1: Create Deployment:
        --------------------------
        a. Create the deployment with below configuration using "kubectl create...." command.

        Deployment Name: nginx-deploy
        Container Image: nginx:1.18
        Replicas: 3


        ***************************************************************************************************


        STEP-2: Validate the Deployment:
        --------------------------------
        a. Display "nginx-deploy" deployment. Ensure Container Image version is nginx "1.18"


        ***************************************************************************************************

        STEP-3: Upgrading Deployment with new Image:
        --------------------------------------------
        a. Upgrade "nginx-deploy" deployment nginx version from 1.18 to 1.91 using "..set image..." command with "record" option on
        b. Wait for a minute and display roll-out status of "nginx-deploy" deployment.
        c. In case if it is "stuck", then display "roll-out history" of "nginx-deploy" deployment. 
        d. Identify Issue


        ***************************************************************************************************


        STEP-4: Doing previous rollout "undo":
        --------------------------------------
        a. Undo previous upgrade using "..rollout undo..." command
        b. Ensure "nginx-deploy" is running with image version nginx "1.18"


        ***************************************************************************************************


        STEP-5: Upgrading Deployment with new Image:
        --------------------------------------------
        a. Upgrade "nginx-deploy" deployment nginx version from 1.18 to 1.19 using "..set image..." command with "record" option on
        b. Wait for a minute and display roll-out status of "nginx-deploy" deployment.
        c. Display upgrade status by running "....rollout status..."
        d. Display "nginx-deploy" deployment and ensure it is running with image version nginx "1.19"


        ***************************************************************************************************


        STEP-6: Delete Deployment:
        --------------------------
        a. Delete the "nginx-deploy" deployment. 
        b. Display Deployment, ReplicaSet and Pods. Ensure "nginx-deploy" Deployemnt is related. Also related ReplicaSet and Pods
  ```
</details>
  
- https://cloud.google.com/kubernetes-engine/docs/how-to/updating-apps

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#checking-rollout-history-of-a-deployment

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-to-a-previous-revision

- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment
