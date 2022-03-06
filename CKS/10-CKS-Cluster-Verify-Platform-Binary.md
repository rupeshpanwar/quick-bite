- https://github.com/kubernetes/kubernetes
- https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md#source-code



<details>
<summary>Introduction</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156907456-20a42918-b87d-4bdc-bf97-29dd909d74b5.png)

  ![image](https://user-images.githubusercontent.com/75510135/156908974-a09d482f-cf9d-437e-abd1-70912eeb1382.png)

</details>

<details>
<summary>Verifying the hash</summary>
<br>

  ![image](https://user-images.githubusercontent.com/75510135/156909189-06cf558d-ad50-46d7-9f35-bd0a3ed629c6.png)
  
  -0 download the binary
 >  wget https://dl.k8s.io/v1.23.4/kubernetes-server-linux-amd64.tar.gz
  
 > sha512sum kubernetes-server-linux-amd64.tar.gz > compare
 > vi compare 
 
  - take the sha from github n paste it in compare file
  
  >  cat compare | uniq
  
  <img width="846" alt="image" src="https://user-images.githubusercontent.com/75510135/156909264-9b9e9146-ddf4-4fbb-b2b7-8b5ff3911daa.png">

  
  
  
</details>

<details>
<summary>Compare hash running inside container</summary>
<br>
  
  ```
      tar xzf kubernetes-server-linux-amd64.tar.gz 
    ls
    ls kubernetes/server/bin
    kubernetes/server/bin/kube-apiserver --version
    k -n kube-system get pod | grep api
    k -n kube-system get pod kube-apiserver-cks-master -oyaml | grep image
    sha512sum kubernetes/server/bin/kube-apiserver
    crictl ps | grep api
    ps aux | grep kube-api-server
    ls /proc/7339/root/
    find /proc/7339/root/ | grep kube-api
    sha512sum /proc/7339/root/usr/local/bin/kube-apiserver
  
  ```
</details>
