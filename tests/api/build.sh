#!/usr/bin/env bash
rm -f docker-compose.yaml
mv docker-compose-new.yml docker-compose.yml
mv docker.ssl.Dockerfile Dockerfile
docker buildx build . --output type=docker,name=elestio4test/tracardi-api:latest | docker load
