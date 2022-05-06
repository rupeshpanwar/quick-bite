<details>
<summary>Project Description</summary>
<br>

  <img width="712" alt="image" src="https://user-images.githubusercontent.com/75510135/167150365-b04b6453-a446-4f9a-afa0-d87c2c7b3a77.png">

  ### Project Description

Docker is a containerization platform, which allows us to pack our applications into containers. It packages our services into different containers that run on the same host, but have isolated environments.

Kubernetes is an open-source platform that lets us deploy and manage containerized applications. Kubernetes takes and manages services, from the deployment stage to the final stage of exposure. Beyond that, Kubernetes also automatically restarts crashed applications and load balances the traffic between replicas.

In this project, we’ll first test our Docker and Kubernetes skills. We’ll use Docker to containerize our application, and we’ll push it to Docker Hub for later use. Then, we’ll deploy a single Pod, using Kubernetes. Finally, we will expose our application to the outside world, using a Kubernetes Service.

  <img width="465" alt="image" src="https://user-images.githubusercontent.com/75510135/167150771-bde00584-1bcf-43fa-9e71-4454f3b31343.png">

  
</details>

<details>
<summary>Task 1: Containerize Our Application</summary>
<br>

  Containerizing our application

We’ll start by containerizing our application. We don’t need to worry about the setup, 
  because a React application has already been created for us to use during this project. 
  This application will print a “Hello from Docker!” message.

The Application folder is the root folder of our application. It contains all of the necessary files that make up the application, namely:

    Dockerfile: This file is not a part of the application. However, it contains all the commands that are needed to create a Docker image.
    package.json: This file is responsible for handling all of the required dependencies for the project.
    package-lock.json: This file contains the tree that is generated when the node modules tree or the package.json file is modified.
    public: This folder contains HTML files and other assets of the application.
    src: This folder is where the main code of the application lies.

Now that we have all the essentials to make an application, we need to create a Dockerfile for it. This Dockerfile will be responsible for executing all of the commands that are required to create an image, and for executing the application successfully.

  <img width="602" alt="image" src="https://user-images.githubusercontent.com/75510135/167152390-8df5754a-43e2-4946-89cc-70c6d2c483ea.png">

  
</details>

<details>
<summary>Task 2: Build and Push the Image</summary>
<br>

  Now that we have a Dockerfile, it’s time for us to move another step ahead. In this section, we will build our Docker image and push it to Docker Hub.
Create a Docker image

We can use the following commands to create a Docker image:

> docker build -t image_name . 
> docker build -t rupeshpanwar/dotnetapp .

    Note: It will take some time to create the image.
<img width="708" alt="image" src="https://user-images.githubusercontent.com/75510135/167153239-17db45e0-53c4-4622-9a05-c1e361b79382.png">
  <img width="419" alt="image" src="https://user-images.githubusercontent.com/75510135/167153867-460e0b06-4295-449e-bd79-66f944abb4f0.png">

We can use the following command to check our image. It will list all of the images:

> docker images
<img width="710" alt="image" src="https://user-images.githubusercontent.com/75510135/167153939-54dd13a2-d562-4cc7-a08a-b3277b606147.png">

Docker login
<img width="814" alt="image" src="https://user-images.githubusercontent.com/75510135/167154183-4a6c05e4-afb5-4885-9277-d640d2081c90.png">

Push the image to Docker Hub

Now that we have a Docker image, it’s time for us to figure out a way to push that image to Docker Hub.
> docker push rupeshpanwar/dotnetapp   
  
<img width="770" alt="image" src="https://user-images.githubusercontent.com/75510135/167154247-298bb185-a3fd-49e8-8028-ea85b7f40e5f.png">

</details>

<details>
<summary>Task 3: Set Up and Verify the Cluster</summary>
<br>

  Set up the cluster

We don’t need to worry about setting up a Kubernetes cluster. The tools needed to set up the cluster have already been installed for us.
Verify the cluster

Once the cluster is created, we should verify that our cluster is up and running.

  <img width="575" alt="image" src="https://user-images.githubusercontent.com/75510135/167154558-a17b1e94-6257-4e18-ad1f-d6f3af618832.png">

  
</details>
