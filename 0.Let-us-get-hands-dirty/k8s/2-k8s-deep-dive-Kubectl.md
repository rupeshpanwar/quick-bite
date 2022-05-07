<details>
<summary>kubectl</summary>
<br>

  <img width="317" alt="image" src="https://user-images.githubusercontent.com/75510135/167237415-be736331-8ee7-4392-9f40-ef3e652a2471.png">

  What is kubectl?#

kubectl is the main Kubernetes command-line tool and is what you will use for your day-to-day Kubernetes management activities. It might be useful to think of kubectl as SSH for Kubernetes. It’s available for Linux, Mac, and Windows.

As it’s the main command-line tool, it’s important that you use a version that is no more than one minor version higher or lower than your cluster. For example, if your cluster is running Kubernetes 1.18.x, your kubectl should be between 1.17.x and 1.19.x.

At a high level, kubectl converts user-friendly commands into the JSON payload required by the API server. It uses a configuration file to know which cluster and API server endpoint to POST commands to.

The kubectl configuration file is called config and lives in $HOME/.kube. It contains definitions for:

    Clusters
    Users (credentials)
    Contexts

Clusters#

Clusters is a list of clusters that kubectl knows about and is ideal if you plan on using a single workstation to manage multiple clusters. Each cluster definition has a name, certificate info, and API server endpoint.
Users#

Users let you define different users that might have different levels of permissions on each cluster. For example, you might have a dev user and an ops user, each with different permissions. Each user definition has a friendly name, a username, and a set of credentials.
Contexts#

Contexts bring together clusters and users under a friendly name. For example, you might have a context called deploy-prod that combines the deploy user credentials with the prod cluster definition. If you use kubectl with this context, you will be POSTing commands to the API server of the prod cluster as the deploy user.
kubectl config#

The following is a simple kubectl config file with a single cluster called minikube, a single user called minikube, and a single context called minikube. The minikube context combines the minikube user and cluster and is also set as the default context.

  <img width="750" alt="image" src="https://user-images.githubusercontent.com/75510135/167237453-d78ec39e-546f-4b94-9321-2ee9b688ef4a.png">

  You can view your kubectl config using the kubectl config view command. Sensitive data will be redacted from the output.

You can use kubectl config current-context to see your current context. The following example shows a system where kubectl is configured to issue commands to a cluster that is called eks-k8sbook.
$ kubectl config current-context

The output will be:
eks_k8sbook

You can change the current/active context with kubectl config use-context. The following command will set the current context to docker-desktop so that future commands will be sent to the cluster defined in the docker-desktop context. It obviously requires that a context called docker-desktop exists in the kubectl config file.
$ kubectl config use-context docker-desktop

The output will be:
Switched to context "docker-desktop".

Now let’s check the current-context again:
$ kubectl config current-context

The output will be:
docker-desktop
  
</details>

<details>
<summary>Command-Summary</summary>
<br>

  ```
  503  ls $HOME/.kube
  507  kubectl config view
  508  kubectl config current-context
  509  kubectl config use-context sample-context
  ```
</details>
