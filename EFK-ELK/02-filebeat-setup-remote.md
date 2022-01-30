- reference
- https://github.com/rupeshpanwar/ansible-1
 <img width="488" alt="image" src="https://user-images.githubusercontent.com/75510135/151702103-a4507eea-c615-4943-adf3-405e6e1572a6.png">


<img width="519" alt="image" src="https://user-images.githubusercontent.com/75510135/151700817-e2dc94bd-fe3a-4b23-aa9b-e22b3c705468.png">
z<img width="518" alt="image" src="https://user-images.githubusercontent.com/75510135/151700839-93814e38-5c08-4ebb-a88d-e7b85176eb2d.png">
installation of filebeat

```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt-get install filebeat
```

<img width="544" alt="image" src="https://user-images.githubusercontent.com/75510135/151700888-7c510b7b-4f4a-4b2b-a49a-5d5e8a425356.png">

<img width="359" alt="image" src="https://user-images.githubusercontent.com/75510135/151701079-9c31400a-fcf4-422a-8a86-e3f002253293.png">


- sudo filebeat modules enable nginx


<img width="691" alt="image" src="https://user-images.githubusercontent.com/75510135/151701162-1af0b9de-0ae0-4688-beed-11aae6253f78.png">

<img width="564" alt="image" src="https://user-images.githubusercontent.com/75510135/151701424-b4231aa8-b254-49c1-bea7-baa6aecf8dd4.png">

- vi /etc/logstash/conf.d/*.conf
<img width="455" alt="image" src="https://user-images.githubusercontent.com/75510135/151701545-2292f432-de8a-41eb-8a27-f14bc2925b8a.png">

<img width="488" alt="image" src="https://user-images.githubusercontent.com/75510135/151701649-57de7201-f8c3-4b4e-94d5-b37ef9718551.png">

<img width="496" alt="image" src="https://user-images.githubusercontent.com/75510135/151702129-aa00542e-080e-46c7-8fbd-811d6e60c7f8.png">

<img width="507" alt="image" src="https://user-images.githubusercontent.com/75510135/151702146-b95bf54f-ccc7-4c40-83a2-41f66c85410c.png">

<img width="722" alt="image" src="https://user-images.githubusercontent.com/75510135/151702242-bad2a5fc-f5f0-4643-bc1f-53de9ead1376.png">

<img width="689" alt="image" src="https://user-images.githubusercontent.com/75510135/151702438-fdea18c8-e13b-4291-896f-ecafc7824f35.png">

- https://www.youtube.com/watch?v=TaW5JFKLeeg
- https://gitlab.com/xavki/devopsland/-/blob/master/elk/05-example-filebeat-logstash/slides.md
