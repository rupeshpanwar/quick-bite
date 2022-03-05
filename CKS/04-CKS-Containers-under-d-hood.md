

<details>
<summary>Containers & Images</summary>
<br>
  
   - Container n Image
  
  ![image](https://user-images.githubusercontent.com/75510135/155883218-7b48ad68-14b9-4d72-a958-a85642d0417b.png)


  - Container
  
  ![image](https://user-images.githubusercontent.com/75510135/155883264-6585fda4-7417-4c46-9d15-4d63ae2f2824.png)

  ![image](https://user-images.githubusercontent.com/75510135/155883372-498a2615-21e3-490a-828d-3ade605967f9.png)

  ![image](https://user-images.githubusercontent.com/75510135/155883456-7d33c891-ce1c-45b2-8545-84c4b1e90823.png)

  ![image](https://user-images.githubusercontent.com/75510135/155883544-61db9aae-3579-4eae-b9e3-c4e3a3ba68aa.png)

  - Docker Vs VM
  
  ![image](https://user-images.githubusercontent.com/75510135/155883607-8b42e8da-eeb9-4ad3-9a50-a6def375f250.png)

  

</details>


<details>
<summary>Separation / Isolation - Linux Kernel NS</summary>
<br>

  - Linux Kernel NS
  
  ![image](https://user-images.githubusercontent.com/75510135/155883676-bc1bd848-d1ce-4bd9-8cab-b252dd4f5e9b.png)

  ![image](https://user-images.githubusercontent.com/75510135/155883713-53a49e02-1e85-4ba0-803f-b10d94b8a888.png)

  ![image](https://user-images.githubusercontent.com/75510135/155883693-2a85e3fc-d571-452f-a37f-2af0308eceb2.png)

  ![image](https://user-images.githubusercontent.com/75510135/155883702-43c9771a-d6bd-49b6-8edb-01e1cbedd3cf.png)

  - Container Isolation
  
  ![image](https://user-images.githubusercontent.com/75510135/155883783-072933fe-cdae-4853-b8b4-e24ca3a1b29f.png)

  
</details>


<details>
<summary>Container Tools - Docker, Containerd , Crictl and Podman</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/155883895-67491109-b91d-4d99-a2c2-17fe6f62afea.png)

  - Docker
  
  ```
    # Create a Dockerfile
      FROM bash
      CMD ["ping","google.com"]

      # build the docker image
      docker build -t simple .

      # list the image
      docker image ls | grep simple

      # run container 
      docker run simple
  ```
  
  - PODMAN # replace docker with podman
  
  ```

    podman build -t simple .

    podman image ls 

    podman run simple

  ```
  
  - CRICTL
  
  ```
      # list the containers
    crictl ps

    # crictl config sneak-peak
    cat /etc/crictl.yaml
  
  ```
  
  <img width="698" alt="image" src="https://user-images.githubusercontent.com/75510135/155884733-de3ecded-4e04-4b38-950a-085bb4ebad5e.png">
  
  <img width="663" alt="image" src="https://user-images.githubusercontent.com/75510135/155884799-37d89934-3064-4d95-9a8c-ccc64a32d60c.png">

  <img width="700" alt="image" src="https://user-images.githubusercontent.com/75510135/155884878-b6086db5-8393-4caa-8416-f73764cc3c2d.png">


</details>


<details>
<summary>PID Namespace</summary>
<br>

  ```
      ##### COntainer hunder d HOOD
      docker <cmd> --name <container-name> <image-name> <process-to-run-inside-container>
      #container c11
      docker run --name c1 -d ubuntu sh -c 'sleep 1d'

      docker exec c1 ps aux

      #container c12
      docker run --name c2 -d ubuntu sh -c 'sleep 999d'

      docker exec c2 ps aux

      # check the host kernel
      ps aux | grep sleep

      # remove C2
      docker rm c2 --force

      # now run c2 container in Namespace of C1
      docker run --name c2 --pid=namespace:c1 ubuntu sh -c 'sleep 999d'

      # then check the process running on C1 n C2
      docker exec c1 ps aux
      docker exec c2 ps aux
  ```
  
</details>



<details>
<summary>Add-on</summary>
<br>

    
  ![image](https://user-images.githubusercontent.com/75510135/156876561-87196e7e-ebc1-463e-a1a1-c77668fcbd48.png)

</details>


