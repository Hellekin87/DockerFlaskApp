#!/bin/bash

docker build -t flask -f Dockerfile  .

echo Delete old container...
docker rm -f flask

echo Run new container...
docker run -p 4000:80 --name flask flask
pause