<details>
<summary>The Big Picture</summary>
<br>

  <img width="464" alt="image" src="https://user-images.githubusercontent.com/75510135/167260047-b04d6f51-6d26-44fe-8ce0-4e34b0e15924.png">

  Storage is critical to most real-world production applications. Fortunately, Kubernetes has a mature and feature-rich storage subsystem called the persistent volume subsystem.
Types of storage#

First things first, Kubernetes supports many types of storage from many different places. For example, iSCSI, SMB, NFS, and object storage blobs are all from a variety of external storage systems that can be in the cloud or in your on-premises data center.

However, no matter what type of storage you have, or where it comes from, when it’s exposed on your Kubernetes cluster it’s called a volume. For example, Azure File resources surfaced in Kubernetes are called volumes, as are block devices from AWS Elastic Block Store. All storage on a Kubernetes cluster is called a volume.

  <img width="765" alt="image" src="https://user-images.githubusercontent.com/75510135/167260348-31407535-2d71-4a12-9c4c-7ba628ca159e.png">

  On the left, you’ve got storage providers. They can be your traditional enterprise storage arrays from vendors like EMC and NetApp, or they can be cloud storage services, such as AWS Elastic Block Store (EBS) and GCE Persistent Disks (PD). All you need, is a plugin that allows their storage resources to be surfaced as volumes in Kubernetes.

In the middle of the diagram is the plugin layer. In the simplest terms, this is the glue that connects external storage with Kubernetes. Going forward, plugins will be based on the Container Storage Interface (CSI) which is an open standard aimed at providing a clean interface for plugins. If you’re a developer writing storage plugins, the CSI abstracts the internal Kubernetes storage detail and lets you develop out-of-tree.

    Note: Prior to the CSI, all storage plugins were implemented as part of the main Kubernetes code tree (in-tree). This meant they all had to be open-source, and all updates and bug fixes were tied to the main Kubernetes release cycle. This was a nightmare for plugin developers as well as the Kubernetes maintainers. However, now that we have the CSI, storage vendors no longer need to open-source their code, and they can release updates and bug -fixes against their own timeframes.

On the right of the figure is the Kubernetes persistent volume subsystem. This is a set of API objects that allow applications to consume storage. At a high level, PersistentVolumes (PV) are how you map external storage onto the cluster, and PersistentVolumeClaims (PVC) are like tickets that authorize applications (Pods) to use a PV.
  
</details>

<details>
<summary>Example of Kubernetes storage</summary>
<br>

  Let’s assume the quick example shown in the figure below.

A Kubernetes cluster is running on AWS, and the AWS administrator has created a 25GB EBS volume, called “ebs-vol.” The Kubernetes administrator creates a PV, called “k8s-vol,” that links back to the “ebs-vol” via the kubernetes.io/aws-ebs plugin. While that might sound complicated, it’s not. The PV is simply a way of representing the external storage on the Kubernetes cluster. Finally, the Pod uses a PVC to claim access to the PV and start using it.
  <img width="651" alt="image" src="https://user-images.githubusercontent.com/75510135/167260373-1ce4290a-e8b2-4dd0-8af1-01f33833692a.png">

  A couple of points worth noting:

    There are rules safeguarding access to a single volume from multiple Pods (more on this later).
    A single external storage volume can only be used by a single PV. For example, you cannot have a 50GB external volume that has two 25GB Kubernetes PVs, each using half of it.


</details>

<details>
<summary>Storage Providers and Container Storage Interface</summary>
<br>

  <img width="543" alt="image" src="https://user-images.githubusercontent.com/75510135/167260411-83598489-0669-4896-a338-479855c5721d.png">

  Storage providers#

Kubernetes can use storage from a wide range of external systems. These will often be native cloud services, such as AWSElasticBlockStore or AzureDisk, but they can also be traditional on-premises storage arrays providing iSCSI or NFS volumes. Other options exist, but the take-home point is that Kubernetes gets its storage from a wide range of external systems.

