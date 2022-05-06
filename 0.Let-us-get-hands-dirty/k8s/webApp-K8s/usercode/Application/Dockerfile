FROM node:latest
COPY . /hello-docker
RUN cd /hello-docker; npm install
EXPOSE 3000
WORKDIR /hello-docker
ENTRYPOINT  ["npm","start"]
