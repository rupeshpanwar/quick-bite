
<details>
<summary>ConfigMap vs Secrets</summary>
<br>

  <img width="912" alt="image" src="https://user-images.githubusercontent.com/75510135/166102984-9a014be8-ed0c-4e80-8982-92581832d969.png">
  
</details>

<details>
<summary>Introduction</summary>
<br>

  <img width="877" alt="image" src="https://user-images.githubusercontent.com/75510135/166101829-8298d3c7-ea17-41a3-8801-2f65888e668f.png">

  <img width="836" alt="image" src="https://user-images.githubusercontent.com/75510135/166101819-1cb0b684-c4c7-45d5-865d-f359c9544100.png">

</details>

<details>
<summary>Secrets - yaml - Declarative vs Imperative way</summary>
<br>
  
  <img width="978" alt="image" src="https://user-images.githubusercontent.com/75510135/166102027-cc3a583f-b23c-4e6f-8487-78aef1136d79.png">

  
  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/166102020-3eed9c05-42d3-42e4-b18a-2a7798482409.png">

  
  <img width="1011" alt="image" src="https://user-images.githubusercontent.com/75510135/166102008-a95fe1b7-344b-4326-b5a4-de3b43a73ab8.png">


  <img width="1013" alt="image" src="https://user-images.githubusercontent.com/75510135/166101997-12183e5b-9776-48d5-abfd-390568af85ac.png">

</details>


<details>
<summary>Injecting Secrets via Env vars</summary>
<br>
  <img width="851" alt="image" src="https://user-images.githubusercontent.com/75510135/166102304-d45dcfaf-784a-43ed-8088-c7a269178e2d.png">

  <img width="1019" alt="image" src="https://user-images.githubusercontent.com/75510135/166102297-3db5af87-8c47-47dc-a02a-ad8ddd556648.png">

</details>


<details>
<summary>Injecting Secrets via Volume</summary>
<br>

  <img width="851" alt="image" src="https://user-images.githubusercontent.com/75510135/166102305-87472bdb-a6ee-40e1-add8-edfa03faec94.png">

  <img width="1026" alt="image" src="https://user-images.githubusercontent.com/75510135/166102269-6e4cab11-f6b4-41d7-8bc6-a2ef2456699a.png">

</details>


<details>
<summary>Secret - Tasks(how-to)</summary>
<br>

  <img width="1021" alt="image" src="https://user-images.githubusercontent.com/75510135/166102352-4fff7daa-15e0-4854-9a37-c083a1d787cd.png">

  
</details>