Some obvious restrictions apply. For example, you cannot use the AWSElasticBlockStore provisioner if your Kubernetes cluster is running in Microsoft Azure.

  The Container Storage Interface (CSI)#

The CSI is an important piece of the Kubernetes storage jigsaw. However, unless you’re a developer writing storage plugins, you’re unlikely to interact with it very often.

It’s an open-source project that defines a standards-based interface so that storage can be leveraged in a uniform way across multiple container orchestrators. In other words, a storage vendor should be able to write a single CSI plugin that works across multiple orchestrators like Kubernetes and Docker Swarm. In reality, Kubernetes is the focus.

In the Kubernetes world, CSI is the preferred way to write drivers (plugins), which means that plugin code no longer needs to exist in the main Kubernetes code tree. It also provides a clean and simple interface that abstracts all of the complex internal Kubernetes storage machinery. Basically, the CSI exposes a clean interface and hides all the ugly volume machinery inside of the Kubernetes code (no offense intended).

From a day-to-day management perspective, your only real interaction with the CSI will be referencing the appropriate plugin in your YAML manifest files. Also, it may take a while for existing in-tree plugins to be replaced by CSI plugins.

Sometimes we call plugins “provisioners,” 
  
</details>

<details>
<summary>The Kubernetes Persistent Volume Subsystem</summary>
<br>

  <img width="549" alt="image" src="https://user-images.githubusercontent.com/75510135/167260593-bfa95274-ca8a-4d87-96f6-f5381d16a7e6.png">

  Introduction#

From a day-to-day perspective, this is where you’ll spend most of your time configuring and interacting with Kubernetes storage.

You start out with raw storage on the left of the figure below. This plugs in to Kubernetes via a CSI plugin. You then use the resources provided by the persistent volume subsystem to leverage and use the storage in your apps.

  <img width="912" alt="image" src="https://user-images.githubusercontent.com/75510135/167261054-4ef97532-b264-40ce-86b3-73224c152717.png">

  A quick example#

Let’s walk through a quick example.

Assume you have a Kubernetes cluster and an external storage system. The storage vendor provides a CSI plugin so that you can leverage its storage assets inside of your Kubernetes cluster. You provision 3 x 10GB volumes on the storage system and create 3 Kubernetes PV objects to make them available on your cluster. Each PV references one of the volumes on the storage array via the CSI plugin. At this point, the three volumes are visible and available for use on the Kubernetes cluster.

Now, assume you’re about to deploy an application that requires 10GB of storage. That’s great because you already have three 10GB PVs. In order for the app to use one of them, it needs a PVC. As previously mentioned, a PVC is like a ticket that lets a Pod (application) use a PV. Once the app has the PVC, it can mount the respective PV into its Pod as a volume.

That was a high level example. Let’s do it.

This example is for a Kubernetes cluster running on the Google Cloud. I’m using a cloud option, as they’re the easiest to follow along with and you may be able to use the cloud’s free tier/initial free credit. It’s also possible to follow along on other clouds by changing a few values.

The example assumes a 10GB SSD volume, called “uber-disk”, has been pre-created in the same Google Cloud Region or Zone as the cluster. The Kubernetes steps will be:

    Create the PV.
    Create the

    PVC.
    Define the volume into a PodSpec.
    Mount it into a container.

The following YAML file creates a PV object that maps back to the pre-created Google Persistent Disk called “uber-disk”. The YAML file is called gke-pv.yml.
gke-pv.yml
  
  ```
  apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv1
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: test
  capacity:
    storage: 10Gi
  persistentVolumeReclaimPolicy: Retain
  gcePersistentDisk:
    pdName: uber-disk
  ```
  
  Analyzing the file#

Let’s step through the file.

PersistentVolume (PV) resources are defined in v1 of the core API group. You’re naming this PV “pv1”, setting its access mode to ReadWriteOnce, and making it part of a class of storage, called “test”. You’re defining it as a 10GB volume, setting a reclaim policy, and mapping it back to a pre-created GCE persistent disk called “uber-disk”.

