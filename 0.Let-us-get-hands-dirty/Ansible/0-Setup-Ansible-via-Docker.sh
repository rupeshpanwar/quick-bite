docker --version

# Configuring a Dockerfile
# Base Image
FROM ubuntu:latest

RUN apt-get update; \
    apt install -y openssh-client; \
    apt install -y python3-pip

RUN pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"

# build the ansible image n run container

# Build an image from the Dockerfile with the tag -> ansible:latest
docker build -t ansible:latest .

# Display the images
docker images

# Run the Container
docker run ansible

# Display the running containers
docker ps

#Display all the containers
docker ps --all

# Run the Container in an Interactive terminal
docker run -it ansible

# Within the container, check if ansible is installed
ansible --version

# Exit the container's interactive terminal
exit

# Start a container that is currently in the exited state 
# Replace the <container-id> with the actual one
docker start --attach <container-id>

# Destroy the container after it exits
docker run -it --rm ansible



