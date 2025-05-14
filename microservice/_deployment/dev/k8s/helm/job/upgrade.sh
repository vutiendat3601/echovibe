#!/bin/sh

helm dependency update &&
helm upgrade job . -n microservice
