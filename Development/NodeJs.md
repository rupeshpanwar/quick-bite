# Basic
<img width="904" alt="image" src="https://user-images.githubusercontent.com/75510135/125562469-5b6dd09a-92c1-48bc-b62c-c10dbf8d6db6.png">

Required WORKDIR update - "Could not detect node name", "idealTree" errors

10-24-2020

The v15 version of Node has recently been released and is causing issues with some of our project code.

In the next lecture you may get the following error when building the Dockerfile:

npm ERR! could not detect node name from path or package

or

npm ERR! idealTree already exists

To resolve this, add a WORKDIR right after the FROM instruction: (we will be adding this very soon anyway)

    FROM node:alpine
     
    WORKDIR /usr/app

Also, you will no longer get the error regarding the missing package.json as shown at around 7:16 in the video. With Node v15 / npm v7, if you run npm install in a directory without a package.json, an empty package.json is now created for you and will no longer throw this error. However, a properly written package.json listing your dependencies is still required to run a Node based application.

