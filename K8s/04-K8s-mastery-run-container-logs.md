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

