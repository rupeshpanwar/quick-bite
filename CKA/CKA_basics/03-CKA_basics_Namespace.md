<details>
<summary>Introduction</summary>
<br>

  - partitioned based on h/w capacity & n/w segregation
  <img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/163709985-7e8984d4-f78b-4b25-ab37-7d800bbe6ab6.png">

  
</details>

<details>
<summary>NS - sneekpeek - Yaml</summary>
<br>

  <img width="1015" alt="image" src="https://user-images.githubusercontent.com/75510135/163710134-4a03dfe0-0945-4e73-8f1a-a479fc845be6.png">

  <img width="1006" alt="image" src="https://user-images.githubusercontent.com/75510135/163710155-a6839436-4b19-4205-b439-47638343323d.png">

  
</details>

<details>
<summary>NS - Tasks</summary>
<br>

  <img width="1019" alt="image" src="https://user-images.githubusercontent.com/75510135/163710244-bd229703-8ba0-4ab0-a2f9-b45dea2c0c6e.png">

</details>


<details>
<summary>NS - exercise</summary>
<br>

  ```
       Reference:                                                                                      
    
      * https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/                   *
      * https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/                     *
      * https://kubernetes.io/docs/tasks/administer-cluster/namespaces/                                 *
      * https://kubernetes.io/blog/2016/08/kubernetes-namespaces-use-cases-insights/                    *
     
      1. Creating NameSpace:
      ~~~~~~~~~~~~~~~~~~~~~~

      1a). Using YAML:
      ----------------
      # dev-ns.yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: dev


      1b). Using Imepratively:
      -------------------------
      kubectl create namespace test


      2. Displaying Namespace
      ~~~~~~~~~~~~~~~~~~~~~~~
      kubectl get ns [NAMESPACE-NAME]
      kubectl get ns [NAMESPACE-NAME] -o wide
      kubectl get ns [NAMESPACE-NAME] -o yaml
      kubectl get pods –-namespace=[NAMESPACE-NAME]

      kubectl describe ns [NAMESPACE-NAME]


      ***************************************************************************************************

      3. Creating Pod Object in Specific NameSpace:
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      kubectl run nginx --image=nginx --namespace=dev

      Validate:
      ----------
      kubectl get pods
      kubectl get pods -n dev



      ***************************************************************************************************

      4. Displaying Objects in All Namespace:
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      kubectl get pods -A
      or
      kubectl get [object-name] --all-namespaces


      ***************************************************************************************************

      5. Setting the namespace preference:
      ------------------------------------

      Note: 
      -----
      1. You can permanently save the namespace for all subsequent kubectl commands in that context.
      2. --minify=false: Remove all information not used by current-context from the output

      Syntax: 
      kubectl config set-context --current --namespace=<insert-namespace-name-here>

      -----------

      kubectl config view --minify | grep namespace:
      kubectl get pods

      kubectl config set-context --current --namespace=test
      kubectl config view --minify | grep namespace:
      kubectl run redis --image=redis 
      kubectl get pods

      kubectl config set-context --current --namespace=default
      kubectl config view --minify | grep namespace:
      kubectl run httpd --image=httpd


      ***************************************************************************************************

      6. Deleting Namespaces
      ~~~~~~~~~~~~~~~~~~~~~~
      kubectl delete pods nginx -n dev
      kubectl delete pods redis -n test
      kubectl delete pods httpd
      kubectl get pods -A

      kubectl get ns
      kubectl delete ns dev
      kubectl delete ns test
      kubectl get ns
      kubectl get pods

  ```
</details>

<details>
<summary>NS - Addon - reading</summary>
<br>

 - https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

 - https://kubernetes.io/docs/tasks/administer-cluster/namespaces/#creating-a-new-namespace

 - https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/

 - https://kubernetes.io/docs/tasks/administer-cluster/namespaces/

 - https://kubernetes.io/blog/2016/08/kubernetes-namespaces-use-cases-insights/
</details>

