- https://www.zaproxy.org/docs/docker/api-scan/



<details>
<summary>Introduction</summary>
<br>

  
  ![image](https://user-images.githubusercontent.com/75510135/155338584-5055b8a5-1d18-4bc2-ba7a-7c0fb478bbec.png)

  ![image](https://user-images.githubusercontent.com/75510135/155339143-cde7ddf4-e2d9-476f-aac9-f0954b437981.png)

  ![image](https://user-images.githubusercontent.com/75510135/155339609-3329575d-8380-4ad3-9acc-7a39969f30ac.png)

  ![image](https://user-images.githubusercontent.com/75510135/155340076-d6dc4418-0483-4b7e-8bb6-4bb891b8776d.png)

</details>


<details>
<summary>Adding springdoc-openapi-ui dependency in pom.xml</summary>
<br>

```
 <dependency>
     <groupId>org.springdoc</groupId>
   <artifactId>springdoc-openapi-ui</artifactId>
   <version>1.2.30</version>
</dependency>
```
  
 - run below command @ project root directory
  
```
mvn clean package
cd  target
java -jar xxxxx.jar
```
  
</details>


<details>
<summary>Validate</summary>
<br>

  - http://localhost:8080/v3/api-docs
  - http://localhost:8080/swagger-ui.html
  - Jason formatter - jasonviewer.stack.hu
  
</details>




<details>
<summary>@Jenkinsfile, add new stage</summary>
<br>

```
   stage('OWASP ZAP - DAST') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig']) {
          sh 'bash zap.sh'
        }
      }
    }
 ```
  
 - Create  zap.sh @ project root dir
  
```
 
#!/bin/bash

PORT=$(kubectl -n default get svc ${serviceName} -o json | jq .spec.ports[].nodePort)

# first run this
chmod 777 $(pwd)
echo $(id -u):$(id -g)
docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $applicationURL:$PORT/v3/api-docs -f openapi -r zap_report.html

exit_code=$?

# comment above cmd and uncomment below lines to run with CUSTOM RULES
# docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $applicationURL:$PORT/v3/api-docs -f openapi -c zap-rules -w report.md -J json_report.json -r zap_report.html

# HTML Report
 sudo mkdir -p owasp-zap-report
 sudo mv zap_report.html owasp-zap-report


echo "Exit Code : $exit_code"

 if [[ ${exit_code} -ne 0 ]];  then
    echo "OWASP ZAP Report has either Low/Medium/High Risk. Please check the HTML Report"
    exit 1;
   else
    echo "OWASP ZAP did not report any Risk"
 fi;
```
  
 - publish the report

 ```
  publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'owasp-zap-report', reportFiles: 'zap_report.html', reportName: 'OWASP ZAP HTML Report', reportTitles: 'OWASP ZAP HTML Report'])
 
 ```
  
  
</details>


<details>
<summary>Validate n Fix</summary>
<br>

 ![image](https://user-images.githubusercontent.com/75510135/155824932-01792447-7c66-4d75-bdf6-417a26670f12.png)

 ![image](https://user-images.githubusercontent.com/75510135/155824946-17b51694-63c6-4da2-9fde-ec9406b9cc24.png)

 ![image](https://user-images.githubusercontent.com/75510135/155824956-866466a8-354e-4c7c-a50f-d84525d85793.png)

  
  
</details>




