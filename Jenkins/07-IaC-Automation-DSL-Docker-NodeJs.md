- https://jenkinsci.github.io/job-dsl-plugin/
- Install below plugin
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307714-62123818-f84d-4e6a-ab87-4165b152341f.png">
- configure Docker plugin , under Manage Jenkins => Global Tool Configuration
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307861-eb3fa049-a71d-4dd0-a976-824f4a32932e.png">
- documention for docker steps to be included into groovy script
<img width="1176" alt="image" src="https://user-images.githubusercontent.com/75510135/130306818-9332e8f0-8e2c-4e92-9d2b-5642cde60183.png">
- Configure the seed project with docker step included in groovy script
<img width="1176" alt="image" src="https://user-images.githubusercontent.com/75510135/130306868-b143bc59-f6d2-4251-b97a-86eea2b14447.png">
- here is the groovy script

                          job('NodeJS Docker example') {
                              scm {
                                  git('git://github.com/wardviaene/docker-demo.git') {  node -> // is hudson.plugins.git.GitSCM
                                      node / gitConfigName('DSL User')
                                      node / gitConfigEmail('jenkins-dsl@newtech.academy')
                                  }
                              }
                              triggers {
                                  scm('H/5 * * * *')
                              }
                              wrappers {
                                  nodejs('nodejs') // this is the name of the NodeJS installation in 
                                                   // Manage Jenkins -> Configure Tools -> NodeJS Installations -> Name
                              }
                              steps {
                                  dockerBuildAndPublish {
                                      repositoryName('rupeshpanwar/docker-nodejs-demo1')
                                      tag('${GIT_REVISION,length=9}')
                                      registryCredentials('dockerhub')
                                      forcePull(false)
                                      forceTag(false)
                                      createFingerprints(false)
                                      skipDecorate()
                                  }
                              }
                          }

- specify the path under Build
<img width="1176" alt="image" src="https://user-images.githubusercontent.com/75510135/130306945-06f29ac1-6739-4da2-a1d4-c3f1d609318a.png">

- Configure credentials, under Manage Jenkins
<img width="1176" alt="image" src="https://user-images.githubusercontent.com/75510135/130307011-bac2a9c3-af05-42ac-b52c-c820577df6c7.png">
- Under domain , click on Add credential
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307029-c9bb8aac-b113-4699-bf23-9fdd65d77846.png">
- provide right credentials as mentioned in groovy docker section
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307388-69eef1e1-3002-4aa9-b08d-c3e85d6ac763.png">
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307465-3082f085-4fec-4d0b-acda-ec28d5599fc5.png">

- click on Build now
- it will be failed due to approval for the script
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307648-13de4d1a-65a9-49be-96ee-1cb97f4219fe.png">
- click on Manage jenkins , then click on In-process approval
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307668-a9b74b88-b69f-428c-80be-923f083072b7.png">

- Build now again, and project for docker will appear in dashboard
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307761-6c0df5d4-06af-4211-a617-1a279c19c41c.png">
- get into project dashboard or configuration to see what happend behind the scene
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307780-0006138d-d35e-496e-a7bc-e3880fc3731a.png">
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307792-b0012be2-d7d0-4600-b663-f9f3d90227e9.png">
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307795-c5a186ae-d7f7-4206-b60c-4e0afdc3ccaa.png">
<img width="1253" alt="image" src="https://user-images.githubusercontent.com/75510135/130307800-eaf82c04-c7a5-48a3-b063-54e4aff9ff85.png">
















