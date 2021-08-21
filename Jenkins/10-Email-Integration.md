<img width="851" alt="image" src="https://user-images.githubusercontent.com/75510135/130318786-9f75963b-61d7-443b-ae89-b66414e73183.png">
<img width="848" alt="image" src="https://user-images.githubusercontent.com/75510135/130318834-0a4a9336-d5e7-4719-9981-25d611057714.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130318903-28d1d137-c01e-469f-b79e-c7fe00434aef.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130318937-d83186a4-a5ab-4b54-9796-b794f263c256.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130318974-9bd38c0c-31a5-43b9-b3f2-e3f6985f2a03.png">
**jenkinsfile for email notification***

                        node {

                          // config 
                          def to = emailextrecipients([
                                  [$class: 'CulpritsRecipientProvider'],
                                  [$class: 'DevelopersRecipientProvider'],
                                  [$class: 'RequesterRecipientProvider']
                          ])

                          // job
                          try {
                            stage('build') {
                              println('so far so good...')
                            }
                            stage('test') {
                              println('A test has failed!')
                              sh 'exit 1'
                            }
                          } catch(e) {
                            // mark build as failed
                            currentBuild.result = "FAILURE";
                            // set variables
                            def subject = "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} ${currentBuild.result}"
                            def content = '${JELLY_SCRIPT,template="html"}'

                            // send email
                            if(to != null && !to.isEmpty()) {
                              emailext(body: content, mimeType: 'text/html',
                                 replyTo: '$DEFAULT_REPLYTO', subject: subject,
                                 to: to, attachLog: true )
                            }

                            // mark current build as a failure and throw the error
                            throw e;
                          }
                        }


<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319345-a7b57c34-b44d-4983-b1c5-cbcd69bc8b29.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319352-7fe76349-a837-409a-b5a3-1d8a5c90d04f.png">

<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319365-9c3e3177-73aa-4f85-ac46-c00a1068a1b1.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319382-890bcfd3-7a50-498d-a837-63c799632fc9.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319398-8165c92d-3fc3-4ba9-899d-da8ca64b49c3.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319412-f6ff4677-9b65-4328-b3ef-1130c404c195.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319418-7a10c691-91de-47fc-8699-ef03f4686744.png">

