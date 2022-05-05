FROM node:latest
COPY . /hello-helm
RUN cd /hello-helm; npm install
EXPOSE 3000
WORKDIR /hello-helm
ENTRYPOINT ["npm", "start"]