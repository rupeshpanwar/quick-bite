https://www.youtube.com/watch?v=wqsUfvRyYpw

# cks-master
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)


# cks-worker
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh)


# run the printed kubeadm-join-command from the master on the worker

https://console.cloud.google.com

# install gcloud sdk from
https://cloud.google.com/sdk/auth_success

# then run locally
gcloud auth login
gcloud projects list
gcloud config set project YOUR-PROJECT-ID
gcloud compute instances list # should be empty right now

# CREATE cks-master VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-master --zone=europe-west3-c \
--machine-type=e2-medium \
--image=ubuntu-1804-bionic-v20201014 \
--image-project=ubuntu-os-cloud \
--boot-disk-size=50GB

# CREATE cks-worker VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-worker --zone=europe-west3-c \
--machine-type=e2-medium \
--image=ubuntu-1804-bionic-v20201014 \
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


gcloud compute firewall-rules create nodeports --allow tcp:30000-40000


# All You Need to Know About Certificates in Kubernetes
https://www.youtube.com/watch?v=gXz4cq3PKdg

# Kubernetes Components
https://kubernetes.io/docs/concepts/overview/components

# PKI certificates and requirements
https://kubernetes.io/docs/setup/best-practices/certificates


# What have containers done for you lately?
https://www.youtube.com/watch?v=MHv6cWjvQjM









