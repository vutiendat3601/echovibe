#!/bin/sh

helm dependency update &&
helm install fastapiapp . -n microservice
