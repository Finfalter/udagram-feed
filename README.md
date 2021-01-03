# Rubric
* https://review.udacity.com/#!/rubrics/2804/view


# Docker

> Docker Cheat Sheet

## Environment variables
* __*--env-file <file\>*__ provides all environment variables which are contained in *<file\>*
* However, the file content differs from that of a bash script which can be launched with ```source <file.sh>```:
```bash
$ cat env.list
# This is a comment
VAR1=value1
VAR2=value2
USER
```
This file should use the syntax ```<variable\>=value``` (which sets the variable to the given value) or ```<variable\>``` (which takes the value from the local environment), and ```#``` for comments.

> **_NOTE:_**  see https://docs.docker.com/engine/reference/commandline/run/


## Port access
* Use __*--net host*__ if the following applies
	- container is running locally
	- container shall be reachable via its IP address
* Access with __*localhost:8081/api/v0/feed*__ for udagram-feed

## Inspecting the container
* login to a running container
	- ```docker exec -it <container name> /bin/bash``` to get a bash shell in the container
* log into a *NOT* running container
	- ```docker run -it --rm --entrypoint sh udagram-feed```

> **_NOTE:_** see https://thorsten-hans.com/how-to-run-commands-in-stopped-docker-containers


```bash
docker run --env-file ../env.list --net host udagram-feed
```

## Dockerfile
* Either (XOR)
	- Configure container with ```EXPOSE 8080``` in its *Dockerfile*
	- Run the container with ```docker run -p 8100:80 <container name>```

## All useful commands
* ```docker build -t <container name> .``` will run the Dockerfile to create an image
* ```docker run <IMAGE_ID>``` will run a container with the image
* ```docker images``` will print all the available images
* ```docker ps``` will print all the running containers
* ```docker kill <CONTAINER_ID>``` will terminate the container
* ```docker exec -it <container name> /bin/bash``` to get a bash shell in the running container
* ```docker run --env-file ../env.list --net host udagram-feed``` to get a shell in the *NOT* running container
* ```docker container inspect [OPTIONS] <container id> [CONTAINER...]``` get metadata about mentioned container(s)

## Step by step
```bash
# installing node's package dependencies
npm install

# doing a test drive
npm run dev

# build the project for the container, output is in www folder
npm run build

# build the container
docker build -t udagram-feed .

# run it by configuring environment variables and using hosts IP address
docker run --env-file ../env.list --net host udagram-feed
```

## The Frontend

* https://knowledge.udacity.com/questions/217758
* https://knowledge.udacity.com/questions/397631
* https://knowledge.udacity.com/questions/192623

# AWS

## S3
* ```aws s3 ls momi-303817241937-dev``` to list the content of given bucket
* ```aws s3 rm s3://momi-303817241937-dev/tea.jpg``` to remove given file 

---
**NOTE**

* https://knowledge.udacity.com/questions/326491

---