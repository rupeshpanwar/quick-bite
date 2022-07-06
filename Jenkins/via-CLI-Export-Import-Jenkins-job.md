

- download jenkins cli
  
   curl -L https://github.com/jenkins-zh/jenkins-cli/releases/latest/download/jcli-linux-amd64.tar.gz|tar xzv
   
   sudo mv jcli /usr/local/bin/

- configure cli profile to authenticate
 
   jcli config generate
   
- configure url/token etc

- download the cli jar file on jenkins server
  
    curl http://18.188.67.255:8080/jnlpJars/jenkins-cli.jar --output jenkins-cli.jar
    
- check the authentication
  
  java -jar /opt/jenkins-cli.jar -s "http://<public-ip-jenkins-server>:8080" -auth jenkinsadmin:1234 who-am-i

- to list all the jobs
  
  java -jar jenkins-cli.jar -s http://18.188.67.255:8080/ -auth jenkinsadmin:1234 list-jobs
  
- to export a job
  
  java -jar jenkins-cli.jar -s http://18.188.67.255:8080/ -auth jenkinsadmin:1234 -webSocket get-job test > test1.xml
 
  
- to import the xml configuration(exported above)
  
  java -jar jenkins-cli.jar -s http://18.188.67.255:8080/ -auth jenkinsadmin:1234 -webSocket create-job test-clone < test1.xml

                                                                                                                              
