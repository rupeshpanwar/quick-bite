# setup gcloud 
# install gcloud sdk from
https://cloud.google.com/sdk/auth_success

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-374.0.0-darwin-x86_64.tar.gz
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-374.0.0-darwin-x86_64.tar.gz
  tar xzf google-cloud-sdk-374.0.0-darwin-x86_64.tar.gz
  cd google-cloud-sdk
  ls
  sh install.sh

# then run locally
gcloud auth login
gcloud projects list
gcloud config set project YOUR-PROJECT-ID
gcloud compute instances list # should be empty right now

# some usefule cmds
# to ssh the vm in gcloud
gcloud compute ssh cks-master
# to work as root 
sudo -i


# run the printed kubeadm-join-command from the master on the worker

# CREATE cks-master VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-master --zone=asia-southeast1-a \
--machine-type=e2-medium \
--image=ubuntu-2004-focal-v20220419 \
--image-project=ubuntu-os-cloud \
--boot-disk-size=50GB

# CREATE cks-worker VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-worker1 --zone=asia-southeast1-b \
--machine-type=e2-medium \
--image=ubuntu-2004-focal-v20220419 \
--image-project=ubuntu-os-cloud \
--boot-disk-size=50GB

# you can use a region near you
https://cloud.google.com/compute/docs/regions-zones


# INSTALL cks-master
gcloud compute ssh cks-master
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)


# INSTALL cks-worker
gcloud compute ssh cks-worker
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh)

# create a fW rule to expose nodeport to public
gcloud compute firewall-rules create nodeports --allow tcp:30000-40000

# start n stop instance
gcloud compute instances start vm-name
gcloud compute instances stop vm-name


# install helm

    7  wget https://get.helm.sh/helm-v3.9.0-rc.1-linux-amd64.tar.gz
    8  ls
    9  tar -xzvf helm-v3.9.0-rc.1-linux-amd64.tar.gz 
   10  mv linux-amd64/helm /usr/local/bin/helm
   11  helm

   # install kube-scan 
   kubectl apply -f https://raw.githubusercontent.com/sidd-harth/kubernetes-devops-security/main/kube-scan.yaml
   