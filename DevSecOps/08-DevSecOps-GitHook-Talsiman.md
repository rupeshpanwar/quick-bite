
- https://github.com/thoughtworks/talisman

**Steps**

<details>
<summary>Introduction</summary>
<br>

![image](https://user-images.githubusercontent.com/75510135/154780011-3ddeff85-40cc-4fb3-abba-1da587cd9b09.png)

![image](https://user-images.githubusercontent.com/75510135/154780024-2ea12a91-ab25-4409-9016-e1f4e7a73f32.png)

![image](https://user-images.githubusercontent.com/75510135/154785840-2b009504-3c23-4f61-b4eb-130f4643caf0.png)

![image](https://user-images.githubusercontent.com/75510135/154785880-6eb01f9c-c67d-4faf-9437-bfb89fcee22e.png)

![image](https://user-images.githubusercontent.com/75510135/154785909-1090c94c-a472-4dfb-89e0-97c98f248460.png)

![image](https://user-images.githubusercontent.com/75510135/154785925-fa12a8af-e27a-4758-a5a1-3680ba8411dd.png)
  
    
</details>

<details>
<summary>1. Install Talisman</summary>
<br>

    
 
    # Download the talisman installer script
    curl https://thoughtworks.github.io/talisman/install.sh > ~/install-talisman.sh
    chmod +x ~/install-talisman.sh

<img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/154786550-2cdd277f-fe86-4cf5-a376-d82e2ba8f38d.png">

    git clone https://github.com/rupeshpanwar/devsecops-k8s.git
    ls -lrt devsecops-k8s/.git/hooks

<img width="588" alt="image" src="https://user-images.githubusercontent.com/75510135/154786649-27ae3938-b08a-4666-9b23-ebc46964e276.png">

    
</details>


<details>
<summary>2. Install Talisman pre-push hook(into .git)</summary>
<br>
    
 - download git repo here to proceed with installation as It's a pre-push hook that needs to be attached with .git/hooks

    cd devsecops-k8s/
     ~/install-talisman.sh

<img width="1022" alt="image" src="https://user-images.githubusercontent.com/75510135/154786714-dcabe4ea-ebcd-466d-9695-1ac8692da754.png">


<img width="638" alt="image" src="https://user-images.githubusercontent.com/75510135/154786752-f1a7e696-af5a-4f01-a698-eae30327dc5d.png">


    
</details>


<details>
<summary>3. Fail git push => Test by exposing some security related stuff </summary>
<br>

    
    cd devsecops-k8s
    mkdir sec_files && cd sec_files
    echo "username=rupesh-panwar" > file1
    echo "secure-password123" > password.txt
    echo "apikey=AizaSyCqhjgrPtr_La56sdUkjfav_laCqhjgrPtr_2s" > file2
    echo "base64encodedsecret=cGFzc3dvcmQtaXMtcXdlcnR5MTIzCg==" > file3




<img width="1146" alt="image" src="https://user-images.githubusercontent.com/75510135/154786891-dcdc2268-009a-42a8-a905-8ff652455a00.png">

- when git push is attempted
<img width="784" alt="image" src="https://user-images.githubusercontent.com/75510135/154787341-73c42270-98ed-450f-8604-ae963a74ae87.png">

<img width="1379" alt="image" src="https://user-images.githubusercontent.com/75510135/154787346-1c1e511e-8d38-4058-b813-db1b29316629.png">
</details>

<details>   
<summary>4. Configure Talisman to ignore some files(having sensitive data)</summary>
<br>

  
 - in the project root dir, create file .talismanrc with content filename n checksum detected above
 <img width="723" alt="image" src="https://user-images.githubusercontent.com/75510135/154787477-441128bf-156f-478d-b292-a533814f2b61.png">

- and again perform git push 
  
 
</details>


