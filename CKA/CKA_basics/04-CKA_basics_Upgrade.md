<details>
<summary>Introduction</summary>
<br>
  
    <img width="936" alt="image" src="https://user-images.githubusercontent.com/75510135/164119203-07f69933-581b-4fa0-8eb6-f0884656f6d1.png">

    <img width="1002" alt="image" src="https://user-images.githubusercontent.com/75510135/164119264-1a851153-d309-4821-ad71-b72b69acf3b5.png">

</details>

<details>
<summary>Upgarde process - Master node</summary>
<br>

  <img width="989" alt="image" src="https://user-images.githubusercontent.com/75510135/164119325-4fd893e8-6f8f-429f-8536-18bc7bb4b637.png">

  <img width="995" alt="image" src="https://user-images.githubusercontent.com/75510135/164119379-6824b55f-a595-4189-b5f3-bd1d57e6add9.png">

  <img width="982" alt="image" src="https://user-images.githubusercontent.com/75510135/164119412-3683a524-370b-4f08-89af-5ff734386975.png">

  <img width="989" alt="image" src="https://user-images.githubusercontent.com/75510135/164119455-b6b2d010-50d3-4b2c-9630-d5188076d50f.png">

  <img width="813" alt="image" src="https://user-images.githubusercontent.com/75510135/164119497-ed7eb731-4223-48fc-951f-f79ee05a6ce9.png">

  <img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/164119680-cfa1bf8d-f08e-41b1-a2e6-cff9e0880888.png">

</details>


<details>
<summary>Upgrade process - Worker node</summary>
<br>

  <img width="964" alt="image" src="https://user-images.githubusercontent.com/75510135/164119585-24d76792-11a4-430c-b8cf-189042531f5e.png">

  <img width="992" alt="image" src="https://user-images.githubusercontent.com/75510135/164119610-1b3bc533-1b3e-44eb-925c-9ca8de7c4c7c.png">

  <img width="985" alt="image" src="https://user-images.githubusercontent.com/75510135/164119648-2b67bc71-eaf0-44df-ab11-7665bd5647f8.png">

  <img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/164119688-d1086bdc-207b-45a6-965a-db9d6608939f.png">

</details>

<details>
<summary>Exercise </summary>
<br>
        ```
           Reference:                                                                                      *
        * ----------                                                                                      *
        * https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/                       *
        * https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/                    *
        * https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/                          *
        * https://platform9.com/blog/kubernetes-upgrade-the-definitive-guide-to-do-it-yourself/           *
        *                                                                                                 *
        ***************************************************************************************************


        ***************************************************************************************************

        In this demo:
        ~~~~~~~~~~~~~
        1. We will upgrade kubernetes version 1.20.7 to 1.21.0 using "kubeadm"
        2. In my setup, there is 1 master node and 2 worker nodes.

        READ BEFORE YOU RUN:
        ~~~~~~~~~~~~~~~~~~~
        a. These commands need to run on cluster running with Ubuntu 
        b. Master and Worker nodes in your cluster might differ from this.
        c. Kubernets version might be different in your case, but procedure is the same.
        d. For more details, please visit Kubernetes docs.


        ***************************************************************************************************


        OVERVIEW: Steps involved in Kubernetes Version Upgrade:
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        1. Upgrade kubeadm
        2. Upgrade Node
        3. Drain the node (before kubelet upgrade)
        4. Upgrade kubelet and kubectl
        5. Restart the kubelet
        6. Uncordon the node
        ------------------------------------------
        7. Validate the Upgrade


        *******************************************************************************************
        *******************************************************************************************


        A. Upgrading MASTER(Control-Plane) Node(1).
        ____________________________________________


        0. Determine which version to upgrade to
        -----------------------------------------
        apt update
        apt-cache madison kubeadm


        1. Ugrading Kubeadm:
        --------------------
        NOTE: If a package is marked "hold", it is held back: The package cannot be installed, upgraded, or removed until the hold mark is removed.

        apt-mark unhold kubeadm && \
        apt-get update && apt-get install -y kubeadm=1.21.0-00 && \
        apt-mark hold kubeadm

        kubeadm version

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        2. Upgrading Node:
        ------------------
        kubeadm upgrade plan

        kubeadm upgrade apply v1.21.0

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        3. Drain the node:
        ------------------
        # Prepare the node for maintenance by marking it unschedulable and evicting the worklo

        kubectl drain master --ignore-daemonsets

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        4. Upgrade "kubelet" and "kubectl":
        -----------------------------------

        apt-mark unhold kubelet kubectl && \
        apt-get update && apt-get install -y kubelet=1.21.0-00 kubectl=1.21.0-00 && \
        apt-mark hold kubelet kubectl

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        5. Restart the "Kubelet":
        -----------------------
        systemctl daemon-reload
        systemctl restart kubelet

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        6. Uncordon the node:
        ----------------------
        kubectl uncordon master


        *******************************************************************************************
        *******************************************************************************************


        B). Upgrading WORKER Node(1):
        _____________________________

        The upgrade procedure on worker nodes should be executed one node at a time or few nodes at a time, without compromising the minimum required capacity for running your workloads.


        1. Upgrade kubeadm:
        -------------------
        apt-mark unhold kubeadm && \
        apt-get update && apt-get install -y kubeadm=1.21.0-00 && \
        apt-mark hold kubeadm

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        2. Upgrade "Node": (Run it on worker node)
        -------------------------------------------
        NOTE: For worker nodes this upgrades the local kubelet configuration:

        kubeadm upgrade node

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        3. "Drain" the node: (Run it on master node)
        ---------------------------------------------
        Prepare the node for maintenance by marking it unschedulable and evicting the workloads:

        kubectl drain worker-1 --ignore-daemonsets

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        4. Upgrade kubelet and kubectl:
        -------------------------------

        apt-mark unhold kubelet kubectl && \
        apt-get update && apt-get install -y kubelet=1.21.0-00 kubectl=1.21.0-00 && \
        apt-mark hold kubelet kubectl

        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        5. Restart the kubelet:
        -----------------------
        systemctl daemon-reload
        systemctl restart kubelet


        6. Uncordon the node:
        ---------------------
        Bring the node back online by marking it schedulable:

        kubectl uncordon worker-1


        *******************************************************************************************
        *******************************************************************************************


        C). Upgrading WORKER Node(2):
        _____________________________

        Follow same above 6 steps as mentioned in "Upgrading WORKER Node(1)


        *******************************************************************************************
        *******************************************************************************************

        D. Verify the status of the cluster
        _____________________________________

        After the kubelet is upgraded on all nodes verify that all nodes are available again by running the following command from anywhere kubectl can access the cluster:

        kubectl get nodes
        kubeadm version
        kubectl version
  ```
</details>
