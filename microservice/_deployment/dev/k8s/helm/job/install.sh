#!/bin/sh

helm dependency update &&
helm install job . -n microservice
