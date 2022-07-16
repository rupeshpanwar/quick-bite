<details>
<summary>Configuration</summary>
<br>
  
  ### Java Configuration => baking in background
  
  Following arguments are considered to be best practices, based on historical data analysis of Garbage Collection Logs, Thread Dump Analysis, and Heap Dump Analysis.
  There have been several years of bug fixes, memory leak fixes, threading improvements, and Garbage Collection enhancements, and ** therefore we recommend JDK 1.8.0_212** or newer.
  - https://docs.cloudbees.com/docs/admin-resources/latest/jvm-troubleshooting/
  Additionally, keeping your JVM Heap size below 16GB and prevents you from creating a monolithic JVM
  
  #### how-to-add-java-arguments-to-jenkins
    
    The Jenkins System and Remoting Properties are added as Java Arguments.
  
  - jenkins folder => /var/lib/jenkins | /etc/sysconfig/jenkins | /etc/default/jenkins
  - https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/client-and-managed-masters/how-to-add-java-arguments-to-jenkins
    In your service configuration file, look for the argument JENKINS_JAVA_OPTIONS. It should look something like this:

    JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true"
    Then, add the arguments:

  >  JENKINS_JAVA_OPTIONS="-Xmx2048m -Djava.awt.headless=true"
  
   ### JVM Heap Size
    - https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/best-practices/jvm-memory-settings-best-practice
 
    Jenkins runs on the system directly, the java arguments Xmx and Xms can be used to set respectively the maximum and the initial JVM memory heap sizes.
  
  <img width="810" alt="image" src="https://user-images.githubusercontent.com/75510135/179339748-b4af10d7-2bbb-40eb-8bbc-99ce3f616f73.png">

        [root@ip-172-31-23-175 sysconfig]# java --version
         openjdk 11.0.13 2021-10-19 LTS
         OpenJDK Runtime Environment 18.9 (build 11.0.13+8-LTS)
         OpenJDK 64-Bit Server VM 18.9 (build 11.0.13+8-LTS, mixed mode, sharing)
  
  https://www.jenkins.io/blog/2016/11/21/gc-tuning/
  
   > JENKINS_JAVA_OPTIONS="-Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=true -Xloggc:$JENKINS_HOME/gc-%t.log -XX:NumberOfGCLogFiles=5 -XX:+UseGCLogFileRotation -XX:GCLogFileSize=20m -XX:+PrintGC -XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+PrintHeapAtGC -XX:+PrintGCCause -XX:+PrintTenuringDistribution -XX:+PrintReferenceGC -XX:+PrintAdaptiveSizePolicy -XX:+UseG1GC -XX:+ExplicitGCInvokesConcurrent -XX:+ParallelRefProcEnabled -XX:+UseStringDeduplication -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:+UnlockDiagnosticVMOptions -XX:G1SummarizeRSetStatsPeriod=1"
  
  <img width="665" alt="image" src="https://user-images.githubusercontent.com/75510135/179341045-1fd52786-e851-4c46-ad19-3d8c80eb3461.png">

  ### JVM Recommended Arguments
   - Jdk 11
  
          -XX:+AlwaysPreTouch
          -XX:+HeapDumpOnOutOfMemoryError
          -XX:HeapDumpPath=${PATH}
          -XX:+UseG1GC
          -XX:+UseStringDeduplication
          -XX:+ParallelRefProcEnabled
          -XX:+DisableExplicitGC
          -XX:+UnlockDiagnosticVMOptions
          -XX:+UnlockExperimentalVMOptions
          -Xlog:gc*=info,gc+heap=debug,gc+ref*=debug,gc+ergo*=trace,gc+age*=trace:file=${PATH}/gc.log:utctime,pid,level,tags:filecount=2,filesize=100M
          -XX:ErrorFile=${PATH}/hs_err_%p.log
          -XX:+LogVMOutput
          -XX:LogFile=${PATH}/jvm.log
  
  - Jdk 8
  
          -XX:+AlwaysPreTouch
          -XX:+HeapDumpOnOutOfMemoryError
          -XX:HeapDumpPath=${PATH}
          -XX:+UseG1GC
          -XX:+UseStringDeduplication
          -XX:+ParallelRefProcEnabled
          -XX:+DisableExplicitGC
          -XX:+UnlockDiagnosticVMOptions
          -XX:+UnlockExperimentalVMOptions
          -verbose:gc
          -Xloggc:${PATH}/gc.log
          -XX:NumberOfGCLogFiles=2
          -XX:+UseGCLogFileRotation
          -XX:GCLogFileSize=100m
          -XX:+PrintGC
          -XX:+PrintGCDateStamps
          -XX:+PrintGCDetails
          -XX:+PrintHeapAtGC
          -XX:+PrintGCCause
          -XX:+PrintTenuringDistribution
          -XX:+PrintReferenceGC
          -XX:+PrintAdaptiveSizePolicy
          -XX:ErrorFile=${PATH}/hs_err_%p.log
          -XX:+LogVMOutput
          -XX:LogFile=${PATH}/jvm.log
  
  GC logs Note:* to increase GC logs to a longer period of time, we suggest increasing the value of the arguments -Xlog option filecount=2 and/or filesize=100M and as ultimate option use file=${PATH}/gc-%t.log instead of file=${PATH}/gc.log. With the parameter %t, the JVM create a new set of GC files each time that the instance is restarted. It is well known that when the GC log folder gets big enough in terms of size, the support bundle might produce performance issues in the instance given that it needs to compress all of them.
  
  ### Ulimit Settings [just for Linux OS]
  
  ulimit -c and ulimit -f should be set to unlimited for the user that starts Jenkins. ulimit -c set to unlimited will allow core files to be generated successfully. The core files include full thread dumps and core files generated by the JVM in the event of a JVM crash. ulimit -f should be set to unlimited to ensure that files are not truncated during their generation.

