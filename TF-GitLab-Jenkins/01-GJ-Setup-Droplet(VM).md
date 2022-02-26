-  https://developers.digitalocean.com/documentation/v2/#list-all-sizes
-  https://github.com/rupeshpanwar/tf-digitaloocean-droplet  => TF code to spin the droplet



<details>
<summary>@Via Terraform, Create a Ubuntu VM in Digital Ocean</summary>
<br>
- Install TF, on Mac
  
  ```
  brew install terraform
  terraform version
  
        Terraform v1.1.6
         on darwin_amd64
  ```
  
- Generate DigitalOcean Access Token
  1. Login DigitalOcean portal and head over to API > Applications & API > Tokens/Keys > Generate New Token
  ![image](https://user-images.githubusercontent.com/75510135/155837135-3fd83c76-5a9a-4d3b-b11e-96b2578d2215.png)

  ![image](https://user-images.githubusercontent.com/75510135/155837157-0e11bd1f-e469-478a-8eba-93fa39461b34.png)
  
  2. Copy Token ID and save as environment variable in your ~/.bashrc or ~/.zshrc file.
  ![image](https://user-images.githubusercontent.com/75510135/155837193-1d119474-7f4c-4ebf-a19d-261282e47c7a.png)
  
  ![image](https://user-images.githubusercontent.com/75510135/155837273-8a23180a-0dbe-4358-9228-01f521ff5ce3.png)

  3. Once the file is modified with the Token ID source the file to update the settings 
  > source ~/.bashrc
  
  and then confirm the token
  > echo $DIGITALOCEAN_TOKEN
  
  4. [MUST]Authenticate Digital Ocean account from CLI
  ```
  doctl auth init
  - insert token created above
   export DIGITALOCEAN_ACCESS_TOKEN=<token>
  - verify if you can access via cli
  doctl account get
  ```

</details>


<details>
<summary> Add your SSH Public Key to DigitalOcean</summary>
<br>

  1. SSH keys generate with the command below
  > ssh-keygen
  
  2. SSH public key will be located in **~/.ssh/id_rsa.pub** by default
  
  > cat ~/.ssh/id_rsa.pub
  
  <img width="1008" alt="image" src="https://user-images.githubusercontent.com/75510135/155837397-1cec90eb-4b4c-4235-aeed-dad11c3d319f.png">

  3. Navigate to Settings > Security > SSH keys > Add SSH Key
  
  ![image](https://user-images.githubusercontent.com/75510135/155837467-074a4a51-a32c-43fc-b954-e8fcabeddc17.png)

  ![image](https://user-images.githubusercontent.com/75510135/155837474-14c2f16a-ab62-4b32-bcf1-74cf9e0c91d3.png)

  
  
</details>




<details>
<summary>Create Terraform Code to create Droplet</summary>
<br>

  1. Create a new dir
  
  > mkdir digitalocean-tf
  
  > cd digitalocean-tf
  
  2. Initiate digitalocean providers by below code
  
  > touch main.tf
  
  ```
        terraform {
        required_providers {
          digitalocean = {
            source = "digitalocean/digitalocean"
          }
        }
        }
  ```
  
  > run => terraform init
  
  <img width="1047" alt="image" src="https://user-images.githubusercontent.com/75510135/155837733-06889701-6ec8-41ec-818b-138c650aba5c.png">
  
  3. Add the extra sections to get SSH key fingerprint and create droplet.
  
  ```
      variable "region" {
        default = "blr1"
      }

      # Get ssh key
      data "digitalocean_ssh_key" "default" {
        name = "mykey"
      }


      # Create a droplet
      resource "digitalocean_droplet" "ubuntu" {
          image = "ubuntu-20-04-x64"
          name = "gitlab-jenkins"
          region = "blr1"
          size = "s-2vcpu-4gb" 
          # private_networking = true
          ssh_keys = ["${data.digitalocean_ssh_key.default.fingerprint}"]
      }


      output "controller_ip_address" {
          value = "${digitalocean_droplet.ubuntu.ipv4_address}"
      }
  ```
  
  - run below terraform command to create the droplet
  
  ```
  - save below in a tf-cmd.sh then execute ./tf-cmd.sh
  
      #!/bin/bash
      # doctl auth init

      terraform init

      terraform plan


      terraform apply -auto-approve
  ```

  
 4. Droplet(VM creation)
  ![image](https://user-images.githubusercontent.com/75510135/155840476-fd6c516e-23a1-461d-b834-4322c15e6a73.png)

  <img width="664" alt="image" src="https://user-images.githubusercontent.com/75510135/155840557-8ec24749-d6c9-4594-a922-5ce82da60711.png">

  ![image](https://user-images.githubusercontent.com/75510135/155840566-73ad3fbc-88b8-404d-af5c-915d2895c961.png)
  
  - Login into vm
  > ssh -i id_rsa root@143.110.247.9
  
  <img width="529" alt="image" src="https://user-images.githubusercontent.com/75510135/155840733-300a88a3-fcdd-4976-b63f-e04f912742f0.png">

  
</details>




