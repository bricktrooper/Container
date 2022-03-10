#! /bin/bash

docker rmi linux
docker build . --build-arg USER=kyle -t linux
