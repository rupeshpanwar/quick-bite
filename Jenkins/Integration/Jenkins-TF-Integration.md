<img width="413" alt="image" src="https://user-images.githubusercontent.com/75510135/145770509-1bc45279-a87b-41d7-b5e5-86e9006babab.png">

<img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/145764977-63f5d05b-eae9-49e9-a428-1118e1ad5c7f.png">
<img width="903" alt="image" src="https://user-images.githubusercontent.com/75510135/145765014-2105cf1b-f821-43f6-b7ff-78edec6a0079.png">
<img width="904" alt="image" src="https://user-images.githubusercontent.com/75510135/145765123-60c1e894-585f-4519-b949-cc891f9ccfcb.png">
<img width="616" alt="image" src="https://user-images.githubusercontent.com/75510135/145766032-864dcd86-dcf3-4979-bdb6-5ad8b8e90d9f.png">
<img width="726" alt="image" src="https://user-images.githubusercontent.com/75510135/145766109-5e153e38-b1d9-4019-822e-b1760a7d11f2.png">
<img width="703" alt="image" src="https://user-images.githubusercontent.com/75510135/145766130-28f858f6-e339-46c4-8bfe-7e37df7388e7.png">
<img width="545" alt="image" src="https://user-images.githubusercontent.com/75510135/145766346-9ccaf6cf-a6c0-4acc-bd8b-c199b9ad2334.png">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/75510135/145767084-c98bac5e-22b1-4275-9722-6ec1ad3f280f.png">
<img width="382" alt="image" src="https://user-images.githubusercontent.com/75510135/145767138-99e088fd-2ea4-4f0e-b5d3-2ba996338abf.png">
<img width="745" alt="image" src="https://user-images.githubusercontent.com/75510135/145767270-cf0805e1-379a-4f36-b048-7c784709f307.png">
- install git on jenkins machine

<img width="366" alt="image" src="https://user-images.githubusercontent.com/75510135/145767324-c88f8616-6e03-4b71-bb3c-864a7683d430.png">
<img width="879" alt="image" src="https://user-images.githubusercontent.com/75510135/145767454-dc25247f-5083-4f93-95a1-1dd394a75a64.png">
<img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/145767413-81638d8c-93ee-4d29-8ff8-fb73b5abaab4.png">
- use pipeline syntx generator
<img width="250" alt="image" src="https://user-images.githubusercontent.com/75510135/145767522-fdd3b979-d689-4124-82bb-d4b0e046429e.png">
- include Terraform tool
<img width="925" alt="image" src="https://user-images.githubusercontent.com/75510135/145767615-0a0bc4d0-22b5-47a9-97b6-695701c62f40.png">

- create an env var path 
<img width="939" alt="image" src="https://user-images.githubusercontent.com/75510135/145767819-37859344-c6d8-46fd-a235-f32e0b53bae4.png">

<img width="931" alt="image" src="https://user-images.githubusercontent.com/75510135/145767919-6e04d347-3b30-45ed-a93a-614248e8d5d0.png">
- set AWS credentials in Jenkins for TF to create infra
<img width="777" alt="image" src="https://user-images.githubusercontent.com/75510135/145768091-105519b3-a8d2-417e-889f-f67099a45981.png">
- create a role for EC2 instance
<img width="386" alt="image" src="https://user-images.githubusercontent.com/75510135/145768583-da28bccc-666b-4fa3-a81c-eed0ba2d6d59.png">
<img width="661" alt="image" src="https://user-images.githubusercontent.com/75510135/145768672-31639c4d-e9c6-44c4-9d05-3f239b1b999c.png">
- attach the role
<img width="409" alt="image" src="https://user-images.githubusercontent.com/75510135/145768736-cb3f6364-ea05-4724-8c4a-cdf793daa9a4.png">
<img width="763" alt="image" src="https://user-images.githubusercontent.com/75510135/145768799-5046f21a-a44d-4cf4-9f03-e893ce04133b.png">
- now to execute the decision between dev/prod , include the shell script
<img width="926" alt="image" src="https://user-images.githubusercontent.com/75510135/145769108-10d126ab-8156-4abf-a811-ba5a248156fd.png">

<img width="789" alt="image" src="https://user-images.githubusercontent.com/75510135/145769189-5f04f955-f6bb-4851-a7a1-58cbe48af252.png">
<img width="938" alt="image" src="https://user-images.githubusercontent.com/75510135/145769287-e8f59ca7-fd79-450b-b57d-a6a999ec9d4a.png">
<img width="871" alt="image" src="https://user-images.githubusercontent.com/75510135/145769504-c6b45b3d-37a0-440c-9f28-de1ad94757d7.png">
<img width="882" alt="image" src="https://user-images.githubusercontent.com/75510135/145769616-cd931fa1-7b7e-4b57-ac46-6371eb53848d.png">

<img width="949" alt="image" src="https://user-images.githubusercontent.com/75510135/145769641-907a2a32-9cd3-46e2-8a5b-1e9e4390762c.png">

<img width="928" alt="image" src="https://user-images.githubusercontent.com/75510135/145769728-a36b9236-f7b5-4420-8354-831f02ffa825.png">

- CReate S3 bucket using aws cli in Jenkinsfile
<img width="957" alt="image" src="https://user-images.githubusercontent.com/75510135/145770046-69f97c3a-8f83-44d8-abe8-e6c00a44d937.png">

<img width="783" alt="image" src="https://user-images.githubusercontent.com/75510135/145770155-ab4a2b8b-c912-4389-b3be-e8d0959a53c4.png">

- add a new stage in the jenkinsfile
<img width="801" alt="image" src="https://user-images.githubusercontent.com/75510135/145770270-9c5ead9c-4511-4e4a-8ca9-f20ac9246f96.png">

<img width="754" alt="image" src="https://user-images.githubusercontent.com/75510135/145770314-1bb6355c-1c9f-45f0-9386-18a09e087f0a.png">

<img width="895" alt="image" src="https://user-images.githubusercontent.com/75510135/145770449-aa1f7258-a622-4e94-96a5-6d2017c0d8ec.png">

- Auto - commit the changes
<img width="413" alt="image" src="https://user-images.githubusercontent.com/75510135/145770492-df5313bf-3793-499e-9e08-57edf49e95ba.png">

- create webhook for auto-trigger
<img width="857" alt="image" src="https://user-images.githubusercontent.com/75510135/145772558-f43a6856-fce0-423d-bfdb-7903a63cc7fa.png">
<img width="843" alt="image" src="https://user-images.githubusercontent.com/75510135/145772703-ae6462d8-0c26-4ffe-8a10-d6f6f582a5c1.png">
- configure the pipeline for polling
<img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/145772775-6df7ffb7-f381-4d1e-b27f-e4cbcb663263.png">





