<details>
<summary>3A's</summary>
<br>
  
  <img width="999" alt="image" src="https://user-images.githubusercontent.com/75510135/165540713-7063d2bd-a759-448a-a9d7-ea6182d12856.png">

  
</details>

<details>
<summary>RBAC</summary>
<br>

  <img width="966" alt="image" src="https://user-images.githubusercontent.com/75510135/165541657-fa7aa3ca-ae07-4e2a-9150-867ff70a363b.png">

  <img width="874" alt="image" src="https://user-images.githubusercontent.com/75510135/165541737-9b7d7d06-0572-4c79-854a-0756711d2d44.png">

  
</details>


<details>
<summary>Role & RoleBinding</summary>
<br>

  <img width="1003" alt="image" src="https://user-images.githubusercontent.com/75510135/165542940-e6a5ceef-8d14-4892-ae1f-2be3e9923fb3.png">

</details>


<details>
<summary>Exercise Role n Rolebinding</summary>
<br>

            ```
            * Reference:                                                                                      *
          * ----------                                                                                      *
          * https://kubernetes.io/docs/reference/access-authn-authz/authorization/                          *
          * https://kubernetes.io/docs/reference/access-authn-authz/rbac/                                   *
          * https://www.sumologic.com/glossary/role-based-access-control/                                   *
          * https://www.cncf.io/blog/2018/08/01/demystifying-rbac-in-kubernetes/                            *
          *                                                                                                 *
          ***************************************************************************************************

          In this demo:
          -------------
          a. First, we will create the test "user account" and "namespace" for testing this demo
          b. Then, We will create the Role with list of actions performed in a "specific namespace"
          c. And finally, We will assign this role to "user" by creating "RoleBinding"

          Note:
          ----
          a. Role and RoleBindings are "Namespace" specific.
          b. You can assign Role to "Service Account" instead of user. For more details, please refer below link:
          https://kubernetes.io/docs/reference/access-authn-authz/rbac/


          ***************************************************************************************************


          1. Creating Kubernetes test User Account(appuser) (using x509 for testing RBAC)
          ------------------------------------------------------------------------------

          # Generating Key
          openssl genrsa -out appuser.key 2048

          # Generaing Certificate Signing request (csr):
          openssl req -new -key appuser.key -out appuser.csr -subj "/CN=appuser"

          # Signing CSR using K8s Cluster "Certificate" and "Key"
          openssl x509 -req -in appuser.csr \
                  -CA /etc/kubernetes/pki/ca.crt \
                  -CAkey /etc/kubernetes/pki/ca.key \
                  -CAcreateserial \
                  -out appuser.crt -days 300

          # Adding user credentials to "kubeconfig" file
          kubectl config set-credentials appuser  --client-certificate=appuser.crt --client-key=appuser.key

          # Creating context for this user and associating it with our cluster:
          kubectl config set-context appuser-context --cluster=kubernetes --user=appuser

          # Displaying K8s Cluster Config
          kubectl config view


          ***************************************************************************************************


          2. Creating Namespaces and Pod for testing RBAC:
          ------------------------------------------------

          2a. Creating test Namespace:
          ----------------------------
          kubectl create ns dev-ns

          ................................................

          1b. Creating test Pod:
          ----------------------
          kubectl run nginx-pod --image=nginx -n dev-ns
          kubectl get pods -n dev-ns

          ................................................

          1c. Test Before Deploying:
          --------------------------
          kubectl get pods -n dev-ns --user=appuser 


          ***************************************************************************************************


          2. Creating a "Role" & "RoleBinding":
          -------------------------------------

          2a. Creating Resources Declaratively (Using YAML):
          -------------------------------------------------
          # Role
          kind: Role
          apiVersion: rbac.authorization.k8s.io/v1
          metadata:
            namespace: dev-ns
            name: pod-reader
          rules:
          - apiGroups: [""] 
            resources: ["pods"]
            verbs: ["get", "watch", "list"]
          ---
          # RoleBinding
          kind: RoleBinding
          apiVersion: rbac.authorization.k8s.io/v1
          metadata:
            name: read-pods
            namespace: dev-ns
          subjects:
          - kind: User
            name: appuser 
            apiGroup: rbac.authorization.k8s.io
          roleRef:
            kind: Role 
            name: pod-reader 
            apiGroup: rbac.authorization.k8s.io


          ..........................................................................


          2b. Creating Resources Imperatively (Commands):
          -----------------------------------------------

          # role
          kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods --namespace=dev-ns

          # rolebinding
          kubectl create rolebinding read-pods --role=pod-reader --user=appuser --namespace=dev-ns


          ***************************************************************************************************


          3. Display Role and RoleBinding:
          --------------------------------
          # role
          kubectl get role -n dev-ns

          # rolebinding
          kubectl get rolebinding -n dev-ns

          kubectl describe role -n dev-ns
          kubectl describe rolebinding -n dev-ns


          ***************************************************************************************************


          4. Testing RBAC:
          ----------------

          Pod Operations: get, list, watch - in "dev-ns" namespace:
          ----------------------------------------------------------
          kubectl auth can-i get pods -n dev-ns --user=appuser
          kubectl auth can-i list pods -n dev-ns --user=appuser

          kubectl get pod nginx-pod -n dev-ns --user=appuser
          kubectl get pods -n dev-ns --user=appuser

          ...........................................................................

          Pod Operations: get, list, watch - in "NON dev-ns" namespace:
          ------------------------------------------------------------
          kubectl auth can-i get pods -n kube-system --user=appuser
          kubectl auth can-i list pods -n kube-system --user=appuser
          kubectl auth can-i watch pods -n kube-system --user=appuser

          kubectl get pods --user=appuser # queries default namespace
          kubectl get pods -n kube-system --user=appuser

          ...........................................................................

          Creating Objects in "dev-ns" namespace: 
          ----------------------------------------
          kubectl auth can-i create pods -n dev-ns --user=appuser
          kubectl auth can-i create services -n dev-ns --user=appuser
          kubectl auth can-i create deployments -n dev-ns --user=appuser

          kubectl run redis-pod -n dev-ns --image=redis --user=appuser
          kubectl create deploy redis-deploy -n dev-ns --image=redis --user=appuser

          ...........................................................................


          Deleting Objects in "dev-ns" namespace: 
          ----------------------------------------
          kubectl auth can-i delete pods -n dev-ns --user=appuser
          kubectl auth can-i delete services -n dev-ns --user=appuser
          kubectl auth can-i delete deployments -n dev-ns --user=appuser

          kubectl delete pods nginx-pod -n dev-ns --user=appuser


          ***************************************************************************************************

          5. Cleanup:
          -----------
          kubectl config unset contexts.appuser-context
          kubectl config unset users.appuser

          kubectl config view

          kubectl get pod nginx-pod -n dev-ns --user=appuser
          kubectl get pods -n dev-ns --user=appuser

          kubectl delete role pod-reader -n dev-ns
          kubectl delete rolebinding read-pods -n dev-ns


          ***************************************************************************************************
  ```