<details>
<summary>Practice</summary>
<br>
  
  ```
      * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/tasks/configmap-secret/                                              *
* https://kubernetes.io/docs/concepts/configuration/secret/                                       *
* https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/         *
* https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-em-          *
* https://cloud.google.com/kubernetes-engine/docs/concepts/secret                                 *
* https://blog.newrelic.com/engineering/how-to-use-kubernetes-secrets/                            *


1. Creating Secrets Declaratively (Using YAML):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a. Base-64 Encoding:
---------------------
echo -n 'admin' | base64
echo -n '1f2d1e2e67df' | base64



b. Using Base64 Encoding in creating Secret:
--------------------------------------------
# db-user-pass.yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-user-pass
  namespace: default
data:
  username: YWRtaW4=
  password: dGhpc2lzcGFzc3dvcmQ=

Deploy:
-------
kubectl apply –f secret-db-user-pass.yaml 


***************************************************************************************************


2. Creating Secrets Imperatively (From Command line):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to skip the Base64 encoding step, you can create the same Secret using the kubectl create secret command. This is more convinient.


Example:
-------
kubectl create secret generic test-secret --from-literal='username=my-app' --from-literal='password=39528$vdg7Jb'

Example:
--------
echo -n 'admin' > ./username.txt
echo -n '1f2d1e2e67df' > ./password.txt

kubectl create secret [TYPE] [NAME] [DATA]

Example
--------
kubectl create secret generic db-user-pass-from-file --from-file=./username.txt --from-file=./password.txt

Example:
--------
kubectl get secrets db-user-pass –o yaml


***************************************************************************************************

3. Injecting "Secrets" into Pod As Environmental Variables:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# my-secrets-pod-env.yaml

apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: db-user-pass
            key: username
      - name: SECRET_PASSWORD
        valueFrom:
          secretKeyRef:
            name: db-user-pass
            key: password
  restartPolicy: Never


Validate:
---------
kubectl exec secret-env-pod -- env
kubectl exec secret-env-pod -- env | grep SECRET



***************************************************************************************************

4. Injecting "Secrets" into Pod As Files inside the Volume:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# my-secrets-vol-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-vol-pod
spec:
  containers:
    - name: test-container
      image: nginx
      volumeMounts:
        - name: secret-volume
          mountPath: /etc/secret-volume
  volumes:
    - name: secret-volume
      secret:
        secretName: test-secret

    
Validate:
---------
kubectl exec secret-vol-pod -- ls /etc/secret-volume
kubectl exec secret-vol-pod -- cat /etc/secret-volume/username
kubectl exec secret-vol-pod -- cat /etc/secret-volume/password

***************************************************************************************************

5. Displaying Secret:
~~~~~~~~~~~~~~~~~~~~~
kubectl get secret <NAME>
kubectl get secret <NAME> -o wide
kubectl get secret <NAME> -o yaml
kubectl get secret <NAME> -o json

kubectl describe secret <NAME>


***************************************************************************************************


6. Running operations directly on the YAML file:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubectl [OPERATION] –f [FILE-NAME.yaml]

kubectl get –f [FILE-NAME.yaml]
kubectl delete –f [FILE-NAME.yaml]
kubectl get -f [FILE-NAME.yaml]
kubectl create -f [FILE-NAME.yaml]


***************************************************************************************************


7. Delete Secret: 
~~~~~~~~~~~~~~~~~
kubectl delete secret <NAME>
  ```
 
</details>

<details>
<summary>Exercise</summary>
<br>

  ```
  * Reference:                                                                                      *
* ----------                                                                                      *
* https://kubernetes.io/docs/tasks/configmap-secret/                                              *
* https://kubernetes.io/docs/concepts/configuration/secret/                                       *
* https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/         *
* https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-em-          *
* https://cloud.google.com/kubernetes-engine/docs/concepts/secret                                 *
* https://blog.newrelic.com/engineering/how-to-use-kubernetes-secrets/                            *
*                                                                                                 *
***************************************************************************************************

In this Demo:
-------------
You will create the sample Secret Imperatively.
Then you will inject this Secret inside Pod as Environment Variables and Files inside the volume.


NOTE: 
-----
a. To successfully finish this exercise, It is important to go through Secret Concept and Demo videos in this series.
b. You can refer to Kuberenetes Docs for help when needed.


***************************************************************************************************

TASK-1: Create Secret with below configuration using "kubectl create secret..." command:
----------------------------------------------------------------------------------------

Secret Name: cred-secret

username: admin
password: pa$$1254


***************************************************************************************************

TASK-2: Displaying Secret:
--------------------------
a. Display Secret
b. Display complete details of Secret
b. Display Secret and print that in YAML format


***************************************************************************************************


TASK-3: Injecting Secret into Pod as Environment Variables:
-----------------------------------------------------------

a. Create a Pod with two environment variables. These two env variables consists values of username and password from above "cred-secret" Secret object.
b. Display the Pod.
c. Ensure above Pod is successfully configured with two environment variables. You can confirm that by running "exec" command with "env" option on that Pod.


***************************************************************************************************


TASK-4: Injecting "Secrets" into Pod As "Files" inside the Volume:
------------------------------------------------------------------

a. Create a Pod with "cred-secret" Secret mounted inside the Volumes. The username and password from above "cred-secret" Secret object shall be created as files inside the mount-path.
b. Display the Pod.
c. Ensure above Pod is successfully configured with "username" and "password" files and contents of that files shall be "admin" and "pa$$1254" as per the definition of "cred-secret".


***************************************************************************************************



TASK-5: Delete Pod and Secret: 
------------------------------
a. Delete the Pod created above.
b. Delete the "cred-secret" created in above task-1.
c. Ensure Pod and Secret is deleted successfully

  ```
</details>
  
- https://kubernetes.io/docs/concepts/configuration/secret/

- https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/

- https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-config-file/#create-the-config-file

- https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-em-
