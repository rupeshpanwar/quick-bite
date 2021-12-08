<img width="824" alt="image" src="https://user-images.githubusercontent.com/75510135/144813674-6e22ab38-bbbe-4b52-a090-5c44f03a3fa3.png">
<img width="804" alt="image" src="https://user-images.githubusercontent.com/75510135/144813765-eb0fcf24-f69c-449e-8a1b-7bb3d19a013c.png">
<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/144813894-5479c369-cdf1-4ad9-a370-9e2598960a06.png">
<img width="805" alt="image" src="https://user-images.githubusercontent.com/75510135/144814310-82846bfb-bbf7-42a6-bec6-67127025cf1f.png">
<img width="823" alt="image" src="https://user-images.githubusercontent.com/75510135/144814386-f265e5ab-5bfa-45b7-b5bf-65638dd70537.png">
<img width="796" alt="image" src="https://user-images.githubusercontent.com/75510135/144814525-78409db9-4821-406f-b30b-852eb7bf4dec.png">
<img width="813" alt="image" src="https://user-images.githubusercontent.com/75510135/144833016-4e079cae-07b8-4fb6-a8b6-962f2b873db3.png">
<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144833182-ce5d6876-45aa-44db-9acb-63449ea75683.png">
<img width="821" alt="image" src="https://user-images.githubusercontent.com/75510135/144833239-e96b2189-7891-49aa-98c8-4ba2119c1dd0.png">
<img width="813" alt="image" src="https://user-images.githubusercontent.com/75510135/144865509-7abb0a1f-d48c-474d-842d-b705b81036b5.png">
<img width="798" alt="image" src="https://user-images.githubusercontent.com/75510135/144865602-eb51b731-46db-402e-aa0d-d4acadb81b64.png">
<img width="795" alt="image" src="https://user-images.githubusercontent.com/75510135/144865835-268aea6f-43b8-45cf-b069-310a1f8e954c.png">

<img width="798" alt="image" src="https://user-images.githubusercontent.com/75510135/144865970-ac832653-2939-4484-8c84-ddeef8f209c6.png">

<img width="811" alt="image" src="https://user-images.githubusercontent.com/75510135/144866065-df2a7a4e-7273-4482-a66f-c128d7ec6d19.png">
```
Create a deployment called littletomcat using the tomcat image.

kubectl create deployment littletomcat --image=tomcat

What command will help you get the IP address of that Tomcat server?

List all pods with label app=littletomcat, with extra details including IP address: kubectl get pods --selector=app=littletomcat -o wide. You could also describe the pod: kubectl describe pod littletomcat-XXX-XXX

What steps would you take to ping it from another container?                               

(Use the shpod environment if necessary)

One way to start a shell inside the cluster:

kubectl apply -f https://k8smastery.com/shpod.yaml

then

kubectl attach --namespace=shpod -ti shpod

A short cut way is to run that like this (a special domain name we created) curl https://shpod.sh | sh

Then the IP address of the pod should ping correctly. You could also start a deployment or pod temporarily (like nginx), then exec in, install ping, and ping the IP.

What command would delete the running pod inside that deployment?

We can delete the pod with: kubectl delete pods --selector=app=littletomcat or copy/paste the exact pod name and delete it.

What happens if we delete the pod that holds Tomcat, while the ping is running?

If we delete the pod, the following things will happen:

    the pod will be gracefully terminated

    the ping command that we left running will fail

    the replica set will notice that it doens't have the right count of pods and create a replacement pod

    that new pod will have a different IP address (so the ping command won't recover) 

What command can give our Tomcat server a stable DNS name and IP address?                                         

(An address that doesn't change when something bad happens to the container)

We need to create a Service for our deployment, which will have a ClusterIP that is usable from within the cluster. One way is with kubectl expose deployment littletomcat --port=8080

(The Tomcat image is listening on port 8080 according to Docker Hub)

Another way is with kubectl create service clusterip littletomcat --tcp 8080

What commands would you run to curl Tomcat with that DNS address?

(Use the shpod environment if necessary)

In a shpod environment, we could:

- Install curl in Alpine

apk add curl

- Make a request to the littletomcat service

curl http://littletomcat:8080

If in shpod, you need to specify the different namespace

curl http://littletomcat.default:8080

Note that shpod runs in the shpod namespace, so to find a DNS name of a different namespace in the same cluster, you should use <hostname>.<namespace> syntax. That was a little advanced, so A+ if you got it on the first try!

Also Note, shpod is set so that kubectl uses the default namespace as its context, which means you don't have to add -n default to all your kubectl commands.

If we delete the pod that holds Tomcat, does the IP address still work? How could we test that?

Yes. If we delete the pod, another will be created to replace it. The ClusterIP will still work.                                                           

(Except during a short period while the replacement container is being started)
```
deploy another application called wordsmith

Wordsmith has 3 components:

    a web frontend bretfisher/wordsmith-web

    an API backend bretfisher/wordsmith-words

    a postgres DB bretfisher/wordsmith-db

These images have been built and pushed to Docker Hub

We want to deploy all 3 components on Kubernetes


Here's how the parts of this app communicate with each other:

    The web frontend listens on port 80

    The web frontend should be public (available on a high port from outside the cluster)

    The web frontend connects to the API at the address http://words:8080

    The API backend listens on port 8080

    The API connects to the database with the connection string pgsql://db:5432

    The database listens on port 5432

Your Assignment is to create the kubectl create commands to make this all work

This is what we should see when we bring up the web frontend on our browser:

  (You will probably see a different sentence, though.)

