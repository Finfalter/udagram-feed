#!/bin/bash

cd "$(dirname "$0")"

echo -n "you are here: " 
pwd

kubectl delete all --all -n default

kubectl delete configmap udagram-env  -n default

#minikube stop &