#!/bin/sh
cd /var/www
FILE=.env
if [ ! -f "$FILE" ]; then
    cp .env.example .env
fi

FILE=drupal/web/sites/default/settings.php
if [ ! -f "$FILE" ]; then
    cp src/sites/default/settings.php drupal/web/sites/default/settings.php
fi

docker-compose down
docker-compose up -d
docker-compose exec web composer install --ignore-platform-reqs -n

#docker-compose exec web drush cim -y
#docker-compose composer id -n