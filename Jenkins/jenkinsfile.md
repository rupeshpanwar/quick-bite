```
def gv
 def app
 pipeline {
    agent { label 'master'}
    tools {nodejs "node"}
    options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    disableConcurrentBuilds()
  }
    environment {
        AWS_ACCOUNT_ID=""
        AWS_DEFAULT_REGION=""
        //BranchName
        IMAGE_REPO_NAME="${BRANCH_NAME}"
        TASK_FAMILY="${BRANCH_NAME}"
        SERVICE_NAME="${BRANCH_NAME}"
        DOC_REG_URL="https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
        DOC_PLAIN_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
        REG_CRED="ecr:ap-south-1:aws.credentials"
        IMAGEREPO="${DOC_PLAIN_URL}/${BRANCH_NAME}"
        ZAP_WEBSITE_URL="http://elb.amazonaws.com"
        }
    stages {    
        stage('init') {
            steps {
                script {
                     gv=load "devops/LoadScript.groovy"
                }
            }
             post{
                always { 
                    echo sh(script: 'env|sort', returnStdout: true)
                }
            }
        }//load external script
        stage('Build') {
            agent { label 'master'}

            steps {
                //Build script
                script{
                    sh "npm install"
                }
            }
            post {
                
                success {
                    script{
                    gv.sendSlackNotification("Build Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                    //gv.sendEmailNotification("Build Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                    }
                }//success
                failure {
                    script{
                    gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Build Stage has failed.",'#ff0000')
                    //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Build Stage has failed.")
                    }
                }//failure
            }
        } //stage build
        stage("Static Code Testing") {
            when {
                expression {
                     "${BRANCH_NAME}".startsWith('dev-')
                  }
              }
            parallel {
                stage('SonarQube') {
                   agent { label 'master'}
                    
                    steps {
                        //Code Coverage using SonarQube and SonarLint
                        echo "Code Coverage using SonarQube and SonarLint"
                    }
                    post {
                         success {
                            script{
                            gv.sendSlackNotification("SonarQube Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                            //gv.sendEmailNotification("SonarQube Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                            }
                        }//success
                        failure {
                            script{
                            gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} SonarQube stage has failed.",'#ff0000')
                            //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} SonarQube stage has failed.")
                            }
                        }//failure
                    }
                }
                stage('Unit Tests') {
                   agent { label 'master'}
                    
                    steps {
                        //Some Script for Unit testing
                        script{
                            /*sh "npm install mocha chai --save-dev"
                            sh "npm test"*/
                            echo "npm test"
                        }
                    }
                    post {
                        success {
                            script{
                            gv.sendSlackNotification("Unit Tests Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                            //gv.sendEmailNotification("Unit Tests Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                            }
                        }//success
                        failure {
                            script{
                            gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Unit Tests has failed.",'#ff0000')
                            //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Unit Tests has failed.")
                            }
                        }//failure
                    }//post
                }
                
            }//parallel
        } //stage Testing

        stage("Build Docker Image") {
            agent { label 'master'}
            
            steps {
                script{
                   app= docker.build IMAGEREPO
                }
            }
            post {
                success {
                        script{
                        gv.sendSlackNotification("Build Docker Image Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                        //gv.sendEmailNotification("Build Docker Image Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                        }
                    }//success
                    failure {
                        script{
                        gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Build Docker Image Stage has failed.",'#ff0000')
                        //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Build Docker Image Stage has failed.")
                        }
                    }//failure
            } //post
        } // Build Docker Image

        stage("Push Image to ECR") {
          agent { label 'master'}
            
            steps {
              script{
               
                 // sh """ 
                 // aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${DOC_PLAIN_URL}
                 // """
                  sh """ 
                  aws ecr describe-repositories --repository-names ${BRANCH_NAME} || aws ecr create-repository --repository-name ${BRANCH_NAME}
                  """
                docker.withRegistry("${DOC_REG_URL}/${BRANCH_NAME}", "${REG_CRED}")
                   {
                        app.push("${BUILD_NUMBER}")
                        app.push("latest")
                    }
              }
            }
            post {
                success {
                        script{
                        gv.sendSlackNotification("Push Image to ECR Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                        //gv.sendEmailNotification("Push Image to ECR Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                        }
                    }//success
                    failure {
                        script{
                        gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Push Image to ECR Stage has failed.",'#ff0000')
                        //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Push Image to ECR Stage has failed.")
                        }
                    }//failure
            } //post
        } // Build Docker Image

        stage('checkout TF git branch') {
            agent { label 'master'}
           steps {
                build job: 'TF-App-Deploy-To-ECS-Prod', parameters: [[$class: 'StringParameterValue', name: 'serviceName', value: "${BRANCH_NAME}"]]
            }
            post{
                always { 
                     echo sh(script: 'env|sort', returnStdout: true)
                 }
             }
        }// checkout TF git branch
        
        stage("UI and API Test Automation"){
            when {
                expression {
                     "${BRANCH_NAME}".startsWith('qa-')
                  }
              }
            parallel {
                stage("UI Test Suit"){
                        agent { label 'FM-QA'}
                        
                        /*input {
                            message "Should we deploy the QA?"
                            parameters {
                                string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                            }
                        }*/
                        steps{
                            script{
                            checkout([$class: 'GitSCM', branches: [[name: '*/NewQAInstanceCode']], extensions: [], userRemoteConfigs: [[credentialsId: 'BitBucket', url: 'https://mobinius-support@bitbucket.org/mobinius/fm_automation.git']]])
                            sh "cp /home/ubuntu/chromedriver ./browsers/"
                            sh "chmod +x ./browsers/chromedriver"
                            sh "mvn clean install"
                            }
                        } //steps
                        post {
                            
                            success {
                                script{
                                sh "aws s3 sync ./target/cucumber-reports/cucumber-html-report/cucumber-html-reports s3://report"
                                gv.sendSlackNotification("UI Test Automation ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                                gv.sendReportSlackNotification("UI QA Report Link>>","To view UI QA report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com",'#00ff00')
                                gv.sendEmailNotification("Success UI QA Report of ${JOB_NAME} #${BUILD_NUMBER}","http://amazonaws.com")
                                }
                            }
                            failure {
                                script{
                                sh "aws s3 sync ./target/cucumber-reports/cucumber-html-report/cucumber-html-reports s3://fm.qa.report"
                                gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} UI Test Automation has failed.",'#ff0000')
                                gv.sendReportSlackNotification("UI QA Report Link>>","To view UI QA report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com",'#ff0000')
                                gv.sendEmailNotification("Failure UI QA Report of ${JOB_NAME} #${BUILD_NUMBER}","http://report.s3-website.ap-south-1.amazonaws.com")
                                }
                            }
                            cleanup{
                                deleteDir()
                            }
                        }
                    }//UI Test Automation

                    stage("API Test Suit"){
                        agent { label 'FM-QA'}
                        environment {
                            POSTMAN_API_URL="https://www.postman.com/collections/"

                            API_REPORT_TITLE="API Summary Report"
                            }
                        /*input {
                            message "Should we deploy the QA?"
                            parameters {
                                string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                            }
                        }*/
                        steps{
                            script{
                            sh "npm install newman"
                            sh "npm install newman-reporter-htmlextra"
                            sh """newman run ${POSTMAN_API_URL} -r htmlextra --reporter-htmlextra-export index.html --reporter-htmlextra-browserTitle "${API_REPORT_TITLE}" --reporter-htmlextra-title "${API_REPORT_TITLE}" """
                        
                            }
                        } //steps
                        post {
                            
                            success {
                                script{
                                sh "aws s3 cp index.html s3://test-report"
                                gv.sendSlackNotification("API Test Automation ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                                gv.sendReportSlackNotification("API QA Report Link>>","To view API QA report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com",'#00ff00')
                                gv.sendEmailNotification("Success API QA Report of ${JOB_NAME} #${BUILD_NUMBER}","http://ap-south-1.amazonaws.com")
                                }
                            }
                            failure {
                                script{
                                sh "aws s3 cp index.html s3://test-report"
                                gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} UI Test Automation has failed.",'#ff0000')
                                gv.sendReportSlackNotification("API QA Report Link>>","To view API QA report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com",'#ff0000')
                                gv.sendEmailNotification("Failure API QA Report of ${JOB_NAME} #${BUILD_NUMBER}","http://ap-south-1.amazonaws.com")
                                }
                            }
                            cleanup{
                                deleteDir()
                            }
                        }
                    }//API Test Automation

            } //parallel
        } //UI and API Test Automation
        stage("Security Checks"){
            when {
                expression {
                     "${BRANCH_NAME}".startsWith('dev-')
                  }
              }
            parallel {
                stage('Snyk Security Testing') {
                    steps{
                    snykSecurity(
                    snykInstallation: 'snyk',
                    //snykTokenId: 'snyk-token',
                    snykTokenId: 'snyk-token',
                    
                    // place other parameters here
                    failOnError: true,
                    failOnIssues: false,
                    severity: 'critical'
                    )
                    }
                    post{
                        failure{
                            echo 'Failure'
                        }
                        success{
                            echo 'Success'
                        }
                        cleanup{
                            deleteDir()
                        }
                    }
                } // Snyk Stage

                 stage("DAST with OWASP ZAP") {
                    agent { label "master"}
                    
                        steps {
                        script{
                            sh """ chmod +x devops/ap.sh """
                            sh """ap.sh """      
                        }
                        }
                        post {
                            success {
                                    script{
                                     gv.sendSlackNotification("OWASP ZAP Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                                     gv.sendReportSlackNotification("OWASP ZAP Report Link>>","To OWASP ZAP report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com/",'#00ff00')
                                    //gv.sendEmailNotification("Deploy in ECS Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                                    }
                                }//success
                                failure {
                                    script{
                                    gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} OWASP ZAP Stage has failed.",'#ff0000')
                                    gv.sendReportSlackNotification("OWASP ZAP Report Link>>","To OWASP ZAP report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com/",'#ff0000')
                                    //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Deploy in ECS Stage has failed.")
                                    }
                                }//failure
                                cleanup{
                                deleteDir()
                                //echo "Delete Dir"
                            }
                        } //post
                } // ZAP
            
                    stage("SAST with SL-Scan") {
                    agent { label "master"}
                    
                        steps {
                        script{
                            sh """ chmod +x devops/scan.sh """
                            sh """scan.sh """      
                        }
                        }
                        post {
                            success {
                                    script{
                                     gv.sendSlackNotification("SL-Scan Stage>> ${currentBuild.fullDisplayName} completed successfully",'#00ff00')
                                     gv.sendReportSlackNotification("SL-Scan Report Link>>","To view SL-Scan report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com/",'#00ff00')
                                    //gv.sendEmailNotification("Deploy in ECS Stage>> ${JOB_NAME} #${BUILD_NUMBER} completed successfully")
                                    }
                                }//success
                                failure {
                                    script{
                                    gv.sendSlackNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} SL-Scan Stage has failed.",'#ff0000')
                                    gv.sendReportSlackNotification("SL-Scan Report Link>>","To view SL-Scan report of ${currentBuild.fullDisplayName} click on above link","http://ap-south-1.amazonaws.com/",'#ff0000')
                                    //gv.sendEmailNotification("Attention @here ${JOB_NAME} #${BUILD_NUMBER} Deploy in ECS Stage has failed.")
                                    }
                                }//failure
                                cleanup{
                                //deleteDir()
                                echo "Deleted slscan_reports"
                            }
                        } //post
                    } // slscan

            } //parallel
        }//Security

    } // stages
 } //pipeline

```