- Yes, there is some repetition in that sentence; that's OK for now

- If you see empty LEGO bricks, something's wrong ...
Questions for this assignment

What deployment commands did you use to create the pods?

What service commands did you use to make the pods available on a friendly DNS name?

If we add more wordsmith-words API pods, then when the browser is refreshed, you'll see different words. What is the command to scale that deployment up to 5 pods? Test it to ensure a browser refresh shows different words.

```
What deployment commands did you use to create the pods?

kubectl create deployment db --image=bretfisher/wordsmith-db
kubectl create deployment web --image=bretfisher/wordsmith-web
kubectl create deployment words --image=bretfisher/wordsmith-words

What service commands did you use to make the pods available on a friendly DNS name?

kubectl expose deployment db --port=5432
kubectl expose deployment web --port=80 --type=NodePort
kubectl expose deployment words --port=8080

or this will also work:

kubectl create service clusterip db --tcp=5432
kubectl create service nodeport web --tcp=80
kubectl create service clusterip words --tcp=8080

Then you'll want to get the port that web is listening on the host:

kubectl get service web

If we add more wordsmith-words API pods, then when the browser is refreshed, you'll see different words. What is the command to scale that deployment up to 5 pods? Test it to ensure a browser refresh shows different words.

kubectl scale deployment words --replicas=5 
```

goal here will be to create a service that load balances connections to two different deployments. You might use this as a simplistic way to run two versions of your apps in parallel for a period of time.

In the real world, you'll likely use a 3rd party load balancer to provide advanced blue/green or canary-style deployments, but this assignment will help further your understanding of how service selectors are used to find pods and use them as service endpoints.

For simplicity, version 1 of our application will be using the NGINX image, and version 2 of our application will be using the Apache image. They both listen on port 80 by default and have different HTML by default so that it's easy to distinguish which is being accessed.

Once properly set up, when we connect to the service we expect to see some requests being served by NGINX and some requests being served by Apache.
Objectives:

    We need to create two deployments: one for v1 (NGINX), another for v2 (Apache).

    They will be exposed through a single service.

    The selector of that service will need to match the pods created by *both* deployments.

    For that, we will need to change the deployment specification to add an extra label, to be used solely by the service.

    That label should be different from the pre-existing labels of our deployments, otherwise, our deployments will step on each other's toes.

    We're not at the point of writing our own YAML from scratch, so you'll need to use the kubectl edit command to modify existing resources.

Questions for this assignment

What commands did you use to perform the following?

1. Create a deployment running one pod using the official NGINX image.

2. Expose that deployment.

3. Check that you can successfully connect to the exposed service.

What commands did you use to perform the following?

1. Change (edit) the service definition to use a label/value of myapp: web

2. Check that you cannot connect to the exposed service anymore.

3. Change (edit) the deployment definition to add that label/value to the pod template.

4. Check that you *can* connect to the exposed service again.

What commands did you use to perform the following?

1. Create a deployment running one pod using the official Apache image (httpd).

2. Change (edit) the deployment definition to add the label/value picked previously.

3. Connect to the exposed service again.

(It should now yield responses from both Apache and NGINX.)

```
What commands did you use to perform the following?

1. Create a deployment running one pod using the official NGINX image.

2. Expose that deployment.

3. Check that you can successfully connect to the exposed service.

1. kubectl create deployment v1-nginx --image=nginx

2. kubectl expose deployment v1-nginx --port=80 or kubectl create service v1-nginx --tcp=80

3. If you are using `shpod`, or if you are running directly on the cluster:

kubectl get svc v1-nginx
curl http://A.B.C.D

You can also run a program like `curl` in a container:

kubectl run --restart=Never --image=alpine -ti --rm testcontainer
### Then, once you get a prompt, install curl
apk add curl
curl v1-nginx

What commands did you use to perform the following?

1. Change (edit) the service definition to use a label/value of myapp: web

2. Check that you cannot connect to the exposed service anymore.

3. Change (edit) the deployment definition to add that label/value to the pod template.

4. Check that you *can* connect to the exposed service again.

1. Edit the YAML manifest of the service with kubectl edit service v1-nginx. Look for the selector: section, and change app: v1-nginx to myapp: web. Make sure to change the selector: section, not the labels: section! After making the change, save and quit.

3. The curl command should now time out. The service can't find a pod with that label yet.

4. Edit the YAML manifest of the deployment with kubectl edit deployment v1-nginx. Look for the labels: section within the template: section, as we want to change the labels of the pods created by the deployment, not of the deployment itself. Ignore the matchLabels: one. Add myapp: web just below app: v1-nginx, with the same indentation level. After making the change, save and quit. We need both labels here, unlike the service selector. The app label keeps the pod "linked" to the deployment/replicaset, and the new one will cause the service to match to this pod.

5. The `curl` command should now work again. (It might need a minute, since changing the label will trigger a rolling update and create a new pod.)

What commands did you use to perform the following?

1. Create a deployment running one pod using the official Apache image (httpd).

2. Change (edit) the deployment definition to add the label/value picked previously.

3. Connect to the exposed service again.

(It should now yield responses from both Apache and NGINX.)

1. kubectl create deployment v2-apache --image=httpd

2. Same as previously: kubectl edit deployment v2-apache, then add the label myapp: web below app: v2-apache. Again, make sure to change the labels in the pod template, not of the deployment itself.

3. The curl command show now yield responses from NGINX and Apache.

(Note: you won't see a perfect round-robin, i.e. NGINX/Apache/NGINX/Apache etc., but on average, Apache and NGINX should serve approximately 50% of the requests each.)
```
