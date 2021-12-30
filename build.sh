#!/bin/sh

FILE=.env
if [ ! -f "$FILE" ]; then
    cp ${PWD}/.env.example ${PWD}/.env
fi

docker-compose up -d
docker-compose exec web composer install  --ignore-platform-reqs -n

docker-compose exec web drush cim -y
#docker-compose composer id -n