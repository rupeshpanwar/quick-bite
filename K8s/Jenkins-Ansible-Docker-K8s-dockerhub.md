<img width="1041" alt="image" src="https://user-images.githubusercontent.com/75510135/145943634-c477817e-6ac5-460f-ba6a-74bf01fe3d3f.png">
<img width="696" alt="image" src="https://user-images.githubusercontent.com/75510135/145943750-4aa903f0-0cbc-4248-a6bc-2d4da51313b3.png">
Setup Kubernetes (K8s) Cluster on AWS

    Create Ubuntu EC2 instance

    install AWSCLI

     curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
     sudo apt update
     sudo apt install unzip python
     unzip awscli-bundle.zip
     #sudo apt-get install unzip - if you dont have unzip in your system
     ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

    Install kubectl on ubuntu instance

    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
     chmod +x ./kubectl
     sudo mv ./kubectl /usr/local/bin/kubectl

    Install kops on ubuntu instance

     curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
     chmod +x kops-linux-amd64
     sudo mv kops-linux-amd64 /usr/local/bin/kops

    Create an IAM user/role with Route53, EC2, IAM and S3 full access

    Attach IAM role to ubuntu instance

    # Note: If you create IAM user with programmatic access then provide Access keys. Otherwise region information is enough
    aws configure

    Create a Route53 private hosted zone (you can create Public hosted zone if you have a domain)

    Routeh53 --> hosted zones --> created hosted zone  
    Domain Name: valaxy.net
    Type: Private hosted zone for Amzon VPC

    create an S3 bucket

     aws s3 mb s3://demo.k8s.valaxy.net

    Expose environment variable:

     export KOPS_STATE_STORE=s3://demo.k8s.valaxy.net

    Create sshkeys before creating cluster

     ssh-keygen

    Create kubernetes cluster definitions on S3 bucket

    kops create cluster --cloud=aws --zones=ap-south-1b --name=demo.k8s.valaxy.net --dns-zone=valaxy.net --dns private 

    If you wish to update the cluster worker node sizes use below command

    kops edit ig --name=CHANGE_TO_CLUSTER_NAME nodes

    Create kubernetes cluser

    kops update cluster demo.k8s.valaxy.net --yes

    Validate your cluster

     kops validate cluster

    To list nodes

    kubectl get nodes

    To delete cluster

     kops delete cluster demo.k8s.valaxy.net --yes

Deploying Nginx pods on Kubernetes

    Deploying Nginx Container

    kubectl create deploy sample-nginx --image=nginx --replicas=2 --port=80
    # kubectl deploy simple-devops-project --image=yankils/simple-devops-image --replicas=2 --port=8080
    kubectl get all
    kubectl get pod

    Expose the deployment as service. This will create an ELB in front of those 2 containers and allow us to publicly access them.

    kubectl expose deployment sample-nginx --port=80 --type=LoadBalancer
    # kubectl expose deployment simple-devops-project --port=8080 --type=LoadBalancer
    kubectl get services -o wide
    
    <img width="500" alt="image" src="https://user-images.githubusercontent.com/75510135/145944678-3b173dd3-75b9-4b37-8af4-31a5fe791f75.png">

    <img width="1070" alt="image" src="https://user-images.githubusercontent.com/75510135/145944615-aeb871a6-0b9d-42ef-bdf7-07dcbb4d0074.png">

- setup k8s host machine

<img width="978" alt="image" src="https://user-images.githubusercontent.com/75510135/145944865-b788ec93-851c-4736-87a2-382dbaa66b08.png">

<img width="1059" alt="image" src="https://user-images.githubusercontent.com/75510135/145944968-95c41a2e-39ae-443f-a225-f6527c968d46.png">

- install kubectl
<img width="1061" alt="image" src="https://user-images.githubusercontent.com/75510135/145945119-726382cb-a89e-4cc2-87cd-732e3df40d38.png">

- install kops
<img width="1069" alt="image" src="https://user-images.githubusercontent.com/75510135/145945269-78b88b82-c716-4c9b-8885-8ebb24e17d3c.png">

### create K8s role in AWS IAM console
<img width="864" alt="image" src="https://user-images.githubusercontent.com/75510135/145946390-ef8679fe-8012-4edf-8f6b-9915e40e649b.png">

- then attach the role to K8s host machine
<img width="1078" alt="image" src="https://user-images.githubusercontent.com/75510135/145946471-79973087-a30c-4486-a573-a6f9145f383a.png">

