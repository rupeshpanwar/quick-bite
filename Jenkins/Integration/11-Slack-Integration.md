<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/130319557-2b403d80-9de8-4cc6-90ee-1d013d23d208.png">
<img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/130319681-186972b8-906b-4ba1-a856-0acabc2ebf8f.png">

<img width="854" alt="image" src="https://user-images.githubusercontent.com/75510135/130319600-51c86c85-a69d-4337-a01c-8e67ad10b71c.png">
<img width="853" alt="image" src="https://user-images.githubusercontent.com/75510135/130319627-5c4308a3-0e12-468e-8dad-b9366423d91a.png">
<img width="850" alt="image" src="https://user-images.githubusercontent.com/75510135/130319665-022484c8-7334-461a-850e-662ee175b19e.png">
<img width="857" alt="image" src="https://user-images.githubusercontent.com/75510135/130319673-d4e71ff3-6b3e-4f37-a20a-4f887fa3c938.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319694-3f58793c-2828-4820-b22f-a781cf0356dd.png">
<img width="1243" alt="image" src="https://user-images.githubusercontent.com/75510135/130319736-e3a5bc01-65ce-4a3e-a8c6-89f9f294bae2.png">
<img width="348" alt="image" src="https://user-images.githubusercontent.com/75510135/130319949-fb0b89b8-8160-4c8d-8e7d-8f01bd86c0c7.png">
<img width="772" alt="image" src="https://user-images.githubusercontent.com/75510135/130319948-d057f854-5dae-459e-8f73-4ce96c312780.png">
<img width="536" alt="image" src="https://user-images.githubusercontent.com/75510135/130319946-dc862948-1412-4bea-b83f-9cb978fa0b0d.png">
<img width="524" alt="image" src="https://user-images.githubusercontent.com/75510135/130319947-8a83a465-6b0a-481e-ad0e-d2efe0cceb87.png">
<img width="626" alt="image" src="https://user-images.githubusercontent.com/75510135/130319954-159a8c9b-aece-4a72-8b9b-f5326654997e.png">
<img width="501" alt="image" src="https://user-images.githubusercontent.com/75510135/130319963-da6da918-7cc0-4071-8274-582fe1d490f5.png">
<img width="640" alt="image" src="https://user-images.githubusercontent.com/75510135/130319974-93f105af-02a0-4b30-9b7f-39940a24e440.png">


**jenkinsfile for slack

                node {

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

                    // send slack notification
                    slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

                    // throw the error
                    throw e;
                  }
                }
# again configure credentials, then create pipeline based job for slack
