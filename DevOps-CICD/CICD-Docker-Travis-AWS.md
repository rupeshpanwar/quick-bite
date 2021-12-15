# Service overview
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126783473-a9cc9eb9-9ac0-4917-95b8-9fe719d9159f.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126783528-f1a4c248-79db-4a2c-aafb-94fe851f8c1a.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126784061-1b1e6bc2-7646-4711-b513-973639ae7eb9.png">

# Github
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126786558-7c1d82bd-7093-4da0-8892-447be8148bc2.png">
# Reference Repo : https://github.com/rupeshpanwar/multistagedockerapp.git

# Travis CI
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126786669-c0542021-a045-4417-a236-c896c6c76df1.png">
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126787115-cd10b73d-6d01-409d-853a-1458db25a3b8.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126787667-8d1c0688-306c-4eab-ab80-6cf837042f49.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126787740-df88fe6d-fd7b-467a-a113-3d14610d6ac0.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126788768-e739495d-9fbb-4226-b43a-7c54543c0648.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126788783-e42b3cb8-1c49-4c0f-ab49-93521986c1b4.png">

# Travis YML file configuration
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126789074-701fbe9b-dd5f-46d8-af7a-481bfe68ae7b.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126789162-99ca3f22-965b-4041-8387-c6011bcaca6d.png">

<img width="1041" alt="image" src="https://user-images.githubusercontent.com/75510135/126790425-88331c57-225a-41fd-b34e-616658707f92.png">

###Required Travis Script Updates

In the upcoming lecture, we will be adding a script to our .travis.yml file. Due to a change in how the Jest library works with Create React App, we need to make a small modification:

    script:
      - docker run USERNAME/docker-react npm run test -- --coverage
     

instead should be:

    script:
      - docker run -e CI=true USERNAME/docker-react npm run test

Additionally, you may want to set the following property to the top of your .travis.yml file:

    language: generic 

You can read up on the CI=true variable here:

https://facebook.github.io/create-react-app/docs/running-tests#linux-macos-bash

and environment variables in Docker here:

https://docs.docker.com/engine/reference/run/#env-environment-variables

## test
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126790952-9047c2a7-b4a7-475b-b9e3-110e83f081b5.png">

<img width="1008" alt="image" src="https://user-images.githubusercontent.com/75510135/126794305-72c8896c-7c54-4665-8bb4-edef61518a63.png">

# CI trigger
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126794969-2f994091-713a-42a1-9315-6852065c4edc.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126795004-78ba90cb-9925-4e58-9640-2e7ca342322e.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126795201-582f73dc-20be-4b2e-9d93-bacab803efb1.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126795286-0833f282-9547-4829-935e-1e1c0da84cd1.png">

# AWS - Create docker hosting environment

### Important info about AWS Platform Versions

updated 10-8-2020

On October 6, AWS made some significant platform changes that will affect our single container application. Among these changes was adding the full support of using Docker Compose to provision a production AWS environment. This means that Elastic Beanstalk will no longer first look for a Dockerfile, it will first look for a docker-compose file and attempt to build and run a container from it.

