#!/bin/sh

helm dependency update &&
helm upgrade fastapiapp . -n microservice