ulimit -n should be set to 4096 (soft) and 8192 (hard)

ulimit -u should be set to 30654 (soft) and 30654 (hard)

=> /etc/security/limits.conf
  <img width="510" alt="image" src="https://user-images.githubusercontent.com/75510135/179341746-1a72f9a0-147b-4d5d-a0b4-0f207405cbb4.png">

      jenkins          soft    core            unlimited
      jenkins          hard    core            unlimited
      jenkins          soft    fsize           unlimited
      jenkins          hard    fsize           unlimited
      jenkins          soft    nofile          4096
      jenkins          hard    nofile          8192
      jenkins          soft    nproc           30654
      jenkins          hard    nproc           30654
  
  
  
  
  ### Java Home Environment Variable
  
  It is recommended to set the JAVA_HOME environment variable in both Linux and Windows environments. The Java JDK’s bin directory should also be in the PATH environment variable. This will allow for easier access to Java JDK commands, such as jstack and jmap
  
  > find /usr/lib/jvm/java-11-openjdk-11.0*
  > vi /etc/profile
  
          export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-11.0*"
          export PATH=$JAVA_HOME/bin:$PATH
   
   logout and login again, reboot, or use source /etc/profile to apply changes immediately in the  current shell
  
  OR
  > vi /etc/profile.d/jdk_home.sh

        #!/bin/sh
        export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0*
        export PATH=$JAVA_HOME/bin:$PATH
  
  > echo $JAVA_HOME
  
  
  #### Log Startup Timing Info
  
  - https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/troubleshooting-guides/jenkins-startup-performances
  - https://phoenixnap.com/kb/jenkins-logs
  
  > vi /etc/sysconfig/jenkins  => append -Djenkins.model.Jenkins.logStartupPerformance=true"
  
  JENKINS_JAVA_OPTIONS="-Xmx2048m -Xms1024m -XX:MaxPermSize=1024m -Djava.awt.headless=true -Xloggc:$JENKINS_HOME/gc-%t.log -XX:NumberOfGCLogFiles=5 -XX:+UseGCLogFileRotation -XX:GCLogFileSize=20m -XX:+PrintGC -XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+PrintHeapAtGC -XX:+PrintGCCause -XX:+PrintTenuringDistribution -XX:+PrintReferenceGC -XX:+PrintAdaptiveSizePolicy -XX:+UseG1GC -XX:+ExplicitGCInvokesConcurrent -XX:+ParallelRefProcEnabled -XX:+UseStringDeduplication -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:+UnlockDiagnosticVMOptions -XX:G1SummarizeRSetStatsPeriod=1 -Djenkins.model.Jenkins.logStartupPerformance=true"
  
  it is recommended to set -Djenkins.model.Jenkins.logStartupPerformance=true in your Jenkins environment to have Jenkins output additional data to the      jenkins.log, showing how much time is being spent in a specific component during startup.
  
  > systemctl restart jenkins
  
  <img width="851" alt="image" src="https://user-images.githubusercontent.com/75510135/179343537-723c93f3-3c4e-4b72-afaa-8efec7ba067d.png">

  > ls -last /var/lib/jenkins/logs/tasks
  
  
  ### Jenkins Admin Should Be Able To Generate A Support Bundle via jenkins-cli.jar
  
  Please note that Jenkins accounts must have the Overall/Read account permission to access the CLI.

  The jenkins-cli.jar can be downloaded from JENKINS_URL/cli or https://www.jenkins.io/doc/book/managing/cli/
  
  Note# support command can be viewed by navigating to JENKINS_URL/cli/command/support
  
  >  java -jar jenkins-cli.jar -noKeyAuth -s http://<Jenkins-server-public-ip>:8080/ support --usrename --password 
  
  ### Monitoring Jenkins performance
 -  https://www.cloudbees.com/blog/apm-tools-jenkins-performance
  
</details>



<details>
<summary>Underlying caveats</summary>
<br>

  Start Jenkins (service jenkins start).

  ####Explanation
  
Look at /etc/init.d/jenkins for a line similar to:

        NAME=jenkins
        SCRIPTNAME=/etc/init.d/$NAME
        [ -r /etc/default/$NAME ] && . /etc/default/$NAME
        These tell us that the Jenkins daemon will look for a file named /etc/default/jenkins. 
 
If present, it .s that file.

If you set $JAVA_ARGS in /etc/default/jenkins it will be substituted in the line below, located later in the /etc/init.d/jenkins file:

 > $SU -l $JENKINS_USER --shell=/bin/bash -c "$DAEMON $DAEMON_ARGS -- $JAVA $JAVA_ARGS -jar $JENKINS_WAR $JENKINS_ARGS" || return 2
  
  
</details>