When creating our Elastic Beanstalk environment in the next lecture, we need to select Docker running on 64bit Amazon Linux instead of Docker running on 64bit Amazon Linux 2. This will ensure that our container is built using the Dockerfile and not the compose file.
![image](https://user-images.githubusercontent.com/75510135/126795527-69bfee37-2439-4e45-a43c-d26064b2450d.png)


### Create Elastic Beanstalk env
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812411-e3e9a574-5125-44dc-8097-73279c9895fa.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812543-222cf676-cfa8-42c8-b14f-f65ac83fa334.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812585-b8d96291-ce3b-4554-9542-eaf8f420e37e.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812635-0d3456af-a013-4af1-a8a1-ebf83ea6e01a.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812695-a4e66e83-a346-426f-bcd1-755a0852e161.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126813164-bd0abbb6-0050-4677-951d-1117d0af62af.png">
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126813673-d6ccc853-57f5-4f72-b884-8b27921035dd.png">

```
10:02pm
    Added instance [i-0f46a5f0842df70bd] to your environment.
10:02pm
    Environment health has transitioned from Pending to Ok. Initialization completed 12 seconds ago and took 4 minutes.
10:01pm
    Successfully launched environment: Dockerreact-env
10:01pm
    Application available at Dockerreact-env.eba-cte3bmka.us-east-2.elasticbeanstalk.com.
10:01pm
    Instance deployment completed successfully.
10:01pm
    Created Load Balancer listener named:
    arn:aws:elasticloadbalancing:us-east-2:075890588897:listener/app/awseb-AWSEB-137PMAYZN5EP7/55dba8510aac0baf/c1271d3acc0de30a
10:01pm
    Created load balancer named:
    arn:aws:elasticloadbalancing:us-east-2:075890588897:loadbalancer/app/awseb-AWSEB-137PMAYZN5EP7/55dba8510aac0baf
9:59pm
    Created CloudWatch alarm named:
    awseb-e-4hpy2sdw3y-stack-AWSEBCloudwatchAlarmLow-PXZ6HYNGJC5X
9:59pm
    Created CloudWatch alarm named:
    awseb-e-4hpy2sdw3y-stack-AWSEBCloudwatchAlarmHigh-15HJOCYCLAGA4
9:59pm
    Created Auto Scaling group policy named:
    arn:aws:autoscaling:us-east-2:075890588897:scalingPolicy:13f78e88-f1bc-4496-9a41-6a8b1d1e4b73:autoScalingGroupName/awseb-e-4hpy2sdw3y-stack-AWSEBAutoScalingGroup-1CUYDKJ6UZ68G:policyName/awseb-e-4hpy2sdw3y-stack-AWSEBAutoScalingScaleDownPolicy-PJWNRJQFXU9F
9:59pm
    Created Auto Scaling group policy named:
    arn:aws:autoscaling:us-east-2:075890588897:scalingPolicy:9be3587d-8610-4706-9492-6c2e9286e969:autoScalingGroupName/awseb-e-4hpy2sdw3y-stack-AWSEBAutoScalingGroup-1CUYDKJ6UZ68G:policyName/awseb-e-4hpy2sdw3y-stack-AWSEBAutoScalingScaleUpPolicy-TH8OPOBDA42Q
9:59pm
    Waiting for EC2 instances to launch. This may take a few minutes.
9:59pm
    Created Auto Scaling group named:
    awseb-e-4hpy2sdw3y-stack-AWSEBAutoScalingGroup-1CUYDKJ6UZ68G
9:58pm
    Created security group named:
    awseb-e-4hpy2sdw3y-stack-AWSEBSecurityGroup-G9CS3Q7T14VA
9:58pm
    Environment health has transitioned to Pending. Initialization in progress (running for 3 seconds). There are no instances.
9:57pm
    Created security group named:
    sg-0d71765ea254d59b5
9:57pm
    Created target group named:
    arn:aws:elasticloadbalancing:us-east-2:075890588897:targetgroup/awseb-AWSEB-10GDKMAU12VSK/c1bcf1bcf5cbf078
9:57pm
    Using elasticbeanstalk-us-east-2-075890588897 as Amazon S3 storage bucket for environment data.
9:57pm
    createEnvironment is starting.
```

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126814520-f29b2331-9231-4df5-b91b-44267946897e.png">


<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812872-d92377f4-1016-4fee-9e43-40d08604247c.png">

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126812910-a23ff3d3-1166-4763-81be-57441d2cb86d.png">

# Deploy - Travis configuration
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126814436-56ab3884-5735-4599-b466-e47da3a68200.png">

### Travis Keys Update and Account Migration

In the upcoming lecture, we will be adding our AWS variables to the deploy script of the .travis.yml file. There is a slight change that will be required, otherwise, you will get an error when Travis attempts to run your code.

The code will now look like this:

    access_key_id: $AWS_ACCESS_KEY
    secret_access_key: $AWS_SECRET_KEY
 # IAM - create a new user to grant access to Elastic beanstalk
 <img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126815163-b7053262-c4ad-4a01-a266-ec739b3f41e6.png">
- Click on Users
<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126815209-f434106c-7090-494a-bb05-6f3863fe903f.png">
- Click on Add Users

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126815272-56b0bd9d-f5c1-4b2c-81bb-c0aa2a116b61.png">

- grant access

<img width="1129" alt="image" src="https://user-images.githubusercontent.com/75510135/126815351-86a4ae57-4613-44e6-8426-c726b2761d41.png">

<img width="1361" alt="image" src="https://user-images.githubusercontent.com/75510135/126815601-6b713e09-1c8b-4c69-858b-0acbc8e4294f.png">
- Create user
<img width="1361" alt="image" src="https://user-images.githubusercontent.com/75510135/126815633-aa183089-05be-45a8-9d9b-e3430f3f7d96.png">
- Copy Access ID and secret access key from next screen

<img width="1361" alt="image" src="https://user-images.githubusercontent.com/75510135/126815846-bede7802-0dee-46ed-b7db-09a0ce805614.png">

# Env Variable - Travis - to configure Access Key and Secret key
<img width="1361" alt="image" src="https://user-images.githubusercontent.com/75510135/126816132-44b1b84d-c1d6-439a-8208-3487a386ca64.png">
<img width="1361" alt="image" src="https://user-images.githubusercontent.com/75510135/126816269-2fb2a3fe-ddcf-4df4-8ce8-54ac1efcdce0.png">

```
sudo: required
services:
  - docker
before_install:
  - docker build -t rupeshpanwar/multistagedockerapp -f Dockerfile.dev .
script:
  - docker run  -e CI=true rupeshpanwar/multistagedockerapp npm run test

deploy:
  provider: elasticbeanstalk
  region: "us-east-2"
  app: "docker-react"
  env: "Dockerreact-env"
  bucket_name: "elasticbeanstalk-us-east-2-075890588897"
  bucket_path: "docker-react"
  on: 
    branch: master
  access_key_id: $AWS_ACCESS_KEY
  secret_access_key: $AWS_SECRET_KEY
```


# CICD flow 
<img width="913" alt="image" src="https://user-images.githubusercontent.com/75510135/126817968-5d624743-7b04-49b0-abe3-13baf161d6dd.png">


<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126817901-f43537c9-64a1-4479-acd0-63550c418cda.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126817988-a9aac1d9-fddf-4f22-a7c0-c66acc64c582.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126818000-7965a356-67f8-4177-b503-d86e2daa5aa4.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126818057-5c04f0e2-f9b1-41a9-9fd4-acfb00c5dff8.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126818345-bd73a21a-a120-4cdd-afcc-8ab24fd95bfe.png">

# EXPOSE Port - Dockerfile
<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126818585-35fa2df5-c549-432f-86c1-b20bc2353c32.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126819254-036f968b-40db-476e-abe6-d993b858730c.png">

# AWS Build Still Failing?

If you still see a failed deployment, try the following fixes:

1) Recreate the Elastic Beanstalk environment with Docker running on 64bit Amazon Linux instead of Docker running on 64bit Amazon Linux 2. This will ensure that our container is built using the Dockerfile and not the compose file.

