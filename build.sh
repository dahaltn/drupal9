#!/bin/sh
cd /var/www
FILE=.env
if [ ! -f "$FILE" ]; then
    cp .env.example .env
fi

docker-compose up -d
docker-compose exec web composer install  --ignore-platform-reqs -n

docker-compose exec web drush cim -y
#docker-compose composer id -n