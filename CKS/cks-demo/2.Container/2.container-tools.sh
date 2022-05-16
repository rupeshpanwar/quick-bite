######### Docker ##############
# Create a Dockerfile
FROM bash
CMD ["ping","google.com"]

# build the docker image
docker build -t simple .

# list the image
docker image ls | grep simple

# run container 
docker run simple

######### podman ##############
# just replace docker
podman build -t simple .

podman image ls 

podman run simple

######### CRICTL ##############

# list the containers
crictl ps

# crictl config sneak-peak
cat /etc/crictl.yaml

##### COntainer hunder d HOOD
docker <cmd> --name <container-name> <image-name> <process-to-run-inside-container>
#container c11
docker run --name c1 -d ubuntu sh -c 'sleep 1d'

docker exec c1 ps aux

#container c12
docker run --name c2 -d ubuntu sh -c 'sleep 999d'

docker exec c2 ps aux

# check the host kernel
ps aux | grep sleep

# remove C2
docker rm c2 --force

# now run c2 container in Namespace of C1
docker run --name c2 --pid=container:c1 -d ubuntu sh -c 'sleep 999d'

# then check the process running on C1 n C2
docker exec c1 ps aux
docker exec c2 ps aux