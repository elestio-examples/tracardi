#!/usr/bin/env bash
mv http.Dockerfile Dockerfile
docker buildx build . --output type=docker,name=elestio4test/tracardi-gui:latest | docker load
