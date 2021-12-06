- create a container/pod

<img width="788" alt="image" src="https://user-images.githubusercontent.com/75510135/144843448-38f34394-16d7-40e0-b36c-1ec047d22842.png">

<img width="920" alt="image" src="https://user-images.githubusercontent.com/75510135/144843592-b3598ad6-3eac-4e9d-ae9d-64f24941c165.png">

<img width="866" alt="image" src="https://user-images.githubusercontent.com/75510135/144843759-f1cfc729-4ca1-4c7b-bf12-2a8047eefd0e.png">

<img width="751" alt="image" src="https://user-images.githubusercontent.com/75510135/144844074-6d14b1b1-27aa-4780-9c5a-c5ca4163c0de.png">

<img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/144844220-5d6ce685-2e4d-44e2-841e-0def82494142.png">

<img width="936" alt="image" src="https://user-images.githubusercontent.com/75510135/144844355-f20ee211-b30d-4b3e-b1de-2a295de02314.png">
```
Depending on which version of Kubernetes you have installed, you'll need to decide how you'll create objects. Here's a cheat sheet for how old commands should be used with the 1.18 changes.

kubectl run nginx --image nginx created a Deployment named nginx before 1.18 (which creates a ReplicaSet, which creates a Pod)

kubectl run nginx --image nginx creates a Pod named nginx in 1.18+

Creating a Deployment in 1.18: kubectl create deployment nginx --image nginx

```
- Logs
<img width="821" alt="image" src="https://user-images.githubusercontent.com/75510135/144844676-6addc491-6572-4c13-8c33-ead08eacf4ce.png">

<img width="759" alt="image" src="https://user-images.githubusercontent.com/75510135/144845171-c43eef49-d281-49c4-88f3-5f649eefbba9.png">
<img width="653" alt="image" src="https://user-images.githubusercontent.com/75510135/144845296-22a98cd3-6398-4340-a591-6faed4d152fa.png">

- scale the application

<img width="898" alt="image" src="https://user-images.githubusercontent.com/75510135/144844851-5cc62f17-bdcb-4796-9fe7-79bce80784cf.png">

- delete pod
<img width="900" alt="image" src="https://user-images.githubusercontent.com/75510135/144859216-bd5752c7-6d95-4eaf-8b80-5b9f65183123.png">
<img width="734" alt="image" src="https://user-images.githubusercontent.com/75510135/144859419-fbb61c85-88aa-42ae-abd1-106d1eebd46a.png">

<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/144860716-0df2ce6f-d47f-4c47-836a-891c77186391.png">

<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/144861203-43362480-2714-42a8-b6ef-3a34ed3bf386.png">
<img width="665" alt="image" src="https://user-images.githubusercontent.com/75510135/144865206-3f2e1b70-c0de-492e-bc44-bbe700deb07c.png">

- cron jobs & resource creation option

<img width="885" alt="image" src="https://user-images.githubusercontent.com/75510135/144861530-c12d5ba6-bb19-41a4-85ef-10cde0a835a1.png">

<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144861875-1961bbf8-b861-430f-a0ff-305e05d96e5a.png">

<img width="996" alt="image" src="https://user-images.githubusercontent.com/75510135/144862097-63fc3abe-3718-4911-8d6f-3fbe12b5dddd.png">

<img width="726" alt="image" src="https://user-images.githubusercontent.com/75510135/144862343-f6d5cd78-e8be-4a07-8c0f-a022ef5cdd05.png">

- resource creation

<img width="759" alt="image" src="https://user-images.githubusercontent.com/75510135/144862452-f6f85785-e082-442a-96c7-8b64007c699e.png">

```
  502  kubectl run pingpong --image alpine ping 1.1.1.1
  503  kubectl delete pods/pingpong
  ~ $ watch kubectl get po
  ```
 
 <img width="693" alt="image" src="https://user-images.githubusercontent.com/75510135/144862731-f464b68a-048d-4fe2-aa13-64f472af2dbe.png">

<img width="699" alt="image" src="https://user-images.githubusercontent.com/75510135/144863271-13c57ec9-448b-49c5-8042-a446f2463829.png">
<img width="762" alt="image" src="https://user-images.githubusercontent.com/75510135/144863693-3c1bffb2-c5ac-4457-a914-39a2c86bdec8.png">

<img width="691" alt="image" src="https://user-images.githubusercontent.com/75510135/144864177-ffbcbdb9-c98f-4904-9b52-5429aa66d1f9.png">
<img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/144864243-665e9ca5-9d67-444b-8527-f52d42b95775.png">

<img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/144864269-ce150b5a-23c3-4f95-9a0b-ac6abd569447.png">

- log tool - STERN

<img width="765" alt="image" src="https://user-images.githubusercontent.com/75510135/144864505-f5e08df7-07b5-4bcd-84d4-f89d1ebc0ab9.png">
<img width="877" alt="image" src="https://user-images.githubusercontent.com/75510135/144864540-cde921e5-2495-411d-8e34-0ac7421c5044.png">

<img width="884" alt="image" src="https://user-images.githubusercontent.com/75510135/144864580-33d5954d-4a8b-4244-9f94-a20c59a6e735.png">

<img width="827" alt="image" src="https://user-images.githubusercontent.com/75510135/144864749-e9ca33a8-de78-4d58-b332-93c84bae13b1.png">

<img width="760" alt="image" src="https://user-images.githubusercontent.com/75510135/144864903-1fc4c74d-b2bc-47d6-860c-1041e5903037.png">

<img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/144865001-91376d62-8adc-4ace-8317-9d2146ddca4d.png">