2) Use an Unnamed Builder

Currently, there seems to be a bug with Elasticbeanstalk and the multi-stage builder step is failing. If you pull the AWS logs, you will see:

"docker pull" requires exactly 1 argument

The quick fix will be to use an unnamed builder, rather than a named builder:

By default, the stages are not named, and you refer to them by their integer number, starting with 0 for the first FROM instruction.
https://docs.docker.com/develop/develop-images/multistage-build/#name-your-build-stages

The Dockerfile would now look like this:

      FROM node:alpine
      WORKDIR '/app'
      COPY package*.json ./
      RUN npm install
      COPY . .
      RUN npm run build
     
      FROM nginx
      EXPOSE 80
      COPY --from=0 /app/build /usr/share/nginx/html

3) Upgrade to t2small instance

The npm install command frequently times out on the t2.micro instance that we are using.  An easy fix is to bump up the instance type that Elastic Beanstalk is using to a t2.small.

Note that a t2.small is outside of the free tier, so you will pay a tiny bit of money (likely less than one dollar if you leave it running for a few hours) for this instance.  Don't forget to close it down!  Directions for this are a few videos ahead in the lecture titled 'Environment Cleanup'.

4) Refactor COPY line

Try editing the 'COPY' line of your Dockerfile like so:

COPY package*.json ./

