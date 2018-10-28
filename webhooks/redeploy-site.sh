#!/bin/sh

docker-compose pull site
docker-compose stop site
docker-compose rm -f site
docker volume rm -f space_photothumbs
docker-compose up -d --build site
echo "Site deployed" | mailx -v -r "hooks@abhinavsarkar.net" -s "Site deployed" -S smtp="smtp:25" "abhinav.sarkar@gmail.com"
