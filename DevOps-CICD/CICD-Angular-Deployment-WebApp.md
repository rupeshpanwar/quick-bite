# Create ACR in portal.azure.com
![image](https://user-images.githubusercontent.com/75510135/129325054-63132693-8df8-48f6-b46a-94cf4fa1c2d9.png)

# make a repo in Azure DevOps

# Clone the code in VS Code
# prepare Dockerfile to build the image, [in same directory as of project code base]

        #BUILD Stage
        FROM node:alpine
        WORKDIR /src
        COPY package*.json ./
        RUN npm set strict-ssl false
        RUN npm config set registry http://registry.npmjs.org/
        RUN npm install
        COPY . .
        RUN npm install -g @angular/cli@latest
        RUN npm install --save-dev @angular-devkit/build-angular
        # generate build -- production
        RUN ng build --configuration production --output-path=/dist
        RUN ls -ld  *
        RUN ls -ld src/*
        RUN rm -rf src/*


        # RUN stage
        FROM nginx:alpine
        WORKDIR /usr/src/app
        RUN rm -rf /usr/share/nginx/html/*
        COPY nginx.conf /etc/nginx/conf.d/default.conf
        COPY --from=0 /dist /usr/share/nginx/html
        RUN ls -ld /usr/share/nginx/html/*
        EXPOSE 4200
        CMD ["nginx","-g","daemon off;"]
**push Dockerfile to repo in AzDevOps
# Create Service connection in Azure DevOps
1. Service connection to connect with ACR(Azure container regustery)
2. Another Service connection to deploy App to WebApp or AKS
![image](https://user-images.githubusercontent.com/75510135/129323578-b1e788c2-85ba-406e-8ce1-29b090784b22.png)


# Create BUILD PIPELINE(CI)
        trigger:
          branches:
            include:
            - development
        variables:
        - name: tag
          value: '$(Build.BuildId)'
        stages:
        - stage: Build
          displayName: Build and push stage
          jobs:
          - job: Build
            displayName: Build
            pool:
              vmImage: 'ubuntu-latest'
            steps:
            - task: Docker@2
              displayName: Build and push an image to ACR
              inputs:
                containerRegistry: 'manual-devops-acr-svc'
                repository: 'angular-frontend'
                command: 'buildAndPush'
                Dockerfile: 'project/Dockerfile'
                tags: |
                  $(tag)
            - task: Bash@3
              inputs:
                targetType: inline
                script: echo Contents in System Default Working Directory; ls -R $(System.DefaultWorkingDirectory)
            - task: Bash@3
              inputs:
                targetType: inline
                script: echo Before copying Contents in Build Artifact Directory; ls -R $(Build.ArtifactStagingDirectory)
**this CI pipeline will be published to repo in Az DevOps
# Run CI pipeline , it should publish image to ACR
![image](https://user-images.githubusercontent.com/75510135/129325216-767adb4f-5654-4702-9b70-8de0e83c33fb.png)
# Create WebApp using this docker image
![image](https://user-images.githubusercontent.com/75510135/129325373-e95e8559-e224-4c00-8b59-987842b64d18.png)


# Now CD (Deploy App to WebApp using CD pipeline)
- Release, create new pipeline 
- ![image](https://user-images.githubusercontent.com/75510135/129326173-61184763-9d06-4551-befb-d72d277e87e8.png)

![image](https://user-images.githubusercontent.com/75510135/129325683-e3abcf21-09bc-44f1-ad5a-9778a7fa76f6.png)

        steps:
        - task: AzureRmWebAppDeployment@4
          displayName: 'Deploy Azure App Service'
          inputs:
            azureSubscription: 'manual-devops-arm-svc'
            appType: webAppContainer
            WebAppName: 'angluar-frontend-01'
            DockerNamespace: 'azacrdev001.azurecr.io '
            DockerRepository: 'angular-frontend'
            DockerImageTag: '$(Build.BuildId)'






# dockerfile for dev
          #Build Stage
          FROM node:alpine
          WORKDIR /src
          COPY package*.json ./
          RUN npm set strict-ssl false
          RUN npm config set registry http://registry.npmjs.org/
          RUN npm install
          COPY . .
          RUN npm install -g @angular/cli@latest
          RUN npm install --save-dev @angular-devkit/build-angular
          # generate build
          RUN npm run start --output-path=/dist
          RUN ls -ld  *
          RUN ls -ld src/*
          RUN rm -rf src/*


          # stage 2
          FROM nginx:alpine
          WORKDIR /usr/src/app
          RUN rm -rf /usr/share/nginx/html/*
          COPY nginx.conf /etc/nginx/conf.d/default.conf
          COPY --from=0 /dist /usr/share/nginx/html
          RUN ls -ld /usr/share/nginx/html/*
          EXPOSE 4200
          CMD ["nginx","-g","daemon off;"]
          
# nginx.conf
        server {
            listen  80;

            root /usr/share/nginx/html;
            index index.html;

            server_name _;

            location / {
                try_files $uri /index.html;
            }
        }
# package.json
                {
                  "name": "project",
                  "version": "0.0.0",
                  "scripts": {
                    "ng": "ng",
                    "start": "ng serve --proxy-config proxy.conf.json",
                    "build": "ng build",
                    "test": "ng test",
                    "lint": "ng lint",
                    "e2e": "ng e2e"
                  },
                  "private": true,
                  "dependencies": {
                    "@angular/animations": "^11.1.2",
                    "@angular/common": "~11.0.5",
                    "@angular/compiler": "~11.0.5",
                    "@angular/core": "~11.0.5",
                    "@angular/forms": "~11.0.5",
                    "@angular/localize": "^11.2.4",
                    "@angular/platform-browser": "~11.0.5",
                    "@angular/platform-browser-dynamic": "~11.0.5",
                    "@angular/router": "~11.0.5",
                    "@ng-bootstrap/ng-bootstrap": "^9.0.2",
                    "@ng-select/ng-select": "^6.1.0",
                    "@ngx-translate/core": "^13.0.0",
                    "@rxweb/translate": "^1.0.14",
                    "angular7-csv": "^0.2.12",
                    "bootstrap": "^4.5.3",
                    "bootstrap-select": "^1.13.18",
                    "file-saver": "^2.0.5",
                    "jquery": "^3.5.1",
                    "json-parse-better-errors": "^1.0.2",
                    "json2csv": "^5.0.6",
                    "moment": "^2.29.1",
                    "ng2-search-filter": "^0.5.1",
                    "ngx-bootstrap": "^6.2.0",
                    "ngx-cookie-service": "^12.0.0",
                    "ngx-pagination": "^5.0.0",
                    "ngx-select-ex": "^6.0.2",
                    "ngx-spinner": "^11.0.2",
                    "ngx-translate-multi-http-loader": "^3.0.0",
                    "popper.js": "^1.16.1",
                    "rxjs": "~6.6.0",
                    "tslib": "^2.0.0",
                    "zone.js": "~0.10.2"
                  },
                  "devDependencies": {
                    "@angular-devkit/build-angular": "~0.1100.5",
                    "@angular/cli": "~11.0.5",
                    "@angular/compiler-cli": "~11.0.5",
                    "@types/jasmine": "~3.6.0",
                    "@types/node": "^12.20.13",
                    "codelyzer": "^6.0.0",
                    "jasmine-core": "~3.6.0",
                    "jasmine-spec-reporter": "~5.0.0",
                    "karma": "~5.1.0",
                    "karma-chrome-launcher": "~3.1.0",
                    "karma-coverage": "~2.0.3",
                    "karma-jasmine": "~4.0.0",
                    "karma-jasmine-html-reporter": "^1.5.0",
                    "protractor": "~7.0.0",
                    "ts-node": "~8.3.0",
                    "tslint": "~6.1.0",
                    "typescript": "~4.0.2"
                  }
                }
# env
                export const environment = {
                    production: false,
                   // apiUrl: 'http://localhost:3926'
                  //  apiUrl:'https://backend.azurewebsites.net'
                  };

                export const environment = {
                    production: true,
                     apiUrl: 'https://backend.azurewebsites.net'
                   // apiUrl: 'http://localhost:3926'
                  };