Sometimes AWS has a tough time with the '.' folder designation and prefers the long form ./ 

```
2.55s
docker_mtu_and_registry_mirrors
resolvconf
services

3.02s$ sudo systemctl start docker
git.checkout

0.49s$ git clone --depth=50 --branch=main https://github.com/rupeshpanwar/multistagedockerapp.git rupeshpanwar/multistagedockerapp

0.01s

Setting environment variables from repository settings

$ export AWS_ACCESS_KEY=[secure]

$ export AWS_SECRET_KEY=[secure]

rvm

0.62s$ rvm use default

ruby.versions

$ ruby --version

before_install

71.50s$ docker build -t rupeshpanwar/multistagedockerapp -f Dockerfile.dev .

No Gemfile found, skipping bundle install

3.73s$ docker run  -e CI=true rupeshpanwar/multistagedockerapp npm run test

> my-app@0.1.0 test

> react-scripts test

PASS src/App.test.js

  ✓ renders learn react link (40 ms)

  ✓ renders learn react link (6 ms)

Test Suites: 1 passed, 1 total

Tests:       2 passed, 2 total

Snapshots:   0 total

Time:        2.128 s

Ran all test suites.

The command "docker run  -e CI=true rupeshpanwar/multistagedockerapp npm run test" exited with 0.

Skipping a deployment with the elasticbeanstalk provider because this branch is not permitted: main

```

# Working as a team , to push the code to a feature branch
<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126850719-b4af65dc-d991-4cce-82b2-b24b855de93c.png">

- checkout a new feature branch

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126850750-e8e6a584-4a18-480c-b62c-5d1a0c0dd608.png">

- make changes into code

<img width="1008" alt="image" src="https://user-images.githubusercontent.com/75510135/126851063-6047a1b5-b201-4fea-bf59-8c7a180abb83.png">

- push the changes to feature branch

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126850801-df96f460-cea3-4ada-81a2-b4a0cea2fcf4.png">

- Create pull request

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126851102-ed251d57-d910-4faf-87f6-2be31a44713e.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126851126-4f1d0112-bd95-47a5-b0b4-499e88270c6c.png">


- Let Travis complete the testing for new code

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126851144-be2c4cbe-e789-4f18-be9f-48946dcb057f.png">

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126851166-22209688-66fb-4c67-8445-a576e9d32ca4.png">

- Click on "Complete merge"

<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126851256-68c2e315-1c53-4a15-ba50-3efacd2fc961.png">

## CI is triggered on merge commit 
<img width="1224" alt="image" src="https://user-images.githubusercontent.com/75510135/126851295-d83c294e-bae8-4f3d-9a99-9854e1d5d062.png">

# Environment Cleanup

Remember, we need to delete the resources we created or you might end up paying real money for them.  To clean up the Elastic Beanstalk instance we created, do the following:

1. Go to the Elastic Beanstalk dashboard.

2. In the left sidebar click "Applications"

3. Click the application you'd like to delete.

4. Click the "Actions" button and click "Delete Application"

5. You will be prompted to enter the name of your application to confirm the deletion.

Note: it might take a few minutes for the dashboard to update and show that your app is being deleted.  Be a little patient!