The following command will create the PV. It assumes the YAML file is in your PATH and is called gke-pv.yml. The operation will fail if you have not pre-created “uber-disk” on the back-end storage system (in this example the back-end storage is provided by Google Compute Engine).

  <img width="909" alt="image" src="https://user-images.githubusercontent.com/75510135/167261085-9fc65a05-75ac-4349-ae59-c4f4a6e9e964.png">

  <img width="901" alt="image" src="https://user-images.githubusercontent.com/75510135/167261093-07a6edd0-bd0f-4216-92a0-010c89096cab.png">

  <img width="930" alt="image" src="https://user-images.githubusercontent.com/75510135/167261107-24f16e7c-a662-48d5-b614-1fbb9560e055.png">

  <img width="940" alt="image" src="https://user-images.githubusercontent.com/75510135/167261120-eafe7d73-30af-4d0c-a54f-3d7b898f474e.png">

  <img width="885" alt="image" src="https://user-images.githubusercontent.com/75510135/167261134-14bd5549-5e51-4ccd-890d-606b5469b5f9.png">

  
</details>

<details>
<summary>Persistent Volume Claim</summary>
<br>

  Example#

The following YAML defines a PVC that can be used by a Pod to gain access to the pv1 PV you created earlier.

This file is called gke-pvc.yml.

  ```
  apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc1
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: test
  resources:
    requests:
      storage: 10Gi
  ```
  
  <img width="904" alt="image" src="https://user-images.githubusercontent.com/75510135/167261680-e487b010-124e-4c1a-8cf4-f16ad7f7c14a.png">

  <img width="902" alt="image" src="https://user-images.githubusercontent.com/75510135/167261686-bc171b73-11cb-4ff5-89fb-607ff3deab81.png">

  OK, you’ve got a PV, called pv1, representing 10GB of external storage on your Kubernetes cluster, and you’ve bound a PVC, called pvc1, to it. Let’s find out how a Pod can leverage that PVC and use the actual storage.

More often than not, you’ll deploy your applications via higher-level controllers like Deployments and StatefulSets, but, to keep the example simple, you’ll deploy a single Pod. Pods deployed like this are often referred to as “singletons” and are not recommended for production as they do not provide high availability and cannot self-heal.

The following YAML defines a single-container Pod with a volume, called “data”, that leverages the PVC and PV objects you already created. The file is called volpod.yml.

  <img width="925" alt="image" src="https://user-images.githubusercontent.com/75510135/167261861-dc4bf060-1826-4448-a91e-b56ef7b80ce6.png">

  <img width="888" alt="image" src="https://user-images.githubusercontent.com/75510135/167261872-f7067c25-bc6d-4294-a8bf-81f1f46d42b5.png">

  
</details>

<details>
<summary>Storage Classes and Dynamic Provisioning</summary>
<br>

  Everything you’ve seen so far is correct and fundamental to Kubernetes storage. But it doesn’t scale – there’s no way somebody managing a large Kubernetes environment can manually create and maintain large numbers of PVs and PVCs. You need something more dynamic.

Enter storage classes:

As the name suggests, storage classes allow you to define different classes, or tiers, of storage. How you define your classes is up to you, but it will depend on the types of storage you have access to. For example, you might define a fast class, a slow class, and an encrypted class (your external storage system would need to support different speeds of storage and support encrypting volumes, as Kubernetes does none of this).

As far as Kubernetes goes, storage classes are defined as resources in the storage.k8s.io/v1 API group. The resource type is StorageClass, and you define them in regular YAML files that you POST to the API server for deployment. You can use the sc shortname to refer to StorageClass objects when using kubectl.

    Note: You can see a full list of API resources and their shortnames using the kubectl api-resources command. The output of the command shows the API group that each resource belongs to (an empty st

    ring indicates the core API group), whether or not the resource is namespaced and what its equivalent kind is when writing YAML files.

A StorageClass YAML #

