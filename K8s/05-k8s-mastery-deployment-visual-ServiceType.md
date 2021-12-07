- visual

<img width="635" alt="image" src="https://user-images.githubusercontent.com/75510135/144989421-83e761b1-846e-4354-aa69-d3473781aefd.png">
<img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/144989749-1c848f69-3128-4c34-bfc1-0641eaccfb7d.png">
<img width="727" alt="image" src="https://user-images.githubusercontent.com/75510135/144989777-aad5cb31-65d0-4423-a0c2-52b29f32e518.png">
<img width="726" alt="image" src="https://user-images.githubusercontent.com/75510135/144989903-c335b484-2079-420c-83d3-0b8907f23478.png">
<img width="719" alt="image" src="https://user-images.githubusercontent.com/75510135/144989992-d5ef3736-1b2f-46d3-bfee-c4c8ed78710f.png">
<img width="746" alt="image" src="https://user-images.githubusercontent.com/75510135/144990069-14bc57d0-44b4-4433-8629-0088288d93a5.png">
<img width="748" alt="image" src="https://user-images.githubusercontent.com/75510135/144990217-05cb506c-d23c-4e88-92f3-5bace58a6c1b.png">
<img width="741" alt="image" src="https://user-images.githubusercontent.com/75510135/144990282-22f58e55-0b76-4162-b3e1-3f1ee9fd67a8.png">

- Service Type
<img width="767" alt="image" src="https://user-images.githubusercontent.com/75510135/144990524-7755a20c-34cc-42c0-a89b-bcabb06e7683.png">
<img width="834" alt="image" src="https://user-images.githubusercontent.com/75510135/144990768-971f0560-ac52-4e92-af9d-bc127206931c.png">
<img width="881" alt="image" src="https://user-images.githubusercontent.com/75510135/144991150-d2c90a42-742a-4329-b9e3-5b96e1e668e6.png">
- Exposing PODs with ClusterIP

<img width="846" alt="image" src="https://user-images.githubusercontent.com/75510135/144991528-115447ba-cd32-44a0-9466-d25199f45747.png">
- create deployment
<img width="813" alt="image" src="https://user-images.githubusercontent.com/75510135/144991714-0a47fb9b-d311-4029-9e2c-b7682b1a6f4c.png">
<img width="513" alt="image" src="https://user-images.githubusercontent.com/75510135/144992967-ba8f33bc-4c24-485e-8963-b10122525464.png">
- services are layer4
<img width="752" alt="image" src="https://user-images.githubusercontent.com/75510135/144993326-35893aaa-c4f0-48c3-8d2f-5d36003637ab.png">

```
CoreDNS for Service DNS Resolution

Earlier I talked about CoreDNS being an optional, but necessary thing, inside your Kubernetes cluster. Until now, you wouldn't have needed it, because we haven't used DNS inside the cluster to find Services yet. One of the jobs for a Service resource is to create the DNS name for the Service IP, which then makes something like httpenv resolvable on the Pod networks.

That means that you need to ensure CoreDNS is running before we continue.

If you are using Docker Desktop or minikube, DNS is running out-of-the-box. All done :)

But if you're using MicroK8s, DNS needs to be enabled manually with the command microk8s.enable dns so that it'll setup and start CoreDNS. If you're using MicroK8s you can also see my recommended setup and config slides for it (same from Section 2) here.
```
- Testing service
<img width="824" alt="image" src="https://user-images.githubusercontent.com/75510135/144993640-e28eb230-fe15-4fa1-b89f-05dce4654c3d.png">

- Visuaizing ClusterIP Traffic
<img width="704" alt="image" src="https://user-images.githubusercontent.com/75510135/144996864-ef1fb363-942b-4586-a052-bfcb4b6eab6a.png">

- Headless service
<img width="774" alt="image" src="https://user-images.githubusercontent.com/75510135/144997029-e4e02e25-9ed2-4ac9-9783-4cdf0b761f77.png">

- services and endpoints
<img width="808" alt="image" src="https://user-images.githubusercontent.com/75510135/144997441-16ba8bc5-f3b5-480b-ac69-c1cc6dcd2064.png">

<img width="986" alt="image" src="https://user-images.githubusercontent.com/75510135/144997573-31496f02-c5fe-4000-a21a-71a7d03258f8.png">

<img width="774" alt="image" src="https://user-images.githubusercontent.com/75510135/144997616-b79c6b2e-a2cf-491f-97cc-026308595e19.png">

<img width="741" alt="image" src="https://user-images.githubusercontent.com/75510135/144997774-10f70577-a53d-4f46-848f-0c284ce8498d.png">
<img width="725" alt="image" src="https://user-images.githubusercontent.com/75510135/144997828-e0abe978-fabb-4160-a498-23b769833177.png">
