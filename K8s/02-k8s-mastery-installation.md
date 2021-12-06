- Installing K8s
<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144815774-133e1c70-39e5-47bf-a3a2-389648295f1d.png">
- Docker desktop
<img width="700" alt="image" src="https://user-images.githubusercontent.com/75510135/144816263-a7847bbf-4bfc-4b35-a3b4-f93975df50cd.png">
<img width="753" alt="image" src="https://user-images.githubusercontent.com/75510135/144816321-b0c04c74-e89a-4a8b-ad3c-abe60e1ddf61.png">
<img width="778" alt="image" src="https://user-images.githubusercontent.com/75510135/144816360-ace3bc98-1611-453d-bda5-d31147cbbd22.png">
<img width="503" alt="image" src="https://user-images.githubusercontent.com/75510135/144816539-0fba7548-7032-40be-a35e-ee9ec6e970a7.png">
- minikube
<img width="715" alt="image" src="https://user-images.githubusercontent.com/75510135/144816897-ba5cc474-d053-4449-9f57-9e3bc0943cbb.png">
<img width="534" alt="image" src="https://user-images.githubusercontent.com/75510135/144817317-849bffe1-c831-4907-ab05-3636d3689a40.png">
<img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/144817892-6c91d969-0e46-4ff3-b4a4-4d636981f319.png">
<img width="716" alt="image" src="https://user-images.githubusercontent.com/75510135/144818045-b5d998f4-fb5a-4234-93d4-427cecbd29ed.png">

- Installation on Linux machine

<img width="778" alt="image" src="https://user-images.githubusercontent.com/75510135/144819532-9a9477d3-fe00-4150-a7b4-201b6749e0b6.png">
<img width="763" alt="image" src="https://user-images.githubusercontent.com/75510135/144820108-b95306ae-65da-4467-904c-0e26e2a0330f.png">
Install Tips for minikube and MicroK8s
Here are some tips for using minikube or MicroK8s in this course:

Note that in March 2020, Kubernetes 1.18 came out, and kubectl run syntax and functionality changed. This course is designed for 1.14-1.17 which are the prevalent versions used in cloud hosters, Docker Desktop, and enterprise solutions. minikube and MicroK8s now default to 1.18 installs, so it's up to you if you want to force installing version 1.17 (which I would recommend for now) or skip some of the first lectures about kubectl run because they no longer create deployments/jobs/cronjobs/services, etc. They only create pods.
minikube

    minikube defaults to installing the latest Kubernetes release, but you likely don't want that, since it's 6-12 months before many clouds and enterprise solutions update to recent versions. You can look up versions on GitHub, and install a specific version like this minikube start --kubernetes-version='1.17.4'

    Unlike Docker Desktop, which lets you use localhost for your Kubernetes services, minikube runs in VirtualBox (by default) and has its own IP. Find that with minikube ip

    Remember top stop minikube when you're not using it to save resources minikube stop

    Check the status of what is running in minikube with minikube status

MicroK8s

    MicroK8s defaults to installing the latest Kubernetes release, but you likely don't want that, since it's 6-12 months before many clouds and enterprise solutions update to recent versions. You can look up versions on GitHub, and install a specific version like this sudo snap install microk8s --classic --channel=1.17/stable

    Before using it, you'll need to enable the CoreDNS pod so it'll resolve service DNS names later: microk8s.enable dns

    Check the status of what is running in MicroK8s with microk8s.status



<img width="709" alt="image" src="https://user-images.githubusercontent.com/75510135/144820437-64d8738d-03fb-4d45-a0a9-2ce8c9318fc4.png">

<img width="897" alt="image" src="https://user-images.githubusercontent.com/75510135/144821258-329e56fc-3ca7-42a8-8177-b459abc85342.png">

Shpod Tips and Tricks

Be sure to come back to this lecture later if you have shpod issues, as I've thrown in common hiccups as you use it throughout the course!

Tip 1: Namespaces matter!

Once you learn about namespaces, you know that running kubectl commands often only affects the current namespace. Shpod runs in the shpod namespace, so if you mean to do something with the default namesapce, you need to either ensure that shpod config is set to use the default namespace (which it is by default) or add -n default to your commands. So kubectl get pods would turn into kubectl get -n default pods. We've setup the shpod pod to set it's namespace to default though, so this shouldn't be a big issue.

Tip 2: DNS matters with Namespaces!

The above shpod namespace affects DNS as well. If you need to curl or ping a Service name (which you'll learn later), remember that Kubernetes Service DNS names are namespace-sensitive from inside the cluster. Doing a ping myservice from a pod in one namespace only works if that Service is in the same namespace. In the Shpod, you would need to ping mypod.default if that Service was in the default namespace.

Tip 2: Attach shows you the console (tty) output, even from multiple terminals. You can use exec for additional terminal shells

An attach command will show the virtual console of a pod (like a tty), so multiple attach commands in multiple terminal windows will show the same thing because they are both looking at the console output. For your 2nd terminal, you can use an exec command that will start a new shell process in the existing container. This works exactly the same way as Docker attach and exec commands:

1st window, attach:

kubectl attach --namespace=shpod -ti shpod

2nd window, create a new bash shell:

kubectl exec --namespace=shpod -ti shpod -- bash -l