The following is a simple example of a StorageClass YAML file. It defines a class of storage called “fast”, that is based on AWS solid state drives (io1) in the Ireland Region (eu-west-1a). It also requests a performance level of 10 IOPs per gigabyte.
<img width="900" alt="image" src="https://user-images.githubusercontent.com/75510135/167277238-6be3a5dd-3e6d-4883-8e23-cad96ce72b7f.png">

  As with all Kubernetes YAML, kind tells the API server what type of object is being defined, and apiVersion tells it which version of the schema to apply to the resource. metadata.name is an arbitrary string value that lets you give the object a friendly name – this example is defining a class called “fast”. provisioner tells Kubernetes which plugin to use, and the parameters field lets you finely tune the type of storage to leverage from the back-end.

A few quick things worth noting:

    StorageClass objects are immutable – this means you cannot modify them once deployed.
    metadata.name should be meaningful as it’s how other objects will refer to the class.
    The terms provisioner and plugin are used interchangeably.
    The parameters section is for plugin-specific values, and each plugin is free to support its own set of values. Configuring this section requires knowledge of the storage plugin and associated storage back end.

Multiple StorageClasses#

You can configure as many StorageClass objects as you need. However, each one relates to a single provisioner. For example, if you have a Kubernetes cluster with StorageOS and Portworx storage back ends, you will n

eed at least two StorageClass objects. That said, each back end can offer multiple classes/tiers of storage, each of which can have its own StorageClass. For example, you could have the following two StorageClass objects for different classes of storage from the same back end:

    “fast-secure” for high performance encrypted volumes
    “fast” for high-performance unencrypted volumes

An example of a StorageClass defining an encrypted volume on a Portworx back-end might look like this. It will only work if you have a Portworx.
<img width="533" alt="image" src="https://user-images.githubusercontent.com/75510135/167277248-3ff0b878-7263-45ca-adc9-4433ad3e1ac1.png">
As you can see, the .parameters section is long and lists some cryptic values. Configuring this section requires knowledge of the plugin and what is supported on the storage back-end. Consult your storage plugin documentation for details.
Implementing StorageClasses#

The basic workflow for deploying and using a StorageClass on your cluster is as follows:

    Create your Kubernetes cluster with a storage back end.
    Ensure the plugin for the storage back end is available.
    Create a StorageClass object.
    Create a PVC object that references the StorageClass by name.
    Deploy a Pod that uses volume based on the PVC.

Notice that the workflow does not include creating a PV. This is because storage classes create PVs dynamically.

The following YAML snippet contains the definitions for a StorageClass, a PersistentVolumeClaim, and a Pod. All three objects can be defined in a single YAML file by separating each object with three dashes (---).

Notice how the PodSpec references the PVC by name, and, in turn, the PVC references the SC by name.
```
  kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: fast  # Referenced by the PVC
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-ssd
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc  # Referenced by the PodSpec
  namespace: mynamespace
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
  storageClassName: fast    # Matches name of the SC
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: mypvc  # Matches PVC name
  containers: ...
  <SNIP>
```
    The previous YAML is truncated and does not include a full PodSpec.

So far, you’ve seen a few SC definitions. However, each one has been slightly different, as each one has related to a different provisioner (storage plugin/back end). You will need to refer to the documentation of your storage plugin to know which options your provisioner supports.
Quick summary#

Let’s quickly summarize what you’ve learned about storage classes before walking through a demo.

StorageClasses make it so that you don’t have to create PVs manually. You create the StorageClass object and use a plugin to tie it to a particular type of storage on a particular storage back end. For example, high performance AWS SSD storage in the AWS Mumbai Region. The SC needs a name, and is defined in a YAML file that you deploy using kubectl. Once deployed, the StorageClass watches the API server for new PVC objects that reference its name. When matching PVCs appear, the StorageClass dynamically creates the required volume on the back-end storage system as well as the PV on Kubernetes.

There’s always more detail, such as mount options and volume binding modes, but what you’ve learned so far is enough to get you more than started.


  
</details>

