#!/bin/sh

ENV_FILE=.env
if [ ! -f "$ENV_FILE" ]; then
    cp .env.example .env
fi

ACME_JSON=traefik-data/acme.json
if [ -f "$ACME_JSON" ]; then
  if [ $(stat -c "%a" "$ACME_JSON") != "600" ]
  then
    chmod 600 $ACME_JSON
  fi
else
 touch $ACME_JSON && chmod 600 $ACME_JSON
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

CONFIG_FOLDER=drupal/config/default/sync
if [  -d "$CONFIG_FOLDER" ]; then
   chown -R www-data:www-data $CONFIG_FOLDER
fi

if [ ! "$(docker ps -q -f name=mysql_mysql_database)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=mysql_database)" ]; then
        # cleanup
        docker rm mysql_database
    fi
    # run containers
    docker-compose up -d
else
  docker exec dahal_drupal9 composer install
  docker exec dahal_drupal9 drush cim -y
fi
#   DB_NAME=drupal9
#   docker exec mysql_database /usr/bin/mysqldump -u root --password=newnew drupal9 > drupal9_initial_setup_backup.sql
#   docker exec -i mysql_database mysql -u root --password=newnew drupal9 < drupal9_initial_setup_backup.sql

#    docker exec dahal_drupal9 composer install -n
#    docker exec dahal_drupal9 composer id -n
#    docker exec dahal_drupal9 drush cim -y
#    docker exec dahal_drupal9 drush cex -y
