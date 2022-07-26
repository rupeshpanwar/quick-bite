- https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-reset-jenkins-admin-users-password/
- https://www.jenkins.io/blog/2016/11/21/gc-tuning/


<details>
<summary>Reference links</summary>
<br>
  [the_support_bundle.pdf](https://github.com/rupeshpanwar/quick-bite/files/9112387/the_support_bundle.pdf)

  
    - https://support.cloudbees.com/hc/en-us/articles/222446987-Prepare-Jenkins-for-Support
    - https://www.cloudbees.com/blog/enterprise-jvm-administration-and-jenkins-performance
    - https://docs.cloudbees.com/docs/admin-resources/latest/jvm-troubleshooting/
    - https://support.cloudbees.com/hc/en-us/articles/230922208-Pipeline-Best-Practices
    - https://wiki.jenkins.io/display/JENKINS/Active+Directory+plugin
    - https://go.cloudbees.com - CloudBees Support Knowledge Base
    - https://gceasy.io - Online analysis of Java GC logs
    - https://fastthread.io - Online analysis of Java thread dumps
    - https://tinyurl.com/jenkins-jvm-args - Recommended JVM settings for Jenkins
    - https://tinyurl.com/jenkins-thread-dump - How to get a thread dump from Jenkins
    - https://www.cloudbees.com/blog/enterprise-jvm-administration-and-jenkins-performance
  
  Jenkins Health Advisor by CloudBees
https://docs.cloudbees.com/docs/admin-resources/latest/plugins/cloudbees-jenkins-advisor

🗞️ Jenkins Health Advisor by CloudBees
https://plugins.jenkins.io/cloudbees-jenkins-advisor/

🗞️ Support Core
https://plugins.jenkins.io/support-core/

🗞️ Generating a support bundle
https://docs.cloudbees.com/docs/admin-resources/latest/support-bundle/

🗞️ Prepare Jenkins for Support
https://support.cloudbees.com/hc/en-us/articles/222446987-Prepare-Jenkins-for-support

🗞️ Which URLs would I need to grant access to for my firewall or proxy?
https://support.cloudbees.com/hc/en-us/articles/360028853171-Which-URLs-would-I-need-to-grant-access-to-for-my-firewall-or-proxy-

🗞️ My friend, the support bundle
https://speakerdeck.com/aheritier/my-friend-the-support-bundle

✅ Arnaud on Twitter:
https://twitter.com/aheritier


</details>



<details>
<summary>Introduction</summary>
<br>

  <img width="724" alt="image" src="https://user-images.githubusercontent.com/75510135/169627828-f1366650-0ceb-4659-82de-c2129a6c76ce.png">
  
  <img width="748" alt="image" src="https://user-images.githubusercontent.com/75510135/169627639-6ca2bc9e-198c-4c20-a0c2-716d5903fbd0.png">

  <img width="732" alt="image" src="https://user-images.githubusercontent.com/75510135/169627763-111184cb-8b51-495a-bbc0-c0e149e2cf2f.png">

  
</details>

<details>
<summary>Macro vs Micro Matrics</summary>
<br>

  <img width="720" alt="image" src="https://user-images.githubusercontent.com/75510135/169627878-bcfa51af-8e32-43b3-99cc-dc1b2722d02d.png">

  <img width="611" alt="image" src="https://user-images.githubusercontent.com/75510135/169627903-fd4f2019-94f8-4ad6-a7b9-7c9b66717f53.png">

  <img width="720" alt="image" src="https://user-images.githubusercontent.com/75510135/169627925-d60a6847-e5fd-4501-b98f-40dcb488e222.png">

  <img width="684" alt="image" src="https://user-images.githubusercontent.com/75510135/169627982-337b2c02-f6d1-487e-bfc2-b240b282d041.png">

  <img width="697" alt="image" src="https://user-images.githubusercontent.com/75510135/169628024-7bcc09a3-ed85-4185-9431-9fac1c862015.png">

  
</details>

<details>
<summary>Challenges</summary>
<br>

  <img width="780" alt="image" src="https://user-images.githubusercontent.com/75510135/169628066-2385b1f3-d706-41f5-9029-e780a5183e63.png">

  <img width="677" alt="image" src="https://user-images.githubusercontent.com/75510135/169628271-2f5533cf-3717-4e94-96d4-229449e23220.png">

  <img width="652" alt="image" src="https://user-images.githubusercontent.com/75510135/169628332-a2767381-1d6e-4692-954d-de995fc9252a.png">

  <img width="696" alt="image" src="https://user-images.githubusercontent.com/75510135/169628346-a28ee590-e948-4a11-95d0-3265e3020ec9.png">

  <img width="691" alt="image" src="https://user-images.githubusercontent.com/75510135/169628356-1941a18f-0fdf-4226-992e-9f3ab4d38d1f.png">

  <img width="684" alt="image" src="https://user-images.githubusercontent.com/75510135/169628363-b8538112-4d06-4d56-9af4-7052810f44bb.png">

  <img width="571" alt="image" src="https://user-images.githubusercontent.com/75510135/169628377-c1cb60fd-3779-4035-958d-e90a4c329295.png">

  <img width="630" alt="image" src="https://user-images.githubusercontent.com/75510135/169628385-b55d14fb-a483-4512-b7fc-a3d651254b59.png">

  <img width="755" alt="image" src="https://user-images.githubusercontent.com/75510135/169628396-f96c8d4f-2516-42a3-815b-58d4e67a1171.png">

  <img width="657" alt="image" src="https://user-images.githubusercontent.com/75510135/169628401-afd11c9f-c803-4081-b565-8e752da8452c.png">

  <img width="644" alt="image" src="https://user-images.githubusercontent.com/75510135/169628409-f2288404-b256-432f-9b64-b614f24caf92.png">

  <img width="721" alt="image" src="https://user-images.githubusercontent.com/75510135/169628418-3e649e50-333d-4b25-8a99-8624dc25b759.png">

  <img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/169628435-f5c27f5b-5fea-40c8-aaf6-7e22eec0c7b6.png">

  <img width="681" alt="image" src="https://user-images.githubusercontent.com/75510135/169628461-7931b297-5d64-4d86-a221-3fa020c89600.png">

  <img width="734" alt="image" src="https://user-images.githubusercontent.com/75510135/169628466-6473755f-dff8-49e8-9581-2f356c8d86ec.png">

  <img width="783" alt="image" src="https://user-images.githubusercontent.com/75510135/169628593-390bd9e6-3070-4cd6-aabd-e525697bd35b.png">

  
</details>

<details>
<summary>Real world example</summary>
<br>

  <img width="739" alt="image" src="https://user-images.githubusercontent.com/75510135/169628624-809091df-75a4-4aaa-88b2-f4eeb1af8489.png">

  <img width="751" alt="image" src="https://user-images.githubusercontent.com/75510135/169628634-19e178a6-b59b-4606-840d-0e6b0b2635b4.png">

  <img width="717" alt="image" src="https://user-images.githubusercontent.com/75510135/169628646-1d262fd1-7662-4201-8889-25427b5dca7e.png">

  <img width="746" alt="image" src="https://user-images.githubusercontent.com/75510135/169628658-bf92ffdb-f282-4375-8a40-f8dcdfe95825.png">

  <img width="768" alt="image" src="https://user-images.githubusercontent.com/75510135/169628669-b07c240d-2096-445d-9641-fe01fdfecb3b.png">

  <img width="786" alt="image" src="https://user-images.githubusercontent.com/75510135/169628687-d4890eab-9a94-4136-80a3-47bcb90f8b5a.png">

  <img width="703" alt="image" src="https://user-images.githubusercontent.com/75510135/169628704-cd187d30-d00d-4081-8beb-310d06a2eb11.png">

  <img width="592" alt="image" src="https://user-images.githubusercontent.com/75510135/169628719-a494a8c7-14b7-4ca5-9b26-22dcd1d622a2.png">

  
</details>

<details>
<summary>Performance & Health tools</summary>
<br>
  
  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178955969-37cc5b39-a873-46aa-a414-363c43ec0c3f.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178957043-418e607c-d9e5-49e8-873e-12f7a9941d4b.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178959953-93b55fe6-cc12-4ecb-8ddd-714d18216017.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178960075-285f501b-4ea6-4f59-9409-876d3aefedee.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178960605-d68b54df-7c55-4fb7-85c1-4eac83ca7d4f.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178961610-38f89eef-6cb6-4943-8685-2631d08602bd.png">

  - generate n download bundle
  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178981423-57a14e8e-126e-4cba-a5f7-0234ce0820e3.png">

  - performance warning
  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178983660-342c552e-7e40-4942-ba2e-0e2c1cfdcbc2.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178983728-55e34c7c-3499-48be-b628-cf5630c4acb8.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178983810-a437be4f-baf7-4259-b03f-1aea14cf6708.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178983927-8a5330b0-5425-48a3-8eb9-e29d21a06c3e.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178984801-5ad82038-80aa-41c0-9cf9-f9b764cb6e4b.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178988477-18136713-79ae-4d0a-a3e8-c8ab601be70c.png">

  <img width="769" alt="image" src="https://user-images.githubusercontent.com/75510135/178988432-99e03bfb-c79f-4bf5-ab31-a8eaa60527c7.png">

  
</details> 


<details>
<summary>Backup - Performance - Best Practices</summary>
<br>
  
  https://www.youtube.com/watch?v=9-DUVroz7yk
  
  ![image](https://user-images.githubusercontent.com/75510135/179143224-aee9f6bd-86af-48ae-866d-8c268eb8058f.png)

  ![image](https://user-images.githubusercontent.com/75510135/179149519-75e54f48-c7d1-4c72-880b-874ec88a1009.png)

  ![image](https://user-images.githubusercontent.com/75510135/179168975-a9df887d-67d7-4d7b-a8bc-96f132af4207.png)

  ![image](https://user-images.githubusercontent.com/75510135/179169977-14a2394d-45e7-47bb-b1bd-9209fef06cc2.png)

  ![image](https://user-images.githubusercontent.com/75510135/179170103-9eeb0504-6062-4684-b139-bfc8a460af78.png)

  ![image](https://user-images.githubusercontent.com/75510135/179170203-bc6bea0d-dc67-4201-bdac-38c20ab97a54.png)

  ![image](https://user-images.githubusercontent.com/75510135/179170338-c6718274-ef42-4352-a592-11dc7fa5fa9b.png)

  ![image](https://user-images.githubusercontent.com/75510135/179170558-6fcce3a7-9700-4fe1-972f-51de5af4d27f.png)

  ![image](https://user-images.githubusercontent.com/75510135/179170615-46232fad-63e6-4421-8afc-335871c9c925.png)

  ![image](https://user-images.githubusercontent.com/75510135/179170923-d792c030-d53d-4e82-854d-abd741e806fc.png)

  ![image](https://user-images.githubusercontent.com/75510135/179171000-04355cb4-1880-4a34-968b-a5a5f52decaf.png)

  ![image](https://user-images.githubusercontent.com/75510135/179171367-af27d034-a030-4ab9-94f8-604ad3ccc3d6.png)

  ![image](https://user-images.githubusercontent.com/75510135/179171498-b93cc95f-b4f3-4c2d-b7a4-2016089269a6.png)

  ![image](https://user-images.githubusercontent.com/75510135/179171532-0676ee5c-f8a4-4425-bb56-cd9f4cd96a7f.png)

  - challenge with admin
  ![image](https://user-images.githubusercontent.com/75510135/179172283-aa8788d2-7683-457b-b0e7-142f40ad4149.png)

  ![image](https://user-images.githubusercontent.com/75510135/179172567-ba7db2de-1945-4b4c-8fdd-bea7ccc1c0a9.png)

  - https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/client-and-managed-masters/how-to-add-java-arguments-to-jenkins
  
  ![image](https://user-images.githubusercontent.com/75510135/179173307-55117472-29e6-4ef8-89d6-3cfa68beff1d.png)

  ![image](https://user-images.githubusercontent.com/75510135/179173697-71c05e0e-95d1-4da4-ba2c-52eefebd4c74.png)

  - countdown
  ![image](https://user-images.githubusercontent.com/75510135/179173832-e5672350-61b0-4b25-bac2-674a19c46d53.png)

  ![image](https://user-images.githubusercontent.com/75510135/179174181-a90e158b-cdc8-4a5e-b6ad-edd292361049.png)

  - https://plugins.jenkins.io/jobConfigHistory/
  
  - backup
  ![image](https://user-images.githubusercontent.com/75510135/179175063-c9397dca-0db7-4b47-9a24-c9e12caa6105.png)

  ![image](https://user-images.githubusercontent.com/75510135/179175332-12f5d3ed-59d8-495a-b8af-1efb081c1f17.png)

  - https://www.cloudbees.com/blog/enterprise-jvm-administration-and-jenkins-performance
 
  ![image](https://user-images.githubusercontent.com/75510135/179178910-47fdd6b2-1a24-4133-b77f-9439bf562a82.png)

  - real world data
  ![image](https://user-images.githubusercontent.com/75510135/179179811-e2add4c4-ff68-433c-86a2-512f934d6359.png)

  
  ![image](https://user-images.githubusercontent.com/75510135/179202234-c62ca630-5739-49f0-bb19-015fc213a8b4.png)

  
</details> 


<details>
<summary>GC Tuning & Troubleshooting</summary>
<br>
  
  <img width="685" alt="image" src="https://user-images.githubusercontent.com/75510135/180238400-e00a2ffe-b65f-44f5-a59a-8afe4f2a4ed8.png">

  <img width="677" alt="image" src="https://user-images.githubusercontent.com/75510135/180238540-0c661f63-90fa-4e67-bc59-32b60c796d33.png">

  <img width="682" alt="image" src="https://user-images.githubusercontent.com/75510135/180239699-8a27cd44-dd19-45f9-8ea2-c151675b9675.png">

  <img width="679" alt="image" src="https://user-images.githubusercontent.com/75510135/180239820-c52c74ce-c550-449b-a4fd-d4098b0eac8b.png">

  <img width="635" alt="image" src="https://user-images.githubusercontent.com/75510135/180241278-86bf97ac-9b03-4bc3-943b-e4258873b352.png">

  <img width="616" alt="image" src="https://user-images.githubusercontent.com/75510135/180241547-ef96a6d6-c72d-4d45-980e-a562369ffa76.png">

  <img width="670" alt="image" src="https://user-images.githubusercontent.com/75510135/180242090-19ce234c-bcbb-40c5-9e9f-8c61be3d9c34.png">

  <img width="662" alt="image" src="https://user-images.githubusercontent.com/75510135/180242167-2ec7b3c4-cdc7-4740-8e71-f3aa8183a69e.png">

  <img width="575" alt="image" src="https://user-images.githubusercontent.com/75510135/180242445-b8b6f429-4b76-475d-b75f-d61334835e55.png">

  <img width="690" alt="image" src="https://user-images.githubusercontent.com/75510135/180243065-8a309727-0ba5-4165-8b91-a50d40a7a28f.png">

  <img width="606" alt="image" src="https://user-images.githubusercontent.com/75510135/180243160-cb6322d4-3b9d-44d0-9c80-c7f353827835.png">

  <img width="572" alt="image" src="https://user-images.githubusercontent.com/75510135/180243471-de8bc32a-14b1-438f-9c95-a5bf7a28a6ef.png">

  <img width="577" alt="image" src="https://user-images.githubusercontent.com/75510135/180244334-a144785d-b8a9-41de-9f7d-24c455a52ff9.png">

  <img width="667" alt="image" src="https://user-images.githubusercontent.com/75510135/180244522-44a5f19a-25bc-48ce-8f3a-b2950a21528c.png">

  
  <img width="669" alt="image" src="https://user-images.githubusercontent.com/75510135/180245081-0510fba1-5d78-42b8-861d-9ba3414f40dd.png">

  <img width="608" alt="image" src="https://user-images.githubusercontent.com/75510135/180245181-f6daa1c9-d058-4ad7-92b4-8dcca50244c8.png">

  <img width="597" alt="image" src="https://user-images.githubusercontent.com/75510135/180245586-e7e0775e-2a5b-4ec6-b9f8-4ab4a46092ee.png">

  <img width="683" alt="image" src="https://user-images.githubusercontent.com/75510135/180247598-989fec27-f147-48da-bcd6-77de0d155cb3.png">

  <img width="617" alt="image" src="https://user-images.githubusercontent.com/75510135/180248175-afdec291-d161-4f90-b4f6-a3c4530d6025.png">

  
</details> 


<details>
<summary> G1GC Concepts and Performance Tuning </summary>
<br>

  ![](i/20220725212358.png)  

  ![](i/20220725212508.png)  

  ![](i/20220725212549.png)  

  ![](i/20220725212621.png)  
  ![](i/20220725212801.png)  

  ![](i/20220725212951.png)  

  ![](i/20220725213345.png)  

  ![](i/20220725213554.png)  

  - Measurement

  ![](i/20220725213646.png)  

  ![](i/20220725213802.png)  

  ![](i/20220725213821.png)  

  ![](i/20220725214219.png)    
</details>



- https://www.jenkins.io/blog/2016/11/21/gc-tuning/
- https://github.com/chewiebug/GCViewer
- https://gceasy.io/


The Magic Settings:
Basics: -server -XX:+AlwaysPreTouch

GC Logging: -Xloggc:$JENKINS_HOME/gc-%t.log -XX:NumberOfGCLogFiles=5 -XX:+UseGCLogFileRotation -XX:GCLogFileSize=20m -XX:+PrintGC -XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+PrintHeapAtGC -XX:+PrintGCCause -XX:+PrintTenuringDistribution -XX:+PrintReferenceGC -XX:+PrintAdaptiveSizePolicy

G1 GC settings: -XX:+UseG1GC -XX:+ExplicitGCInvokesConcurrent -XX:+ParallelRefProcEnabled -XX:+UseStringDeduplication -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:+UnlockDiagnosticVMOptions -XX:G1SummarizeRSetStatsPeriod=1

Heap settings: set your minimum heap size (-Xms) to at least 1/2 of your maximum size (-Xmx).

* vi /etc/sysconfig/jenkins
* JENKINS_JAVA_OPTIONS="-Xmx2048m -Xms1024m -XX:MaxPermSize=1024m -Djava.awt.headless=true-XX:+UseG1GC -XX:+ExplicitGCInvokesConcurrent -XX:+ParallelRefProcEnabled -XX:+UseStringDeduplication -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:+UnlockDiagnosticVMOptions -XX:G1SummarizeRSetStatsPeriod=1 -Djenkins.model.Jenkins.logStartupPerformance=true"

- With heaps of 4 GB or larger, the time required becomes long enough to be a problem: several seconds over short windows, and over a longer interval you occasionally see much longer pauses (tens of seconds, or minutes.) .This is where the user-visible hangs and lock-ups happen. It also adds significant latency to those build/deploy tasks. In periods of heavy load, the system was even experiencing hangs of 30+ seconds for a single full GC cycle.

- We’re going to focus on G1, because it is slated to become the default in Java 9 and is the official recommendation for large heap sizes.Let’s see what happens when someone uses G1 on a similarly-sized Jenkins controller with Instance B (17 GB heap):

Key stats:

1. Throughput: 99.93%
2. Average GC time: 127 ms
3. GC cycles over 2 seconds: 235 (1.56%)
4. Minor/Full GC average time: 56 ms / 3.97 sec
5. Object creation & promotion rate: 34.06 MB/s & 286 kb/s

Their settings:
* 16 GB max heap, 0.5 GB initial size
* Java flags (mostly defaults, except for G1): -XX:+UseG1GC -XX:+UseCompressedClassPointers -XX:+UseCompressedOops


G1 Garbage Collection with Instance C (24 GB heap):

Their settings:
* 24 GB max heap, 24 GB initial heap, 2 GB max metaspace
* Some custom flags: `-XX:+UseG1GC -XX:+AlwaysPreTouch -XX:+UseStringDeduplication -XX:+UseCompressedClassPointers -XX:+UseCompressedOops `

How do we fix this?

For explicit GC:

* -XX:+DisableExplicitGC will turn off Full GC triggered by System.gc(). Often set in production, but the below option is safer.
* We can trigger a concurrent GC in place of a full one with -XX:+ExplicitGCInvokesConcurrent - this will take the explicit call as a hint to do deeper cleanup, but with less performance cost.
* For the Metadata GC threshold:
Increase your initial metaspace to the final amount to avoid resizing. For example: -XX:MetaspaceSize=500M

* So, we add the GC flag -XX:+ParallelRefProcEnabled which enables us to use the multiple cores more effectively
* we set up for 24 GB of heap initially, and each minor GC clears most of the young generation. Okay, so we’ve set aside tons of space for trash to collect, which means longer but less frequent GC periods. This also gets the best performance from Jenkins memory caches which are using WeakReferences (survives until collected by GC) and SoftReferences (more long-lived). Those caches boost performance a lot.
*  limit total heap size or reduce the value of -XX:MaxGCPauseMillis=200 from its default (200).
*  explicitly set the maximum size of the young generation smaller (say -XX:G1MaxNewSizePercent=45 instead of the default of 60). We could also throw more CPUs at the problem.
*   controlled by -XX:SoftRefLRUPolicyMSPerMB (default 1000). The SoftReferences become eligible for garbage collection after this many milliseconds have elapsed since last touch…​ 

What Should I Do Before Tuning Jenkins GC:
If you’ve seen Stephen Connolly’s excellent Jenkins World talk, you know that most Jenkins instances can and should get by with 4 GB or less of allocated heap, even up to very large sizes. You will want to turn on GC logging (suggested above) and look at stats over a few weeks (remember GCeasy.io). If you’re not seeing periodic longer pause times, you’re probably okay.

For this post we assume we’ve already done the basic performance work for Jenkins:

Jenkins is running on fast, SSD-backed storage.

We’ve set up build rotation for your Jobs, to delete old builds so they don’t pile up.

The weather column is already disabled for folders.

All builds/deploys are running on build agents not on the controller. If the controller has executors allocated, they are exclusively used for backup tasks.

We’ve verified that Jenkins really does need the large heap size and can’t easily be split into separate controllers.

Conclusions
We’ve gone from:

Average 350 ms pauses (bad user experience) including less frequent 2+ second generation pauses

To an average pause of ~50 ms, with almost all under 250 ms

Reduced total memory footprint from String deduplication

How:

Use Garbage First (G1) garbage collection, which performs generally very well for Jenkins. Usually there’s enough spare CPU time to enable concurrent running.

Ensure explicit System.gc() and metaspace resizing do not trigger a Full GC because this can trigger a very long pause

Turn on parallel reference processing for Jenkins to use all CPU cores fully.

Use String deduplication, which generates a tidy win for Jenkins

Enable GC logging, which can then be used for the next level of tuning and diagnostics, if needed.

</details>

<details>
<summary> java-garbage-collection-distilled </summary>
<br>
- https://mechanical-sympathy.blogspot.com/2013/07/java-garbage-collection-distilled.html
- 
</details>