- aws configure on K8s host machine
<img width="797" alt="image" src="https://user-images.githubusercontent.com/75510135/145946563-295a2cf5-2c10-4ddf-947d-a9f82e45ef5c.png">

### create hosted zone in AWS Route53
<img width="1072" alt="image" src="https://user-images.githubusercontent.com/75510135/145946699-12115db2-aa74-4e5e-82ad-574160f32880.png">

### create S3 bucket from K8s host machine
<img width="565" alt="image" src="https://user-images.githubusercontent.com/75510135/145946915-9a42c232-f7d5-416f-a5b3-7a8f54d8208f.png">

<img width="455" alt="image" src="https://user-images.githubusercontent.com/75510135/145946956-7b638242-edbe-4034-b457-86476eb78ffd.png">

### export kops , create pub ssh key
<img width="612" alt="image" src="https://user-images.githubusercontent.com/75510135/145947121-37560b24-a6a1-4632-9f98-ffe2c8e33333.png">

### create definition for k8s cluster using kops on K8s host machine
<img width="1064" alt="image" src="https://user-images.githubusercontent.com/75510135/145947382-3953e3b0-e8d6-49cb-9a80-001c5e34e949.png">

<img width="1071" alt="image" src="https://user-images.githubusercontent.com/75510135/145947426-64185bb5-0f35-4af8-b5ea-e2245b0c1fc0.png">

<img width="848" alt="image" src="https://user-images.githubusercontent.com/75510135/145947618-ec1a81b1-4889-4e4f-9b7a-e37462c9a6fb.png">

<img width="802" alt="image" src="https://user-images.githubusercontent.com/75510135/145947715-8b8f6262-779c-4efb-9e54-586a8f7b646c.png">

<img width="1034" alt="image" src="https://user-images.githubusercontent.com/75510135/145947807-7e4aa803-b9ec-48f5-9141-a80ab91b0097.png">

<img width="693" alt="image" src="https://user-images.githubusercontent.com/75510135/145947897-a9cdacf3-ae89-4c77-8c2f-8fc294bd61c7.png">

<img width="1029" alt="image" src="https://user-images.githubusercontent.com/75510135/145947948-c3c76f91-5c61-499a-ae8f-21b1f776c2ee.png">

<img width="497" alt="image" src="https://user-images.githubusercontent.com/75510135/145948001-6d3b0173-b75b-4a18-8013-d34bd0d10e3a.png">

<img width="1032" alt="image" src="https://user-images.githubusercontent.com/75510135/145948086-245946b2-1a5c-48b0-b8a9-e8c785c3d706.png">

- connect to the cluster
<img width="877" alt="image" src="https://user-images.githubusercontent.com/75510135/145948421-34dbe831-d5e3-4457-8935-fed514afedf6.png">

Common Issues: Unable to Access Kubernetes cluster

Follow below 2 steps to resolve the Kubernetes access issue. If you are still not able to resolve then join in our Facebook discussion group.

Technical discussion group: https://www.facebook.com/groups/valaxytechnologies


1. If you are unable to access the cluster it means there is some problem with "kops create cluster"

make sure you are giving the right zone name in the command.

for example, if my DevOps setup is in the Mumbai region (ap-south-1), then we have 3 zones over here

ap-south-1a

ap-south-1b

ap-south-1c

I have chosen one of the zone names called ap-south-1b. 


    kops create cluster --cloud=aws --zones=ap-south-1b --name=demo.k8s.valaxy.net --dns-zone=valaxy.net --dns private 

the full article is here

https://github.com/yankils/Simple-DevOps-Project/blob/master/Kubernetes/Kubernetes-setup.MD


2. Another checkpoint is your VPC in the Route53. Please choose the same region VPC while creating hosted zones.

- update/edit cluster
<img width="682" alt="image" src="https://user-images.githubusercontent.com/75510135/145951040-d00cec4e-08c4-45e9-8de5-273316cc6e64.png">

### create deployment and service
- login into k8s master node
<img width="701" alt="image" src="https://user-images.githubusercontent.com/75510135/145952017-1d5cd489-1900-4e6b-92ac-096cbf7e8e7f.png">

<img width="686" alt="image" src="https://user-images.githubusercontent.com/75510135/145952134-a1fb7509-17eb-48b9-9bab-1d5c2b7e6b37.png">

