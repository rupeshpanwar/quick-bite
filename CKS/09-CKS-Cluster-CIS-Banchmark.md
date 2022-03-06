- https://www.cisecurity.org/benchmark/kubernetes
- https://github.com/aquasecurity/kube-bench
- https://www.youtube.com/watch?v=53-v3stlnCo
- https://github.com/docker/docker-bench-security




<details>
<summary>Introduction</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156906504-a501e2ff-6766-4256-81b2-1a08981d62e2.png)

  ![image](https://user-images.githubusercontent.com/75510135/156906512-b76d8295-bb81-4783-9d22-b25d6e0ff934.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/156906539-bdc204b1-2365-4ca5-ab03-f937bd2226e3.png)

  ![image](https://user-images.githubusercontent.com/75510135/156906579-a73dab18-787b-417b-94ca-2a1380bcb45b.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/156906794-b94f6ab1-54f2-4a9e-b988-7f8298eb0d17.png)

  ![image](https://user-images.githubusercontent.com/75510135/156906809-966267a3-c494-4142-acce-d756b98a1a07.png)

  ![image](https://user-images.githubusercontent.com/75510135/156906821-70146f92-6089-472a-8e5f-056ada53c84e.png)

</details>

<details>
<summary>Kube Bench</summary>
<br>
  
  - how to run
    https://github.com/aquasecurity/kube-bench/blob/main/docs/running.md
  
  - run on master

  > docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23
  
  <img width="290" alt="image" src="https://user-images.githubusercontent.com/75510135/156907149-556c027f-a9ad-401c-8fef-01494c791fe3.png">

  - check for failed one
  
  <img width="836" alt="image" src="https://user-images.githubusercontent.com/75510135/156907175-dde3a158-35ee-46de-8efe-1e60c8ee6b74.png">

  - look into pdf document
  
  ![image](https://user-images.githubusercontent.com/75510135/156907183-338e6a31-232d-42bb-9227-e6da73085c34.png)

  ![image](https://user-images.githubusercontent.com/75510135/156907189-beaea48f-ab42-4fb2-b7fd-9093434421ac.png)

  - remediate
  
  ![image](https://user-images.githubusercontent.com/75510135/156907215-1d1ac68e-0ccc-4590-8067-24341089f436.png)
  
  ```
    kubectl version
    docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23
    ps -ef | grep etcd
    stat -c %U:%G /var/lib/etcd
    useradd etcd
    chown etcd:etcd /var/lib/etcd
    docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23
  
  ```

  <img width="300" alt="image" src="https://user-images.githubusercontent.com/75510135/156907250-993487bc-07f3-4a69-bd56-9d3df4eccf40.png">

  - validate 
  
  <img width="833" alt="image" src="https://user-images.githubusercontent.com/75510135/156907293-27c34e71-7e49-4359-912c-069f7db61ecc.png">

  -  run on worker
  
  > docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=node --version 1.22

</details>


<details>
<summary>Add-on</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156907329-73ef2c70-d198-478a-8f55-36f90fbc9799.png)

  
</details>

