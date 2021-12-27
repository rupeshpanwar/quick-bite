LAB: Troubleshooting Pod Issues
Troubleshooting Tip


If you would like to know whats the current status of the pod, and if its in a error state, find out the cause of the error, following command could be very handy.

    kubectl get pod vote -o yaml

Lets learn by example. Update pod spec and change the image to something that does not exist.

    kubectl edit pod vote

This will open a editor. Go to the line which defines image and change it to a tag that does not exist

e.g.

    spec:
      containers:
      - image: schoolofdevops/vote:srgwegew
        imagePullPolicy: Always

where tag srgwegew does not exist. As soon as you save this file, kubernetes will apply the change.

Now check the status,

    kubectl get pods  
     
    NAME      READY     STATUS             RESTARTS   AGE
    vote      0/1       ImagePullBackOff   0          7m

The above output will only show the status, with a vague error. To find the exact error, lets get the stauts of the pod.

Observe the status field.

    kubectl get pod vote -o yaml

Now the status field shows a detailed information, including what the exact error. Observe the following snippet...

    status:
    ...
    containerStatuses:
    ....
    state:
      waiting:
        message: 'rpc error: code = Unknown desc = Error response from daemon: manifest
          for schoolofdevops/vote:latst not found'
        reason: ErrImagePull
    hostIP: 139.59.232.248

This will help you to pinpoint to the exact cause and fix it quickly.

Now that you are done experimenting with pod, delete it with the following command,

    kubectl delete pod vote
     
    kubectl get pods