<img width="757" alt="image" src="https://user-images.githubusercontent.com/75510135/145952253-0d189b3f-d879-44cd-bd0d-4e10a174cd66.png">

<img width="955" alt="image" src="https://user-images.githubusercontent.com/75510135/145952463-6875113b-470b-48bd-b54b-6100038b7d9e.png">

<img width="770" alt="image" src="https://user-images.githubusercontent.com/75510135/145952770-ddae753b-9a90-48fa-8525-51d64e6ddbcf.png">

<img width="928" alt="image" src="https://user-images.githubusercontent.com/75510135/145952899-c16475b8-2361-4aa1-9b2a-a32ee43254e3.png">

<img width="756" alt="image" src="https://user-images.githubusercontent.com/75510135/145952924-36a91b14-794c-44c9-9560-a6cffc29a8e5.png">

```
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: valaxy-deployment
spec:
  selector:
    matchLabels:
      app: valaxy-devops-project
  replicas: 2 # tells deployment to run 2 pods matching the template
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1

  template:
    metadata:
      labels:
        app: valaxy-devops-project
    spec:
      containers:
      - name: valaxy-devops-project
        image: yankils/simple-devops-image
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
 ---
 apiVersion: v1
kind: Service
metadata:
  name: valaxy-service
  labels:
    app: valaxy-devops-project
spec:
  selector:
    app: valaxy-devops-project
  type: LoadBalancer
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 31200


```

### integrate K8s with Ansible

<img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/145958438-a62b2f7b-a08e-44cb-a87c-d8bbbc0b95dc.png">

- take ssh pub key from ansible host machine
<img width="979" alt="image" src="https://user-images.githubusercontent.com/75510135/145958950-4b3d1ec9-58f6-4f98-8707-fe94239d13ed.png">

- append authorized key on K8s master node
<img width="530" alt="image" src="https://user-images.githubusercontent.com/75510135/145959083-e0d9bb86-9d6a-44c7-94e0-e49d73f8a8bf.png">

<img width="987" alt="image" src="https://user-images.githubusercontent.com/75510135/145959253-4f23c547-47a6-4246-8f75-89bfd5860223.png">

- from Ansible server, ssh to K8s master node server(public ip) using root user

<img width="668" alt="image" src="https://user-images.githubusercontent.com/75510135/145959594-a562554e-182d-4767-bd6b-211e4141fc66.png">

- create host file @ ansible server, add k8s master node public ip
<img width="433" alt="image" src="https://user-images.githubusercontent.com/75510135/145960104-0de62fc1-8880-41de-bcd9-5a9a1df73e3a.png">

- create playbook for deployment , service @ ansible server
<img width="678" alt="image" src="https://user-images.githubusercontent.com/75510135/145960358-1a0fab31-a89c-48ab-a880-4493df31874a.png">

```
---
- name: Create pods using deployment 
  hosts: kubernetes 
  # become: true
  user: ubuntu
 
  tasks: 
  - name: create a deployment
    command: kubectl apply -f valaxy-deploy.yml
  ```
  ```
  
---
- name: create service for deployment
  hosts: kubernetes
  # become: true
  user: ubuntu

  tasks:
  - name: create a service
    command: kubectl apply -f valaxy-service.yml
  ```
  
  <img width="636" alt="image" src="https://user-images.githubusercontent.com/75510135/145960840-e17d77a2-5d4b-4f64-8579-20afd3a51c07.png">

- ansible playbook @ ansible node  
<img width="1051" alt="image" src="https://user-images.githubusercontent.com/75510135/145961407-e3256dd3-2428-447a-a0bc-9e6d66bce72f.png">

<img width="760" alt="image" src="https://user-images.githubusercontent.com/75510135/145961514-b2cdb646-d743-47c7-bbdd-65dc515d09bb.png">

### deploy now to K8s cluster, k8s CD pipeline
<img width="480" alt="image" src="https://user-images.githubusercontent.com/75510135/145962766-27a9f389-e292-4d3f-9094-138c83d469b8.png">

<img width="617" alt="image" src="https://user-images.githubusercontent.com/75510135/145962882-8fad975b-2baa-4c44-bce5-a20bcace1bdc.png">

<img width="847" alt="image" src="https://user-images.githubusercontent.com/75510135/145963038-24de3242-1392-4408-98ce-c1015c86ca20.png">

<img width="879" alt="image" src="https://user-images.githubusercontent.com/75510135/145963423-5ae53262-f8a1-42b5-948b-9969603d4b42.png">

