#!/bin/sh

docker-compose pull site
docker-compose up -d --build site 
