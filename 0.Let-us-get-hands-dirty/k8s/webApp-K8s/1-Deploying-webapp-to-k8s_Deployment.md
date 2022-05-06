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
