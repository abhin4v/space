#!/bin/sh

docker-compose pull site
docker-compose up -d --build site
echo "Site deployed" | mailx -v -r "hooks@abhinavsarkar.net" -s "Site deployed" -S smtp="smtp:25" "abhinav.sarkar@gmail.com"
