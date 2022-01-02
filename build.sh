#!/bin/sh

# Create a environment file from example.
ENV_FILE=.env
if [ ! -f "$ENV_FILE" ]; then
  cp .env.example .env
fi

# Check the acme.json ssl certificate file.
ACME_JSON=traefik-data/acme.json
if [ -f "$ACME_JSON" ]; then
  if [ $(stat -c "%a" "$ACME_JSON") != "600" ]; then
    chmod 600 $ACME_JSON
  fi
else
  touch $ACME_JSON && chmod 600 $ACME_JSON
fi

# check & create the settings.php file from src folder.
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
if [ -d "$CONFIG_FOLDER" ]; then
  chown -R www-data:www-data $CONFIG_FOLDER
fi

if [ ! "$(docker ps -q -f name=dahal_drupal9)" ] || [ ! "$(docker ps -q -f name=mysql_database)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=dahal_drupal9)" ]; then
    # cleanup
    docker rm dahal_drupal9
  fi

  if [ ! "$(docker network ls -q -f name=dahal_network)" ]; then
    docker network create dahal_network
  fi
  # run containers from prod compose file.
  docker-compose -f docker-compose-prod.yml up -d
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
