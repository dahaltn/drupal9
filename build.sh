#!/bin/sh

FILE=.env
if [ ! -f "$FILE" ]; then
    cp .env.example .env
fi

if [ ! "$(docker ps -q -f name=mysql_mysql_database)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=mysql_database)" ]; then
        # cleanup
        docker rm mysql_database
    fi
    # run containers
    cd /var/www
    docker-compose up -d
fi

FILE=drupal/web/sites/default/settings.php
if [ ! -f "$FILE" ]; then
    cp src/sites/default/settings.php $FILE
fi

FILE_FOLDER=drupal/web/sites/default/files

if [ ! -d "$FILE_FOLDER" ]; then
   mkdir -p $FILE_FOLDER && chown -R dahaltn:dahaltn $FILE_FOLDER
   chown -R www-data:www-data drupal/web/sites/default
   chmod 755 drupal/web/sites/default
   chmod -R 755 $FILE_FOLDER
fi

#   DB_NAME=drupal9
#   docker exec mysql_database /usr/bin/mysqldump -u root --password=newnew drupal9 > drupal9_initial_setup_backup.sql
#   docker exec -i mysql_database mysql -u root --password=newnew drupal9 < drupal9_initial_setup_backup.sql

#    docker exec dahal_drupal9 composer install -n
#    docker exec dahal_drupal9 composer id -n
