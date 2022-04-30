<details>
<summary>Introduction</summary>
<br>
  
  <img width="701" alt="image" src="https://user-images.githubusercontent.com/75510135/166090723-5b53dc1f-b448-4a1e-bf5e-8fee52cfcdd4.png">

  
  <img width="984" alt="image" src="https://user-images.githubusercontent.com/75510135/166090706-f5566a06-c843-451c-aaf5-9c132649edc3.png">
  
  <img width="990" alt="image" src="https://user-images.githubusercontent.com/75510135/166090696-3a16e6ea-b1ae-40ac-bfb3-0d9b03c77e58.png">

  <img width="820" alt="image" src="https://user-images.githubusercontent.com/75510135/166090680-4bc368b1-1a4e-42d7-875c-0b1979d27e3c.png">

  <img width="969" alt="image" src="https://user-images.githubusercontent.com/75510135/166090673-bd37eecf-78be-4ff3-a6d0-cd1a7a14ce71.png">

  <img width="854" alt="image" src="https://user-images.githubusercontent.com/75510135/166090662-3e1a9eee-b207-42df-9f2c-3073cf2e5935.png">

</details>

<details>
<summary>ConfigMap - Yaml</summary>
<br>
  
  <img width="886" alt="image" src="https://user-images.githubusercontent.com/75510135/166090928-1c7f9188-44b8-4efc-87f1-d654477e243e.png">

  
  <img width="1023" alt="image" src="https://user-images.githubusercontent.com/75510135/166090910-a708524e-a4e2-470e-a275-3843a677ce81.png">

  <img width="1008" alt="image" src="https://user-images.githubusercontent.com/75510135/166090883-5e0db30c-ad18-4a1d-a94b-afe4ad80adb2.png">

</details>

<details>
<summary>Injecting ConfigMap into Pods via Env vars</summary>
<br>

  <img width="992" alt="image" src="https://user-images.githubusercontent.com/75510135/166091326-693c465c-0f01-4d74-b8eb-4f742a5bc38d.png">

  <img width="1015" alt="image" src="https://user-images.githubusercontent.com/75510135/166091344-a2ee7eba-6190-4af0-879d-d91098094631.png">

</details>

<details>
<summary>Injecting ConfigMap into Pods via Args</summary>
<br>

  <img width="992" alt="image" src="https://user-images.githubusercontent.com/75510135/166091326-693c465c-0f01-4d74-b8eb-4f742a5bc38d.png">
  
  <img width="779" alt="image" src="https://user-images.githubusercontent.com/75510135/166091382-8a29fe62-deb2-4d80-805b-cbf330f93f65.png">

  
</details>

<details>
<summary>Injecting ConfigMap into Pods via Files in Volume</summary>
<br>

  <img width="992" alt="image" src="https://user-images.githubusercontent.com/75510135/166091326-693c465c-0f01-4d74-b8eb-4f742a5bc38d.png">
  
  <img width="1005" alt="image" src="https://user-images.githubusercontent.com/75510135/166091416-abdd0508-c701-4947-a272-9193df22b1ca.png">

  
</details>

<details>
<summary>ConfigMap - Tasks(how-to)</summary>
<br>

  <img width="1026" alt="image" src="https://user-images.githubusercontent.com/75510135/166091498-3a46e446-d713-48db-90ba-3263c50a45ec.png">

</details>

