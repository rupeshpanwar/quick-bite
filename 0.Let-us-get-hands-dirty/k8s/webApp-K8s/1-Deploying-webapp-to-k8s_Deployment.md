<details>
<summary>Task 4: Create a Pod</summary>
<br>

In this step, we’ll create a pod in the pods.yaml file. This file is found in the root of the usercode directory. The YAML file should contain:

    Pod name: kubernetes-pod
    labels: project:kubernetes-project
    port: 31111

Now, we’ll deploy the Pod and ensure that it’s running.

> kubectl run kubernetes-pod --port 31111 --image rupeshpanwar/dotnetapp --dry-run=client -o yaml
```
apiVersion: v1
kind: Pod
metadata:
  labels:
    project: kubernetes-project
  name: kubernetes-pod
spec:
  containers:
  - image: rupeshpanwar/dotnetapp
    name: kubernetes-pod
    ports:
    - containerPort: 31111
```

<img width="997" alt="image" src="https://user-images.githubusercontent.com/75510135/167156660-b6c68739-6972-443c-9655-25a33c40536d.png">

    > kubectl -f pods.yaml create
    > kubectl get pods
    
<img width="697" alt="image" src="https://user-images.githubusercontent.com/75510135/167156984-c2517d2f-0e45-4b36-b613-ac445fe92ced.png">

    
</details>

<details>
<summary>Test the Pod</summary>
<br>

    Here we will test the creation of the pod. The test can be run by running the following command in the terminal:

    > ./test_1

Here are the expected outputs:

    Passed: If the pod is running.
    No resources found in default namespace. Failed: If the pod is not found.
    Status of the pod: If the pod is not in any of the above states.

<img width="411" alt="image" src="https://user-images.githubusercontent.com/75510135/167158317-3a222456-e8de-4fd7-ad25-fe05ed5335b9.png">

    
</details>

<details>
<summary>Task 5: Create a Deployment</summary>
<br>

    In this step, we’ll create a Deployment. We can do that in the deployment.yaml file. Our Deployment file should contain:

    Deployment name: kubernetes-deployment
    labels: kubernetes-project
    replicas: 2
    spec.selector.matchLabels project: kubernetes-project
    spec.template.metadata.labels project: kubernetes-project
    port: 31111

Now, we’ll create this Deployment.
    > kubectl create deployment kubernetes-deployment --replicas 2 --image rupeshpanwar/dotnetapp --dry-run=client -o yaml > deployment.yaml
    
    ```
    apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubernetes-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      project: kubernetes-project
  template:
    metadata:
      labels:
        project: kubernetes-project
    spec:
      containers:
      - imagePullPolicy: Always
        name: kubernetes-pod
        image: rupeshpanwar/dotnetapp
        ports:
        -  containerPort: 31111
    ```
    >  kubectl -f deployment.yaml create
    >  kubectl get deployment
    >  kubectl get pods
    
    <img width="629" alt="image" src="https://user-images.githubusercontent.com/75510135/167161102-1a6f4f93-b097-4641-aa08-bab64c6cb4fb.png">

    
</details>

<details>
<summary>Test the Deployment</summary>
<br>

    Here we will test the creation of the pod. The time can be run by running the following commands in the terminal:

 > ./test_2

Here are the expected outputs:

    Passed: If the deployment is running.
    No resources found in default namespace. Failed: If the deployment is not found.
    Waiting: If the deployment is in the creation process.

<img width="462" alt="image" src="https://user-images.githubusercontent.com/75510135/167161346-649e5b6d-ece2-4b02-82da-952f5a8e2594.png">

    
</details>

<details>
<summary>Task 6: Create a Service</summary>
<br>

    In this step, we’ll create a Service. We can do that in the service.yaml file.

Our Service object should contain:

    Service name: kubernetes-svc
    protocol: TCP
    spec.selector.project: kubernetes-project
    spec.type: NodePort
    Port: 31111
    targetPort: 3000
    nodePort: 31111

Now, we’ll create the Service. We’ll need to reload the browser to view the output.

    
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
