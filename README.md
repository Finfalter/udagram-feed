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

## Kubernetes
* Pairing local cli with EKS:
```aws eks --region eu-central-1 update-kubeconfig --name Demo```

---
**NOTE**

* https://knowledge.udacity.com/questions/326491

---

# DockerHub

## Tag and Push
```docker tag <container name> <repo name>```
```docker login --username=finfalter```
```docker push finfalter/udagram-feed```

# Kubernetes

## Information
```kubectl get pods```

## Debugging
```kubectl logs ${POD_NAME} -p```
```kubectl describe pod ${POD_SHORT_NAME}```

### Get a Shell to a Running Container
> https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/
```kubectl exec <ID> --stdin --tty /bin/bash```

## Cleanup
```kubectl delete -n NAMESPACE deployment DEPLOYMENT``` e.g. ```kubectl delete -n default deployment udagram-feed```
```kubectl delete --all pods --namespace=default```


## Configuration
```bash
echo "changing location"
cd ~/dev/udacity/cloud-developer/03-microservices/src/project/udagram-microservices

kubectl delete all --all -n default

# create a secret
# https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-config-file/
kubectl apply -f ../../aws-secret.yml

# create a configuration map
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
kubectl create configmap udagram-env --from-env-file=./env.list

kubectl apply -f udagram-feed/deploy/deployment.yml
kubectl apply -f udagram-feed/deploy/service.yml

kubectl apply -f udagram-user/deploy/deployment.yml
kubectl apply -f udagram-user/deploy/service.yml

kubectl apply -f udagram-frontend/deploy/deployment.yml
kubectl apply -f udagram-frontend/deploy/service.yml

kubectl apply -f udagram-reverse-proxy/deploy/deployment.yml
kubectl apply -f udagram-reverse-proxy/deploy/service.yml

kubectl get secret aws-secret -o yaml

kubectl get configmap udagram-env -o yaml

kubectl get pods
```

## Autoscaling
```kubectl autoscale deployment <NAME> --cpu-percent=<CPU_PERCENTAGE> --min=<MIN_REPLICAS> --max=<MAX_REPLICAS>```
```kubectl get hpa```

## Minikube

### External IP
```bash
# https://stackoverflow.com/questions/44110876/kubernetes-service-external-ip-pending
minikube service --url udagram-frontend
```

### Port Forwarding
```kubectl port-forward udagram-reverse-proxy-64f66fd9d6-v4f8v 8080:8080```

```kubectl port-forward udagram-frontend-64f66fd9d6-v4f8v 8100:80```

### ConfigMap
replace:
```kubectl create configmap udagram-env --from-file ./env.list -o yaml --dry-run | kubectl replace -f -```



echo -n 'hallo' | base64
echo -n 'bWF6ZGEzMjMK' | base64 --decode