<details>
<summary>Practice - practice and practice :) </summary>
<br>

  ```
          * Reference:                                                                                      *
        * ----------                                                                                      *
        * https://kubernetes.io/docs/concepts/configuration/configmap/                                    *
        * https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/               *
        * https://cloud.google.com/kubernetes-engine/docs/concepts/configmap                              *
        * https://matthewpalmer.net/kubernetes-app-developer/articles/ultimate-configmap-guide-kubernetes.html
        *                                                                                                 *
        NOTE: Create ConfigMap before you use it inside Pod



        1. Creating Configmap Declaratively (Using YAML file):
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Example-1:
        ---------
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: env-config-yaml
        data:
          ENV_ONE: "va1ue1" 
          ENV_TWO: "va1ue2"



        Example-2:
        ----------
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: my-nginx-config-yaml
        data:
          my-nginx-config.conf: |-
            server {
              listen 80;
              server_name www.kubia-example.com;
              gzip on;
              gzip_types text/plain application/xml;
              location / {
                root /usr/share/nginx/html;
                index index.html index.htm;
              }
            }
            sleep-interval: 25



        ***************************************************************************************************


        2. Creating ConfigMap Imperatively (from Command line):
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        kubectl create configmap <NAME> <SOURCE>


        From Literal value:
        ------------------
        kubectl create configmap env-config-cmd --from-literal=ENV_ONE=value1 --from-literal=ENV_TWO=value2


        From File:
        ----------
        kubectl create configmap my-ngix-config-file-cmd --from-file=/path/to/configmap-file.txt

        kubectl create configmap my-config --from-file=path/to/bar


        ***************************************************************************************************


        3. Displaying ConfigMap:
        ~~~~~~~~~~~~~~~~~~~~~~~~

        kubectl get configmap <NAME>
        kubectl get configmap <NAME> -o wide
        kubectl get configmap <NAME> -o yaml
        kubectl get configmap <NAME> -o json

        kubectl describe configmap <NAME>


        ***************************************************************************************************


        4. Editing ConfigMap:
        ~~~~~~~~~~~~~~~~~~~~~

        kubectl edit configmap <NAME>


        ***************************************************************************************************


        5. Injecting ConfigMap into Pod As Environment Variables (1/3):
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        # cm-pod-env.yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: cm-pod-env
        spec:
          containers:
            - name: test-container
              image: nginx
              env:
              - name: ENV_VARIABLE_1
                valueFrom:
                  configMapKeyRef:
                    name: env-config-yaml
                    key: ENV_ONE
              - name: ENV_VARIABLE_2
                valueFrom:
                  configMapKeyRef:
                    name: env-config-yaml
                    key: ENV_TWO
          restartPolicy: Never


        Deploy:
        -------
        kubectl apply -f cm-pod-env.yaml

        Validate:
        ---------
        kubectl exec cm-pod-env -- env | grep ENV


        ***************************************************************************************************


        6. Injecting ConfigMap into Pod As Arguments(2/2):
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # cm-pod-arg.yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: cm-pod-arg
        spec:
          containers:
            - name: test-container
              image: k8s.gcr.io/busybox
              command: [ "/bin/sh", "-c", "echo $(ENV_VARIABLE_1) and $(ENV_VARIABLE_2)" ]
              env:
              - name: ENV_VARIABLE_1
                valueFrom:
                  configMapKeyRef:
                    name: env-config-yaml
                    key: ENV_ONE
              - name: ENV_VARIABLE_2
                valueFrom:
                  configMapKeyRef:
                    name: env-config-yaml
                    key: ENV_TWO
          restartPolicy: Never


        Deploy:
        ---------
        kubectl apply -f cm-pod-arg.yaml

        Validate:
        ---------
        kubectl logs cm-pod-arg


        ***************************************************************************************************


        7. Injecting ConfigMap into As Files inside Volume(3/3):
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # cm-pod-file-vol.yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: cm-pod-file-vol
        spec:
          volumes:
            - name: mapvol
              configMap:
                name: my-nginx-config-yaml
          containers:
            - name: test-container
              image: nginx
              volumeMounts:
              - name: mapvol
                mountPath: /etc/config
          restartPolicy: Never


        Deploy:
        -------
        kubectl apply -f cm-pod-file-vol.yaml

        Validate:
        ----------
        kubectl exec configmap-vol-pod -- ls /etc/config
        kubectl exec configmap-vol-pod -- cat /etc/config/etc/config/my-nginx-config.conf


        ***************************************************************************************************


        8. Running operations directly on the YAML file:
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        kubectl [OPERATION] –f [FILE-NAME.yaml]
        kubectl get –f [FILE-NAME.yaml]
        kubectl delete –f [FILE-NAME.yaml]
        kubectl get -f [FILE-NAME.yaml]
        kubectl create -f [FILE-NAME.yaml]


        ***************************************************************************************************


        9. Delete ConfigMap:
        ~~~~~~~~~~~~~~~~~~~~
        kubectl delete configmap <NAME>
  ```
</details>
  
  
<details>
<summary>Exercise</summary>
<br>

  ```
  * Reference:                                                                                      *
            * ----------                                                                                      *
            * https://kubernetes.io/docs/concepts/configuration/configmap/                                    *
            * https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/               *
            * https://cloud.google.com/kubernetes-engine/docs/concepts/configmap                              *
            * https://matthewpalmer.net/kubernetes-app-developer/articles/ultimate-configmap-guide-kubernetes.html
            *                                                                                                 *
            ***************************************************************************************************

            In this demo:
            -------------
            We will create the ConfigMap using both Imperatively and Declaratively
            Next, we will use above ConfigMap into Pod, as environment variables, arguments, and files inside vol.


            NOTE: 
            -----
            a. To successfully finish this exercise, It is important to go through ConfigMap Concept and Demo videos in this series.
            b. You can refer to Kuberenetes Docs for help when needed.


            ***************************************************************************************************

            STEP-1: Create ConfigMap: 
            -------------------------

            Create ConfigMap from literal values with below configuration

            ConfigMap Name: env-cm
            Literals: ENV_ONE=value1 & ENV_TWO=value2


            ***************************************************************************************************


            STEP-2: Displaying ConfigMap:
            -----------------------------

            a. Display ConfigMap "env-cm" 
            b. Display ConfigMap "env-cm" and print that in YAML format.
            c. Display complete details of "env-cm" ConfigMap


            ***************************************************************************************************


            STEP-3: Injecting ConfigMap into Pod As Environment Variables: 
            ---------------------------------------------------------

            Configure & Deploy:
            -------------------
            a. Create the sample Pod with two environment variables. These two Env variables will get the values from "env-cm" ConfigMap.

            Validate:
            ---------
            b. Run the env command inside the Pod to validate the above two environment variables are successfully configured.


            ***************************************************************************************************

            STEP-4: Delete the ConfigMap:
            -----------------------------
            a. Delete the Pod and ConfigMap created in the above step.
            b. Ensure ConfigMap and Pod deleted successfully.


  ```
</details>
