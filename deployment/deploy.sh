#!/bin/bash

cd "$(dirname "$0")"

echo -n "you are here: " 
pwd

kubectl delete all --all -n default

# create a secret
# https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-config-file/
kubectl apply -f ../aws-secret.yml

kubectl apply -f ../env-secret.yml

# create a configuration map
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
kubectl apply -f ../udagram-env.yml

kubectl apply -f ./feed-deployment.yml
kubectl apply -f ./feed-service.yml

kubectl apply -f ./user-deployment.yml
kubectl apply -f ./user-service.yml

kubectl apply -f ./reverse-proxy-deployment.yml
kubectl apply -f ./reverse-proxy-service.yml

kubectl apply -f ./frontend-deployment.yml
kubectl apply -f ./frontend-service.yml

echo
echo "aws-secret:"
kubectl get secret aws-secret -o yaml
echo
echo "env-secret:"
kubectl get secret env-secret -o yaml
echo
echo "configmap:"
kubectl get configmap udagram-env -o yaml

kubectl get pods