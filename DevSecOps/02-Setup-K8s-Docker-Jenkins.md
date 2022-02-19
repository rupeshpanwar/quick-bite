<details>
<summary>Introduction</summary>
<br>

<img width="335" alt="image" src="https://user-images.githubusercontent.com/75510135/153755482-39e1eca3-2dbb-4d03-aeb5-93dea1655cee.png">
<img width="882" alt="image" src="https://user-images.githubusercontent.com/75510135/153755796-b1300d45-a601-4ba9-b8b3-4aa94e31c937.png">
    
</details>


<details>
<summary>1. Create VM & Install K8s</summary>
<br>

    
- create a VM with above mentioned configuration then
- run the script => https://github.com/rupeshpanwar/quick-bite/blob/main/DevSecOps/DevOps-Sec/setup/vm-install-script/install-script.sh

```
kubeadm join 142.93.213.194:6443 --token <value withheld> \
    --discovery-token-ca-cert-hash sha256:e2608bf24453d019c7805092f7a48680842c3064a293b63c19c4e630f859678a
 ```
 - https://kubernetes.io/docs/reference/kubectl/cheatsheet/
 
 ```
 output of sh script
 .........----------------#################._.-.-COMPLETED-.-._.#################----------------.........
root@elk:/tmp# kubectl get nodes
NAME   STATUS   ROLES                  AGE   VERSION
elk    Ready    control-plane,master   65m   v1.20.0

- test by creating a sample pod => https://kubernetes.io/docs/concepts/workloads/pods/
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml

kubectl expose po nginx-pod --port 80 --type NodePort

kubectl get svc
 ```
 
 -  if pod stuck in ContainerCreating state 
 - run => kubectl describe pod pod-name => check the event descrtiption
 - then follow below steps , there might be n/w issue,


    1. Create a file called subnet.env at location /run/flannel/ inside your worker nodes.

    2. Add the below content in it.
```
    FLANNEL_NETWORK=10.244.0.0/16
    FLANNEL_SUBNET=10.244.0.1/24
    FLANNEL_MTU=1450
    FLANNEL_IPMASQ=true
```
   3.  Save the file and create the pod again. It should saw the runnign status now.

</details>

<details>
<summary>2. Install plugins</summary>
<br>

    
![image](https://user-images.githubusercontent.com/75510135/154281751-e12fc949-cc32-42e4-963d-6f067521a671.png)

- if jenkins installation fails then run below scripts
```
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install -y jenkins
    systemctl daemon-reload
    systemctl enable jenkins
    sudo systemctl start jenkins
    sudo usermod -a -G docker jenkins
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

```

- Checking Jenkins version -
```
cat /var/lib/jenkins/config.xml | grep -i version
```
- If the version displayed is greater than 2.289.1 run the below commands to downgrade Jenkins
```
sudo apt install -y --allow-downgrades jenkins=2.289.1

systemctl daemon-reload

systemctl enable jenkins

sudo systemctl start jenkins
```
<img width="987" alt="image" src="https://user-images.githubusercontent.com/75510135/154283574-29f1c513-b41f-44b6-8051-d77b7b133662.png">

<img width="971" alt="image" src="https://user-images.githubusercontent.com/75510135/154285703-6f542759-b035-45a7-ba90-b257a6f821df.png">

- Access Jenkins url => http://142.93.213.194:8080/
## install plugins
- wget https://github.com/rupeshpanwar/quick-bite/blob/main/DevSecOps/DevOps-Sec/setup/jenkins-plugins/plugin-installer.sh
-  wget https://github.com/rupeshpanwar/quick-bite/blob/main/DevSecOps/DevOps-Sec/setup/jenkins-plugins/plugins.txt
-  run => ./plugin-installer.sh
```
plugin-installer.sh
#!/bin/bash
JENKINS_URL="http://localhost:8080"

JENKINS_CRUMB=$(curl -s --cookie-jar /tmp/cookies -u admin:admin $JENKINS_URL/crumbIssuer/api/json  | jq .crumb -r) 

JENKINS_TOKEN=$(curl -s -X POST -H "Jenkins-Crumb:"${JENKINS_CRUMB}"" --cookie /tmp/cookies  $JENKINS_URL/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken?newTokenName=\demo-token66 -u admin:admin | jq .data.tokenValue -r) 

echo $JENKINS_URL
echo $JENKINS_CRUMB
echo $JENKINS_TOKEN

while read plugin; do
   echo "........Installing ${plugin} .."
   curl -s POST --data "<jenkins><install plugin='${plugin}' /></jenkins>" -H 'Content-Type: text/xml' $JENKINS_URL/pluginManager/installNecessaryPlugins --user admin:$JENKINS_TOKEN
done < plugins.txt


#### we also need to do a restart for some plugins

#### check all plugins installed in jenkins
# 
# http://<jenkins-url>/script

# Jenkins.instance.pluginManager.plugins.each{
#   plugin -> 
#     println ("${plugin.getDisplayName()} (${plugin.getShortName()}): ${plugin.getVersion()}")
# }


#### Check for updates/errors - http://<jenkins-url>/updateCenter

    © 2022 GitHub, Inc.

    Terms
    Privacy

plugins.txt
performance@3.18
docker-workflow@1.26
dependency-check-jenkins-plugin@5.1.1
blueocean@1.24.7
jacoco@3.2.0
slack@2.4.8
sonar@2.13.1
pitmutation@1.0-18
kubernetes-cli@1.10.2

```
<img width="443" alt="image" src="https://user-images.githubusercontent.com/75510135/154288962-118724ec-9aa0-47d8-a5d3-976e6a6a3354.png">
<img width="494" alt="image" src="https://user-images.githubusercontent.com/75510135/154289264-5e6bd2b9-c6e4-4d72-8c11-bf17034885e8.png">


</details>
    
<details>
<summary>3. get installed plugin details in Jenkins</summary>
<br>

```
Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
     println ("${plugin.getDisplayName()} (${plugin.getShortName()}): ${plugin.getVersion()}")
 }
```

<img width="1197" alt="image" src="https://user-images.githubusercontent.com/75510135/154289928-6e32990e-e018-4e37-8041-49216c3e6fd5.png">
    
</details>
    