</details>


<details>
<summary>Cluster Role & Cluster Role Binding</summary>
<br>

  <img width="893" alt="image" src="https://user-images.githubusercontent.com/75510135/165756694-13d7e0ac-70db-4e5c-a491-b7993663b372.png">

  <img width="1005" alt="image" src="https://user-images.githubusercontent.com/75510135/165756617-58d50557-e65f-4263-bb6d-fe5aae21fc5d.png">

</details>


<details>
<summary>Exercise - ClusterRole & ClusterRole Binding</summary>
<br>
  ```
          * Reference:                                                                                      *
        * ----------                                                                                      *
        * https://kubernetes.io/docs/reference/access-authn-authz/authorization/                          *
        * https://kubernetes.io/docs/reference/access-authn-authz/rbac/                                   *
        * https://www.sumologic.com/glossary/role-based-access-control/                                   *
        * https://www.cncf.io/blog/2018/08/01/demystifying-rbac-in-kubernetes/                            *
        *                                                                                                 *
        ***************************************************************************************************

        In this demo:
        -------------
        a. First, we will create the test "user account" for testing this demo
        b. Next,  We will create the "ClusterRole" with list of actions performed "across all namespaces"
        c. After that, We will assign this ClusterRole to "user" by creating "ClusterRoleBinding"
        d. Finally, we will test the above configuration by deploying sample applications.

        Note:
        ----
        a. ClusterRole and ClusterRoleBindings are "NON-Namespace" specific.


        ***************************************************************************************************


        1. Creating Kubernetes test User Account(appmonitor) (using x509 for testing RBAC)
        ------------------------------------------------------------------------------

        # Generating Key
        openssl genrsa -out appmonitor.key 2048

        # Generaing Certificate Signing request (csr):
        openssl req -new -key appmonitor.key -out appmonitor.csr -subj "/CN=appmonitor"

        # Singing CSR using K8s Cluster "Certificate" and "Key"
        openssl x509 -req -in appmonitor.csr \
                -CA /etc/kubernetes/pki/ca.crt \
                -CAkey /etc/kubernetes/pki/ca.key \
                -CAcreateserial \
                -out appmonitor.crt -days 300

        # Adding user credentials to "kubeconfig" file
        kubectl config set-credentials appmonitor  --client-certificate=appmonitor.crt --client-key=appmonitor.key

        # Creating context for this user and associating it with our cluster:
        kubectl config set-context appmonitor-context --cluster=kubernetes --user=appmonitor

        # Displaying K8s Cluster Config
        kubectl config view


        ***************************************************************************************************


        2. Creating Namespaces and Pod for testing RBAC:
        ------------------------------------------------

        kubectl create ns test-ns1
        kubectl create ns test-ns2


        2a. Creating test Pod:
        ----------------------
        #Pod
        kubectl run nginx-pod-default --image=nginx
        kubectl run redis-pod-ns1 --image=redis -n test-ns1
        kubectl run httpd-pod-ns2 --image=busybox -n test-ns2

        ................................................

        2c. Test Before Deploying:
        --------------------------
        kubectl get pods --user=appmonitor
        kubectl get pods -n test-ns1 --user=appmonitor
        kubectl get pods -n test-ns2 --user=appmonitor 
        kubectl get pods -n kube-system --user=appmonitor
        kubectl get pods -A --user=appmonitor


        ***************************************************************************************************


        2. Creating a "ClusterRole" & "ClusterRoleBinding":
        -------------------------------------

        2a. Creating Resources Declaratively (Using YAML):
        -------------------------------------------------
        # ClusterRole
        kind: ClusterRole
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: clusterrole-monitoring
        rules:
        - apiGroups: [""] 
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        ---
        # ClusterRoleBinding
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: clusterrole-binding-monitoring
        subjects:
        - kind: User
          name: appmonitor 
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: ClusterRole 
          name: clusterrole-monitoring
          apiGroup: rbac.authorization.k8s.io


        ..........................................................................


        2b. Creating Resources Imperatively (Commands):
        -----------------------------------------------

        # Cluster-role
        kubectl create clusterrole clusterrole-monitoring --verb=get,list,watch --resource=pods

        # Cluster-rolebinding
        kubectl create clusterrolebinding clusterrole-binding-monitoring --clusterrole=clusterrole-monitoring --user=appmonitor


        ***************************************************************************************************


        3. Display ClusterRole and ClusterRoleBinding:
        ----------------------------------------------
        # clusterrole
        kubectl get clusterrole | grep clusterrole-monitoring

        # clusterrolebinding
        kubectl get clusterrolebinding | grep clusterrole-binding-monitoring

        kubectl describe clusterrole clusterrole-monitoring
        kubectl describe clusterrolebinding clusterrole-binding-monitoring


        ***************************************************************************************************


        4. Testing ClusterRole & ClusterRoleBinding:
        --------------------------------------------


        Pod Operations: get, list, watch - in "kube-system", "default", "test-ns1", and "test-ns2" namespaces:
        ------------------------------------------------------------------------------------------------------
        kubectl auth can-i get pods -n kube-system --user=appmonitor
        kubectl auth can-i get pods -n default --user=appmonitor
        kubectl auth can-i get pods -n test-ns1 --user=appmonitor
        kubectl auth can-i get pods -n test-ns2 --user=appmonitor

        kubectl get pods -n kube-system --user=appmonitor
        kubectl get pods -n default --user=appmonitor
        kubectl get pods -n test-ns1 --user=appmonitor
        kubectl get pods -n test-ns2 --user=appmonitor


        ...........................................................................


        Creating Objects in "default" (or in any other) namespace: 
        -------------------------------------------------------
        kubectl auth can-i create pods --user=appmonitor
        kubectl auth can-i create services --user=appmonitor
        kubectl auth can-i create deployments --user=appmonitor

        kubectl run redis-pod --image=redis --user=appmonitor
        kubectl create deploy redis-deploy --image=redis --user=appmonitor

        ...........................................................................


        Deleting Objects in "default" (or in any other) namespace: 
        ----------------------------------------------------------
        kubectl auth can-i delete pods --user=appmonitor
        kubectl auth can-i delete services --user=appmonitor
        kubectl auth can-i delete deployments --user=appmonitor

        kubectl delete pods nginx-pod --user=appmonitor


        ***************************************************************************************************

        5. Cleanup:
        ------------

        #Delete ClusterRole and ClusterRoleBinding:
        -------------------------------------------
        kubectl delete clusterrole clusterrole-monitoring 
        kubectl delete clusterrolebinding clusterrole-binding-monitoring

        #Removing User and Context from Cluster Config
        -----------------------------------------------
        kubectl config unset users.appmonitor
        kubectl config unset contexts.appmonitor-context

        Ensure user "appmonitor" and its configuration is removed:
        ----------------------------------------------------------
        kubectl get pods --user=appmonitor
        kubectl config view

        Deleting Pods:
        --------------
        kubectl delete pod nginx-pod-default 
        kubectl delete pod redis-pod-ns1 -n test-ns1
        kubectl delete pod httpd-pod-ns2 -n test-ns2

        #Deleting Namespace:
        --------------------
        kubectl delete ns test-ns1
        kubectl delete ns test-ns2

        #Validating:
        -----------
        kubectl get ns
        kubectl get pods
        kubectl get clusterrole | grep monitoring
        kubectl get clusterrolebinding | grep monitoring
  ```
</details>

<details>
<summary>Add-on Articles</summary>
<br>

  ```
  https://kubernetes.io/docs/reference/access-authn-authz/authorization/

  https://kubernetes.io/docs/reference/access-authn-authz/rbac/

  https://www.sumologic.com/glossary/role-based-access-control/

  https://www.cncf.io/blog/2018/08/01/demystifying-rbac-in-kubernetes/

  https://thenewstack.io/three-realistic-approaches-to-kubernetes-rbac/
  ```
</details>



