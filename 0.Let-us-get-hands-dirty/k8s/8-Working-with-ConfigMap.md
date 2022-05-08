<details>
<summary>Introduction</summary>
<br>

  <img width="483" alt="image" src="https://user-images.githubusercontent.com/75510135/167279886-d6c8bc4e-dca1-455c-acf6-faeb58561273.png">

  Most business applications are composed of two main parts:

    The application binary
    A configuration

A simple example is a web server, such as NGINX or httpd (Apache). Neither are very useful without a configuration. However, when you combine the application with a configuration, it becomes extremely useful.

In the past, we coupled the application and the configuration into a single easy-to-deploy unit. As we moved into the early days of cloud-native microservices applications, we brought this model with us. However, it’s an anti-pattern in the cloud-native world. Cloud-native microservices applications should decouple the application and the configuration, bringing benefits such as:

    Reusable application images
    Simpler testing
    Simpler and fewer disruptive changes

We’ll explain all of these, and more, as we go through the chapter.
The big picture#

As already mentioned, most applications are composed of two distinct parts – the application binary and a configuration. This model doesn’t change with cloud-native microservices applications running on Kubernetes. However, a core principle of these types of applications is decoupling the two components – you build and store them separately but bring them together at runtime.

Let’s consider an example to understand some of the benefits:
A quick example#

Imagine the following.

You work for a company that deploys modern applications to Kubernetes, and you have three distinct environments:

    Dev
    Test
    Prod

Your developers write and update applications. Initial testing is performed in the dev environment; further testing is done in the test environment, where more stringent rules and the likes are applied. Finally, stable components graduate to the prod environment.

Each environment has subtle differences, such as number of nodes, configuration of nodes, network and security policies, and different sets of credentials and certificates.

You currently package each application microservice with its configuration baked into the container (the application and configuration are packaged as a single artifact). With this in mind, you have to perform all of the following for every business application:

    build three distinct images (one for dev, one for test, one for prod).
    store the images in three distinct repositories (dev, test, prod).
    run each version of the image in a specific environment (dev in dev, test in test, prod in prod).

Every time you make a change to an application configuration, you need to create an entire new image and perform some type of rolling update to the entire app – even if the change is something as simple as fixing a typo or changing the size or color of a font 😃.
Analyzing the example#

There are several drawbacks to the approach of storing the application and its configuration as a single artifact (container image).

As your dev, test, and prod environments have different characteristics, each environment needs its own image. A prod image will not work in the dev or test environments because of the differences. This requires extra work to create and maintain 3x copies of each application. This can complicate matters and increase the chances of misconfiguration.

You also have to store 3x images in 3 distinct repositories. Plus, you need to be very careful about permissions to repositories. This is because your prod images will contain sensitive configuration data, sensitive passwords, and sensitive encryption keys. You probably don’t want dev and test engineers to have access to prod images – access to the images means access to the sensitive data stored in them.

Also, it’s harder to troubleshoot an issue if you push an update that includes both an application binary update as well as a configuration update. If the two are tightly coupled, it’s harder to isolate the fault. Also, if you need to make a minor configuration change (for example, fix a prominent typo on a web page), you need to repackage, retest, and redeploy the entire application binary and configuration.

None of this is ideal.
What it looks like in a decoupled world#

Now consider you work for the same company but you do things differently. This time, your application and its configuration are de-coupled. This time:

    You build a single image that is shared across all three environments.
    You store a single image in a single repository.
    You run a single version of each image in all environments.

To make this work, you build your application images as generically as possible, with no embedded configuration. You then create and store configurations in separate objects and apply a configuration to the application when you run it. For example, you have a single copy of a web server that you can deploy to all three environments. When you deploy it to prod you apply the prod configuration to it. When you run it in dev, you apply the dev configuration to it.

In this model, you create and test a single version of each application image that you store in a single repository. All staff can have access to the image repository as there is no sensitive data stored in the images. Finally, you can easily push changes to the application and its configuration independent of each other – updating a simple typo no longer requires the entire application binary and image to be rebuilt and redeployed.

</details>

<details>
<summary>ConfigMap Theory</summary>
<br>

  <img width="497" alt="image" src="https://user-images.githubusercontent.com/75510135/167279903-5128b6ff-4fb4-41a6-8d73-8081e0787ae9.png">

  Kubernetes provides an object, called a ConfigMap (CM), that lets you store configuration data outside of a Pod. It also lets you dynamically inject the data into a Pod at runtime.

    Note: When we use the term Pod we mean the Pod and all of its containers. After all, it is ultimately the container that receives the configuration data.

ConfigMaps are first-class objects in the Kubernetes API under the core API group, and they’re v1. This tells us a lot of things:

    They’re stable (v1).
    They’ve been around for a while (the fact that they’re in the core API group).
    You can operate on them with the usual kubectl commands.
    They can be defined and deployed via the usual YAML manifests.

ConfigMaps are typically used to store nonsensitive configuration data such as:

    Environment variable values
    Entire configuration files (things like web server configs and database configs)
    Hostnames
    Service ports
    Account names

You should not use ConfigMaps to store sensitive data, such as certificates and passwords. Kubernetes provides a different object, called a Secret, for storing sensitive data. Secrets and ConfigMaps are very similar in design and implementation, the major difference is that Kubernetes takes steps to obscure the values stored in Secrets. It makes no such efforts to obscure data stored in ConfigMaps.
How do ConfigMaps work#

At a high level, a ConfigMap is a place to store configuration data that can be seamlessly injected into containers at runtime and then leveraged in ways that are invisible to applications.

Let’s look a bit closer.

