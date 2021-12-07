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
These questions will either ask for you to enter a kubectl command, other shell commands, or ask for a long-form answer. For each one expecting a command, test your answers, and then use that command as the answer to the assignment question.

The goal here is to practice thinking of kubectl commands to solve your own problems, without resorting to looking at answers. It'll help you get used to the CLI if you force yourself to use the --help as much as possible. The long-form questions are to get you thinking about the "why" of things in Kubernetes, which will deepen your understanding.
Questions for this assignment

Create a deployment called littletomcat using the tomcat image.

What command will help you get the IP address of that Tomcat server?

What steps would you take to ping it from another container?                               

(Use the shpod environment if necessary)

What command would delete the running pod inside that deployment?

What happens if we delete the pod that holds Tomcat, while the ping is running?

What command can give our Tomcat server a stable DNS name and IP address?                                         

(An address that doesn't change when something bad happens to the container)

What commands would you run to curl Tomcat with that DNS address?

(Use the shpod environment if necessary)

If we delete the pod that holds Tomcat, does the IP address still work? How could we test that?
```
