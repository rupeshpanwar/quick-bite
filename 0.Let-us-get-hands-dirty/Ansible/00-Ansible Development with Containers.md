

<details>
<summary>Setting up an Ansible environment</summary>
<br>

  <img width="891" alt="image" src="https://user-images.githubusercontent.com/75510135/168517922-d6bf6126-46b8-4f28-8f95-66e03d06b1af.png">

  We will start by walking you through building an Ansible environment in the docker container. Using a container environment provides various benefits such as:

    Provides a consistent development experience for you and your team.
    Separates the Ansible environment from the infrastructure it aims to manage.
    Reduces management overhead (less infrastructure to manage).
    Provides an immutable Ansible environment.

For this purpose, we will be working with Docker.
Getting started with Docker#

We have already talked about the importance of containers above. Docker is a container management tool. You can easily build, run, and deploy containers using Docker.

Our first objective of this chapter is to install Docker. We have provided you with a pre-configured environment with Docker already installed, so you don’t have to go through the hassle of installing it yourself.

You can play with the pre-configured terminal below.

    Run the following command to see if Docker is installed or not.
  
  > docker --version

It will display the current version of Docker installed.
  
</details>

<details>
<summary>Configuring a Dockerfile</summary>
<br>



    “A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.”

The Dockerfile below can be reviewed for setting up an Ansible environment.
  
  ```
  # Base Image
FROM ubuntu:latest

RUN apt-get update; \
    apt install -y openssh-client; \
    apt install -y python3-pip

RUN pip3 install --upgrade pip; \
    pip3 install "ansible==2.9.12"
  
  ```

  Let’s discuss the contents of this file one by one.
FROM #

The Dockerfile starts by declaring the base image to use, ubunutu:latest in this case.
RUN#

RUN is used to execute commands that build up the Docker image. Each RUN command builds a layer on top of the base image. We are performing the following tasks with the Run command:

    Updating the System.
    Installing PIP, a Python package manager.
    Opening SSH-clients package for Ansible to connect to Linux hosts via SSH.
    Installing Ansible.

    Use a single Run command
    Each command in a Dockerfile creates a layer that adds up to build the image. It’s best practice to use as few RUN commands as possible to prevent layer sprawl.

We have reviewed the contents of the basic Dockerfile. As you go along in the course, you’ll update the Dockerfile as you require new tools and packages.
  
</details>


<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>

<details>
<summary>How do I dropdown?</summary>
<br>
This is how you dropdown.
</details>
