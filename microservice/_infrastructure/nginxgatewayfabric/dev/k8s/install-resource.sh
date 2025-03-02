#!/bin/sh

# Installing the Gateway API resources 
resource_installation_url=https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.1
kubectl kustomize $resource_installation_url | kubectl apply -f -
