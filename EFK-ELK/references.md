
Filebeat - https://www.elastic.co/guide/en/beats...

Metricbeat - https://www.elastic.co/guide/en/beats... 

Logstash - https://www.elastic.co/logstash

ElasticSearch - https://www.elastic.co/elasticsearch/ 

Kibana - https://www.elastic.co/kibana/ 

Kubernetes Procedure Document
Github repository [Read this first]

    Download all the course material from: https://github.com/wardviaene/advanced-kubernetes-course


Download Kubectl

    Download from: https://kubernetes.io/docs/tasks/tools/install-kubectl/

Minikube (doesn’t work with all demos)

    Project URL: https://github.com/kubernetes/minikube

    Latest Release and download instructions: https://github.com/kubernetes/minikube/releases

    VirtualBox: http://www.virtualbox.org

Minikube on windows:

    Download the latest minikube-version.exe

    Rename the file to minikube.exe and put it in C:\minikube

    Open a cmd (search for the app cmd or powershell)

    Run: cd C:\minikube and enter minikube start

Kops (recommended)
Project URL

    https://github.com/kubernetes/kops

Free DNS Service

    Sign up at http://freedns.afraid.org/

        Choose for subdomain hosting

        Enter the AWS nameservers given to you in route53 as nameservers for the subdomain

    http://www.dot.tk/ provides a free .tk domain name you can use and you can point it to the amazon AWS nameservers

###h2

    Namecheap.com often has promotions for tld’s like .co for just a couple of bucks

Cluster Commands

    kops create cluster --name=kubernetes.newtech.academy --state=s3://kops-state-b429b --zones=eu-west-1a --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=kubernetes.newtech.academy

    kops update cluster kubernetes.newtech.academy --yes --state=s3://kops-state-b429b

    kops delete cluster --name kubernetes.newtech.academy --state=s3://kops-state-b429b

    kops delete cluster --name kubernetes.newtech.academy --state=s3://kops-state-b429b --yes

Kubeadm

    You can use kubeadm to setup a non-AWS cluster

    See instructions at ###a href="https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/">https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

Kubernetes from scratch

    You can setup your cluster manually from scratch

    If you’re planning to deploy on AWS / Google / Azure, use the tools that are fit for these platforms

    If you have an unsupported cloud platform, and you still want Kubernetes, you can install it manually

    CoreOS + Kubernetes: https://coreos.com/kubernetes/docs/latest/getting-started.html