<img width="757" alt="image" src="https://user-images.githubusercontent.com/75510135/145963459-498ad568-743f-4751-a8b4-65da2594a056.png">

<img width="561" alt="image" src="https://user-images.githubusercontent.com/75510135/145963551-9d2ceef8-af79-4d1b-a2d9-cf9188af5f19.png">

### k8s CI pipeline
<img width="773" alt="image" src="https://user-images.githubusercontent.com/75510135/145964167-7de3227d-5595-48ce-a259-cae87b58a5c4.png">
<img width="646" alt="image" src="https://user-images.githubusercontent.com/75510135/145964294-3161e7fd-857a-4521-b37c-de80a5ec84fb.png">
<img width="686" alt="image" src="https://user-images.githubusercontent.com/75510135/145964377-225a4e41-aaf5-441c-a445-df61d21b8eb9.png">

<img width="896" alt="image" src="https://user-images.githubusercontent.com/75510135/145964485-345b2a55-a49f-444d-800c-65574bde0693.png">

<img width="876" alt="image" src="https://user-images.githubusercontent.com/75510135/145964544-e761359a-2961-4b3d-8fb4-0e0d0854aac5.png">

<img width="837" alt="image" src="https://user-images.githubusercontent.com/75510135/145964610-d90deb2d-e6cc-4cc1-a9c5-d7f45c7ecdce.png">
<img width="1063" alt="image" src="https://user-images.githubusercontent.com/75510135/145964810-1165cecf-605d-48a2-b629-314368ae4a77.png">

<img width="821" alt="image" src="https://user-images.githubusercontent.com/75510135/145964736-8562b626-af0d-4048-b370-ab642babf8af.png">
- copy dockerfile , ansible playbook to build/push docker image into k8s dir @ ansible server
<img width="981" alt="image" src="https://user-images.githubusercontent.com/75510135/145965058-64ab1cae-203f-44d2-b015-3d28031706d7.png">

<img width="684" alt="image" src="https://user-images.githubusercontent.com/75510135/145965178-92738d24-33a8-4868-a825-d58fe724c115.png">

- change ownership to ansible admin to k8s directory
<img width="789" alt="image" src="https://user-images.githubusercontent.com/75510135/145965564-7e9ad59c-bea0-4027-8cae-2fa4e7c56fa6.png">

<img width="678" alt="image" src="https://user-images.githubusercontent.com/75510135/145965660-581f14bc-5c63-4ebd-9bb5-d8eeac8c9246.png">

<img width="907" alt="image" src="https://user-images.githubusercontent.com/75510135/145965892-231763c1-3b2d-4b98-b363-5332e7287e46.png">

### Integrate CI with CD pipeline
<img width="883" alt="image" src="https://user-images.githubusercontent.com/75510135/145966262-4095f63d-893f-4941-8d32-b25332c50ef5.png">

<img width="892" alt="image" src="https://user-images.githubusercontent.com/75510135/145966472-989877f7-aa53-45d1-9bb4-7d3df2d2553c.png">

## issue here , code changes is not visible and its not deployed


# Now, Automate the deployment
<img width="1034" alt="image" src="https://user-images.githubusercontent.com/75510135/145967395-2bb84efc-5cd3-4992-9c09-9b044f48cb6b.png">

- @K8s master node , update the rolling strategy into deployment
<img width="596" alt="image" src="https://user-images.githubusercontent.com/75510135/145968047-d7ec4f44-a254-4ded-991f-2ecbd7fb2d05.png">

- @Ansible node, update playbook with rollout cmd
<img width="681" alt="image" src="https://user-images.githubusercontent.com/75510135/145968411-8a3d55c7-663e-47bd-90bd-464358d03aa2.png">

<img width="610" alt="image" src="https://user-images.githubusercontent.com/75510135/145968354-a97cbd91-4ba6-4f22-829b-b8a3190f4221.png">
<img width="728" alt="image" src="https://user-images.githubusercontent.com/75510135/145968932-abf32b97-ff9f-46ec-b7c4-5a08ae3a1dad.png">


<img width="791" alt="image" src="https://user-images.githubusercontent.com/75510135/145968860-9c6ca946-f3f2-400a-a75a-3ac0645b6366.png">

# Final
<img width="1064" alt="image" src="https://user-images.githubusercontent.com/75510135/145969392-0dbd3be3-7db6-4a79-bcfe-7be8503b5094.png">




