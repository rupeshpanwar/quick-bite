

<details>
<summary>Introduction</summary>
<br>

 <img width="976" alt="image" src="https://user-images.githubusercontent.com/75510135/166925655-782939ef-d2ef-4e6e-908b-e422ba6a02f7.png">

<img width="988" alt="image" src="https://user-images.githubusercontent.com/75510135/166926044-cdf9ec13-4aa0-4b56-b678-fc164c4fc20a.png">

<img width="971" alt="image" src="https://user-images.githubusercontent.com/75510135/166926087-7feac2ce-2c01-4108-a7f1-547883fb9538.png">

<img width="901" alt="image" src="https://user-images.githubusercontent.com/75510135/166926193-2df7faec-5d0d-4ad2-b7cc-7856e774f32c.png">

</details>

<details>
<summary>Kick-off Skaffold</summary>
<br>

  - skaffold.yml
  ```
  apiVersion: skaffold/v1
kind: Config
build:
  artifacts:
  - image: wardviaene/skaffold-demo
deploy:
  kubectl:
    manifests:
      - k8s-*
  ```
  
  - Dockerfile
  ```
  FROM golang:1.12.9-alpine3.10 as builder
COPY main.go .
RUN go build -o /app main.go

FROM alpine:3.10
CMD ["./app"]
COPY --from=builder /app 
  ```
  - pod / deployment => k8s-pod.yml
  ```
  apiVersion: v1
kind: Pod
metadata:
  name: skaffold-demo
  labels:
    app: skaffold-demo
spec:
  containers:
  - name: skaffold-demo
    image: wardviaene/skaffold-demo
---
apiVersion: v1
kind: Service
metadata:
  name: skaffold-demo
spec:
  selector:
    app: skaffold-demo
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080

  ```
  - next project code in same folder space
  <img width="255" alt="image" src="https://user-images.githubusercontent.com/75510135/166929046-4b052ee8-c0a1-4fda-9df2-8f8e9560bb64.png">

</details>



<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
