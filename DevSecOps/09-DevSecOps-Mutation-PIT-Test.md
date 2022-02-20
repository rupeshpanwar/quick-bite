- https://pitest.org/quickstart/maven/


**Steps**

<details>
<summary>Introduction</summary>
<br>

 

![image](https://user-images.githubusercontent.com/75510135/154794372-f36a5876-5373-4b4e-b07e-f67d4665d1da.png)
   
![image](https://user-images.githubusercontent.com/75510135/154794659-0963b86f-7641-4447-a745-5a141fc6ce48.png)


</details>

<details>
<summary>1. Add PIT Mutation Plugin in POM file</summary>
<br>

   
![image](https://user-images.githubusercontent.com/75510135/154795822-2f336a01-a517-4de5-ba64-7d6df18f1368.png)

 
 
```
<!--                   PITest Mutation Plugin                   -->
<plugin>
   <groupId>org.pitest</groupId>
   <artifactId>pitest-maven</artifactId>
   <version>1.5.0</version>
   <dependencies>
      <dependency>
         <groupId>org.pitest</groupId>
         <artifactId>pitest-junit5-plugin</artifactId>
         <version>0.12</version>
      </dependency>
   </dependencies>
   <configuration>
      <mutationThreshold>70</mutationThreshold>
      <outputFormats>
         <outputFormat>XML</outputFormat>
         <outputFormat>HTML</outputFormat>
      </outputFormats>
   </configuration>
</plugin>
```

</details>


<details>
<summary>2. Add Stage in Jenkinsfile(post Jococo test)</summary>
<br>


 ```
      stage('Mutation Tests - PIT') {
          steps {
              sh "mvn org.pitest:pitest-maven:mutationCoverage"
            }
            post {
              always {
                pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
              }
          }
      }   // stage ending PIT mutations test
``` 

</details>


<details>
<summary>3. PIT Mutation Report</summary>
<br>


**Note , more mutation is killed , more it success**

![image](https://user-images.githubusercontent.com/75510135/154796005-3fe0db94-fea4-41d3-808a-b00b44e77482.png)

![image](https://user-images.githubusercontent.com/75510135/154796066-5b41a9b2-3654-47d0-a8e7-cb2354d46afe.png)

![image](https://user-images.githubusercontent.com/75510135/154796074-1df10d5e-cc50-4200-818b-d04619c8eb47.png)

![image](https://user-images.githubusercontent.com/75510135/154796086-5e7f5ad2-640d-49a0-9552-70cf2b9e1585.png)


![image](https://user-images.githubusercontent.com/75510135/154796107-4e30f191-c732-4d50-8dd1-40244ce0506c.png)


- what mutator does
![image](https://user-images.githubusercontent.com/75510135/154794850-97cd3e71-072c-48e6-8a18-05ceae968e4c.png)
![image](https://user-images.githubusercontent.com/75510135/154794882-108fabdb-7dde-4147-bff4-1d4d485b274b.png)

# Why Mutation test survived

![image](https://user-images.githubusercontent.com/75510135/154795048-a6245d64-be0e-4c59-89d9-6392fd1f653a.png)


## make little change in test code

```
NumericApplicationTests.java , change the code to
@Test
    public void welcomeMessage() throws Exception {
        this.mockMvc.perform(get("/")).andDo(print()).andExpect(status().isOk())
                .andExpect(content().string("Kubernetes DevSecOps"));
    }
```

![image](https://user-images.githubusercontent.com/75510135/154796309-a165dac2-d154-4a62-89c8-3492cda127d9.png)

<img width="784" alt="image" src="https://user-images.githubusercontent.com/75510135/154796331-bd85df74-b297-4056-abc7-819d95f20436.png">

![image](https://user-images.githubusercontent.com/75510135/154796361-c0c68842-fc27-4520-8ded-0089b5e7dced.png)


   
</details>
