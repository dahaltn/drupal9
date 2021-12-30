#!/bin/sh
cd $PWD
#cd /var/www
FILE=.env
if [ ! -f "$FILE" ]; then
    cp .env.example .env
fi

FILE=$PWD/drupal/web/sites/default/settings.php
if [ ! -f "$FILE" ]; then
    cp $PWD/src/sites/default/settings.php drupal/web/sites/default/settings.php
fi
#    docker exec dahal_drupal9 composer install -n
#    docker exec dahal_drupal9 composer id -n