<details>
<summary>Introduction & Architecture</summary>
<br>

  <img width="807" alt="image" src="https://user-images.githubusercontent.com/75510135/163704481-e4a73cf9-34da-4e87-9ac3-88096212c7f7.png">

  <img width="825" alt="image" src="https://user-images.githubusercontent.com/75510135/163704509-f654c766-b898-4bbd-8bab-e77b8ce9c8c6.png">

  <img width="740" alt="image" src="https://user-images.githubusercontent.com/75510135/163705108-af20c6e8-7fbe-4ccf-8ce8-afb1bfb5c8f0.png">

  <img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/163705170-7ec41d55-d7cc-455c-8490-a7acf150f0b6.png">

  <img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/163705200-95181ebe-030d-404b-94d4-db67100abc5e.png">

  <img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/163705224-08c636b2-c864-4a36-a22d-edadf7718c45.png">

  <img width="665" alt="image" src="https://user-images.githubusercontent.com/75510135/163705236-69e0dd47-f12f-42e6-8035-594710996322.png">

  - Architecture
  <img width="622" alt="image" src="https://user-images.githubusercontent.com/75510135/163705290-9a7fc331-33c2-4e4c-8d74-f4b4386ea4a9.png">

  <img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/163705369-a2d80f7e-c90f-4ec5-b50c-1c7d0ab437e7.png">

  <img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/163705448-d984b439-88c3-4333-a3ce-81f4f0739a5a.png">

  <img width="735" alt="image" src="https://user-images.githubusercontent.com/75510135/163705479-b0914021-5b1d-4140-bc1d-c727e96ba630.png">

  <img width="756" alt="image" src="https://user-images.githubusercontent.com/75510135/163705501-b3e8419b-f3ff-44fe-9afa-dbf558d3cb02.png">

  <img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/163705529-054044dd-72d0-4189-9b71-2802b8963cd6.png">

  <img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/163705577-7beeaf29-87f6-49b2-90f8-971f97a95ad3.png">

  <img width="751" alt="image" src="https://user-images.githubusercontent.com/75510135/163705586-ad6d5a3e-44f6-4435-a3e3-afce7dbffea9.png">

</details>

<details>
<summary>Setup K8s</summary>
<br>

  <img width="658" alt="image" src="https://user-images.githubusercontent.com/75510135/163705649-02547edf-0192-420d-88d7-2f731cd36379.png">

  - after VM setup is done(min 4GB Ram => it directly map to Number of IPAddress for PODS)
  ```
          ********** Install Docker CE Edition **********
        1. Uninstall old versions
        sudo apt-get remove docker docker-engine docker.io containerd runc

        2. Update the apt package index 
        sudo apt-get update

        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release

        3. Add Docker’s official GPG key:
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

        4. Use the following command to set up the stable repository
        echo \
          "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        5. Install Docker Engine
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io

        6. verify Docker version
        docker --version


        ********** Install KubeCtl **********
        1. Download the latest release
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

        2. Install kubectl
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

        3. Test to ensure the version you installed is up-to-date:
        kubectl version --client


        ********** Install MiniKube **********
        1. Download Binay
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        chmod +x minikube-linux-amd64

        2. Install Minikube
        sudo install minikube-linux-amd64 /usr/local/bin/minikube

        3. Verify Installation
        minikube version

        4. Start Kubernetes Cluser
        sudo apt install conntrack
        sudo minikube start --vm-driver=none

        5. Get Cluster Information
        kubectl config view
  ```
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
