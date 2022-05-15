- https://istio.io/latest/docs/reference/config/security/peer_authentication/
- https://github.com/eldadru/ksniff
- https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/
- https://istio.io/latest/docs/reference/config/networking/virtual-service/


<details>
<summary>Auto - mTLS </summary>
<br>

  <img width="947" alt="image" src="https://user-images.githubusercontent.com/75510135/168463626-cdddd551-9403-4ac6-859a-4822b7a77e83.png">

  <img width="961" alt="image" src="https://user-images.githubusercontent.com/75510135/168463601-0255798a-04d8-49f8-a095-ea24b89b2e72.png">
  
  - when default mode of Istio
  <img width="1012" alt="image" src="https://user-images.githubusercontent.com/75510135/168467471-4dc5150b-f8f2-4599-9f31-cd109a0b7a03.png">

  <img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/168467520-b58763f3-a641-4f2a-a73b-a33c057142f4.png">

  ```
  apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: foo
spec:
  mtls:
    mode: PERMISSIVE
---
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: foo
spec:
  selector:
    matchLabels:
      app: finance
  mtls:
    mode: STRICT

  ```

  <img width="897" alt="image" src="https://user-images.githubusercontent.com/75510135/168467624-cfffdca9-8b38-4bb2-9506-483b863593a5.png">

  
</details>

<details>
<summary>Ingress Gateway n Virtual Service</summary>
<br>

  <img width="434" alt="image" src="https://user-images.githubusercontent.com/75510135/168471214-9f76f2e5-181a-416a-9a4e-4c4520fa6b25.png">

  <img width="1233" alt="image" src="https://user-images.githubusercontent.com/75510135/168471802-3fceea3f-ae96-4432-b2fd-86aa9898c90a.png">

  <img width="1247" alt="image" src="https://user-images.githubusercontent.com/75510135/168471818-cc198f9b-efaf-44ec-9f2f-2869edb9ba1d.png">

  <img width="1239" alt="image" src="https://user-images.githubusercontent.com/75510135/168472185-d63cc52e-d9f6-43c6-971f-670bd2514141.png">

  ```
  ############### Add Istio Gateway and Virtual Service ############### 

apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: devsecops-gateway
  namespace: prod
spec:
  selector:
    istio: ingressgateway # use istio default controller
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: devsecops-numeric
  namespace: prod
spec:
  hosts:
  - "*"
  gateways:
  - devsecops-gateway
  http:
  - match:
    - uri:
        prefix: /increment
    - uri:
        exact: /
    route:
    - destination:
        host: devsecops-svc
        port:
          number: 8080

############### Add Istio Gateway and Virtual Service ############### 
  ```
  
  <img width="503" alt="image" src="https://user-images.githubusercontent.com/75510135/168472344-d2e15509-7a59-4165-a53e-7b69ff82dc30.png">

  <img width="766" alt="image" src="https://user-images.githubusercontent.com/75510135/168472358-7dac4a6b-d206-4ad6-a6dd-b487bef55382.png">

  <img width="890" alt="image" src="https://user-images.githubusercontent.com/75510135/168472384-4109939b-2ff3-4e61-bedd-40358b123eed.png">

  <img width="635" alt="image" src="https://user-images.githubusercontent.com/75510135/168472498-3b5b082e-6cdc-4ed7-bc39-6a6c1c9b5dce.png">

  <img width="915" alt="image" src="https://user-images.githubusercontent.com/75510135/168472538-40f559a7-cd4e-487c-8aa5-eac0d2ef3de0.png">

  <img width="729" alt="image" src="https://user-images.githubusercontent.com/75510135/168472611-858f337f-8514-44f6-8fd6-e2df0a78f0b5.png">

  <img width="984" alt="image" src="https://user-images.githubusercontent.com/75510135/168472629-39f73bdc-9ece-4472-af8e-1f6461c48dda.png">

  
</details>

