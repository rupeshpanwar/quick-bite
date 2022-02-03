**Update Unix Machine Package Manager**

sudo apt-get update

sudo apt-get upgrade -y


**Install JAVA on Machine:**

sudo apt-get install default-jre -y

java -version

**Elasticsearch Installation**

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list



**Install ES:**

sudo apt-get update

sudo apt-get install elasticsearch -y



**Update ES Network Config:**

sudo vim /etc/elasticsearch/elasticsearch.yml

```
_network.host: "localhost"
http.port:9200_
```

**Start EC Service:**

sudo service elasticsearch start



**Verify ES Service Status:**

sudo curl http://localhost:9200



**Logstash Installation**

sudo apt-get install logstash



**Installing Kibana**

sudo apt-get install kibana



**Update Kibana Network Setting:**

vim /etc/kibana/kibana.yml

```
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://localhost:9200"]
```

**Start Kibana Service:**

sudo service kibana start

**Access Kibana**
take public ip of the the machine => ifconfig => look for ip under eth0 section

then in the browser, type below
```
    public-ip:5601
```

**Installing Beats**

sudo apt-get install metricbeat

sudo service metricbeat start



**Shipping some data:**

sudo vim /etc/logstash/conf.d/apache-01.conf


```
input {
file {
path => "/home/ubuntu/apache-daily-access.log"
start_position => "beginning"
sincedb_path => "/dev/null"
}
}

filter {
grok {
match => { "message" => "%{COMBINEDAPACHELOG}" }
}

date {
match => [ "timestamp" , "dd/MMM/yyyy:HH:mm:ss Z" ]
}

geoip {
source => "clientip"
}
}

output {
elasticsearch {
hosts => ["localhost:9200"]
}
}
```

**Start LogStash Service:**

sudo service logstash start 


********************************************

**setup ElasticSearch**
- path.logs: /var/log/elasticsearch
<img width="383" alt="image" src="https://user-images.githubusercontent.com/75510135/152296185-70e9b2a3-5e60-439a-b7a2-01a8da113bb0.png">

**Kibana logs**
<img width="275" alt="image" src="https://user-images.githubusercontent.com/75510135/152296860-c3fc15ef-8423-439d-8436-4de9548acfcd.png">

<img width="349" alt="image" src="https://user-images.githubusercontent.com/75510135/152297955-05ba7ed6-76ee-49d8-985d-69e7ad3c29bb.png">
**filebeat**
<img width="314" alt="image" src="https://user-images.githubusercontent.com/75510135/152298633-2b12fbc4-d00d-4dc6-bc04-d3dfe38caaf6.png">


<img width="401" alt="image" src="https://user-images.githubusercontent.com/75510135/152298934-e42db084-b2c6-4ea1-8699-2844f01f3c0e.png">

<img width="369" alt="image" src="https://user-images.githubusercontent.com/75510135/152299391-cc98fb4e-3ab2-406d-a3e9-d8ddaf32a44b.png">

<img width="406" alt="image" src="https://user-images.githubusercontent.com/75510135/152299684-89202271-2773-41b5-bd04-1293e67489d6.png">

<img width="403" alt="image" src="https://user-images.githubusercontent.com/75510135/152299838-750645cf-47f0-4064-a08f-c7efca44de9f.png">

<img width="408" alt="image" src="https://user-images.githubusercontent.com/75510135/152301443-dba33314-4778-46b1-8862-f5ab250c235a.png">

<img width="313" alt="image" src="https://user-images.githubusercontent.com/75510135/152301537-59ac5e6c-a4ac-4860-93ff-5d1a893891a6.png">

- https://www.youtube.com/watch?v=Ul2Rt9mn_ds
<img width="267" alt="image" src="https://user-images.githubusercontent.com/75510135/152302384-f71fa9a1-b7ac-4c45-b7cf-d29bbd2f891b.png">

- https://gitlab.com/LabIT/elasticsearch/-/blob/master/elk_manual_configuration/beats/filebeat/filebeat-elk.md