Behind the scenes, ConfigMaps are a map of key-value pairs, and we call each key-value pair an entry.

    Keys are an arbitrary name that can be created from alphanumerics, dashes, dots, and underscores.
    Values can contain anything, including carriage returns.
    We separate keys and values with a colon – key:value.

Some simple examples might be:

    db-port:13306
    hostname:msb-prd-db1

More complex examples can store entire configuration files like this one:

key: conf
value:

  ```
  directive in;
main block;
http {
  server {
    listen        80 default_server;
    server_name   *.msb.com;
    root          /var/www/msb.com;
    index         index.html

    location / {
      root   /usr/share/nginx/html;
      index  index.html;      
    }
  }
}
  ```
  
  Once data is stored in a ConfigMap, it can be injected into containers at runtime via any of the following methods:

    Environment variables
    Arguments to the container’s startup command
    Files in a volume

All of the methods work seamlessly with existing applications. In fact, all an application sees is its configuration data in either an environment variable, an argument to a startup command, or a file in a filesystem. The application is unaware that the data originally came from a ConfigMap.

The figure below shows how the pieces connect.

  <img width="760" alt="image" src="https://user-images.githubusercontent.com/75510135/167280117-1e0366ae-ede1-4be4-aa9f-d2c7a2dfa26d.png">

  The most flexible of the three methods is the volume option, and the most limited is the startup command. We’ll look at each in turn, but, before we do that, we’ll quickly consider a Kubernetes-native application.
ConfigMaps and Kubernetes-native apps #

A Kubernetes-native application is an application that knows it’s running on Kubernetes and has the intelligence to query the Kubernetes API. As a result, a Kubernetes-native application can access ConfigMap data directly via the API without needing things like environment variables and volumes. This can simplify application configuration, but the application will only run on Kubernetes. At the time of writing, Kubernetes-native applications are rare.

</details>

<details>
<summary>Hands-On: Creating ConfigMaps Imperatively</summary>
<br>

  As with most Kubernetes objects, you can create them imperatively and declaratively. We’ll look at the imperative method first.

The command to imperatively create a ConfigMap is kubectl create configmap, but you can shorten configmap to cm. The command accepts two sources of data:

    literal values on the command line (--from-literal)
    files referenced on the command line (--from-file)

Run the following command to create a, ConfigMap called testmap1, populated with two map entries from literal values passed on the command line.

  <img width="923" alt="image" src="https://user-images.githubusercontent.com/75510135/167280231-fd3c7186-4001-46b0-b008-172ef63bacc3.png">

  You can see that the object is essentially a map of key/value pairs dressed up as a Kubernetes object. The two map entries are exactly what you would expect from the inputs to the command:

    Entry 1: shortname=msb.com
    Entry 2: longname=magicsandbox.com

The next command will create a ConfigMap from a file called cmfile.txt. The command assumes you have a local file called cmfile.txt in your working directory.
cmfile.txt

Run this command to create the ConfigMap from the contents of the file. Notice that the command uses the --from-file argument instead of --from-literal.

  <img width="934" alt="image" src="https://user-images.githubusercontent.com/75510135/167280243-fc69d22e-d4a2-451b-a795-749c7a8ab439.png">

  <img width="891" alt="image" src="https://user-images.githubusercontent.com/75510135/167280248-2bf15dc2-a86b-4c07-9489-31cd78d05827.png">

  Inspecting ConfigMaps#

ConfigMaps are first-class API objects. This means you can inspect and query them in the same way as any other API object. You’ve already seen kubectl describe commands, but other kubectl commands also work. kubectl get can list all ConfigMaps, and the usual -o yaml and -o json flags pull the full configuration from the cluster store.

Run a kubectl get to list all ConfigMaps in your current Namespace.

  <img width="923" alt="image" src="https://user-images.githubusercontent.com/75510135/167280255-6324a365-05d7-4f11-bd37-d6faec82eca7.png">

  <img width="889" alt="image" src="https://user-images.githubusercontent.com/75510135/167280261-38f06f20-a503-409b-a84a-5bf9ba92edc7.png">

  
</details>

<details>
<summary>Hands-On: Creating ConfigMaps Declaratively</summary>
<br>
This is how you dropdown.
</details>

<summary>Hands-On: Creating ConfigMaps Declaratively</summary>
<br>

The following ConfigMap manifest defines two map entries: firstname and lastname. It is called multimap.yml. Alternatively, you can create an empty file and practice writing your own manifests from scratch.
<img width="570" alt="image" src="https://user-images.githubusercontent.com/75510135/167280479-8baa5ff3-975f-4a5a-98ee-947640e01b7e.png">
You can see that a ConfigMap manifest has the normal kind and apiVersion fields as well as the usual metadata section. However, as previously mentioned, they do not have a spec section. Instead, they have a data section that defines the map of key/values.

You can deploy it with the following command (the command assumes you have a copy of the file in your working directory called multimap.yml).
<img width="898" alt="image" src="https://user-images.githubusercontent.com/75510135/167280497-26513cf6-698a-465c-b209-54a454738cc0.png">
The previous YAML file inserts a pipe character (|) after the name of the entry’s key property. This tells Kubernetes that everything following the pipe is to be treated as a single literal value. Therefore, the ConfigMap object is called test-conf, and it contains a single map entry as follows:

    Key: test.conf
    Value:

<img width="899" alt="image" src="https://user-images.githubusercontent.com/75510135/167280504-0adb0ebb-274d-430a-a4b2-a69cbe1288d1.png">

<img width="871" alt="image" src="https://user-images.githubusercontent.com/75510135/167280509-25e754c0-80ac-4ce5-bb70-a5c71276a57d.png">

ConfigMaps are extremely flexible and can be used to insert complex configuration files, such as JSON files and even scripts into containers at runtime.

</details>



