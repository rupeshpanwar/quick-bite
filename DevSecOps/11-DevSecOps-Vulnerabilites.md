-  https://jeremylong.github.io/DependencyCheck/dependency-check-maven/
-  https://github.com/spring-projects/spring-boot

**Steps**
<details>
<summary>1. Introduction</summary>
<br>

  <img width="1024" alt="image" src="https://user-images.githubusercontent.com/75510135/154805804-bd1a57d3-f68f-4aa4-af73-21475bca5f46.png">
  
  <img width="1000" alt="image" src="https://user-images.githubusercontent.com/75510135/154805911-3a5e2044-e513-4650-888b-d45c450e16ef.png">

  <img width="945" alt="image" src="https://user-images.githubusercontent.com/75510135/154805949-e12792c5-10f7-42f4-856b-940b3b921ed4.png">
    
</details>


<details>
<summary>2. Dependency Checks </summary>
<br>
 
1. @Jenkins , Install OWASP Dependency-check plugin
2. @POM , Add plugin code
3. @Jenkinsfile, add a stage for check
  
<img width="893" alt="image" src="https://user-images.githubusercontent.com/75510135/154806474-97bd4833-e720-402e-bee1-6d68fdd3152b.png">
  
 ## 1. @Jenkins , Install OWASP Dependency-check plugin
  
<img width="937" alt="image" src="https://user-images.githubusercontent.com/75510135/154806723-b0f35245-8ecf-4f40-9119-61f064f79374.png">

 ## 2. @POM , Add plugin code
  
 ```
  <!--                   Dependency Check Plugin                   -->
<plugin>
   <groupId>org.owasp</groupId>
   <artifactId>dependency-check-maven</artifactId>
   <version>6.1.6</version>
   <configuration>
      <format>ALL</format>
      <failBuildOnCVSS>8</failBuildOnCVSS>
      <!-- fail the build for CVSS greater than or equal to 5 -->
      <!-- 
			      use internal mirroring of CVE contents 
			      Suppress files 
			      E.g. a company-wide suppression file and local project file 
			     -->
      <!-- 
			     <cveUrlModified>http://internal-mirror.mycorp.com/nvdcve-1.1-modified.json.gz</cveUrlModified>  
			                    <cveUrlBase>http://internal-mirror.mycorp.com/nvdcve-1.1-%d.json.gz</cveUrlBase>
			     <suppressionFiles>               
			                        <suppressionFile>http://example.org/suppression.xml</suppressionFile>
			                        <suppressionFile>project-suppression.xml</suppressionFile> 
			                    </suppressionFiles> 
			                 -->
   </configuration>
</plugin>
  ```
  
 ## 3. @Jenkinsfile, add a stage for check
 ```
      stage('Vulnerability Scan - Docker ') {
      steps {
        sh "mvn dependency-check:check"
      }
      post {
        always {
          dependencyCheckPublisher pattern: 'target/dependency-check-report.xml'
        }
      }
    }
  ```
  
</details>

<details>
<summary>3. Check Dependency Result & fix</summary>
<br>
 
  
  <img width="1095" alt="image" src="https://user-images.githubusercontent.com/75510135/154807376-85692b71-5221-469b-95eb-9a9d09068c69.png">
  
  - click on report for Vuln
  
  <img width="1109" alt="image" src="https://user-images.githubusercontent.com/75510135/154807446-2d4e4213-ef4f-476b-8ecc-2a3b8661f367.png">

  - Check for each CVE in search engine for details
  
  <img width="648" alt="image" src="https://user-images.githubusercontent.com/75510135/154807470-808c10c5-935b-4cfd-a12e-a316ac617a0b.png">

  
  - look for the stable release version and update in POM
  - https://github.com/spring-projects/spring-boot
  
  <img width="947" alt="image" src="https://user-images.githubusercontent.com/75510135/154807549-5f569246-28f3-41c3-a839-3c32cfdb5111.png">

  <img width="1096" alt="image" src="https://user-images.githubusercontent.com/75510135/154808096-bf3f114e-e609-4c11-9270-c1bc0aae7400.png">

  
</details>


