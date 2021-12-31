#!/bin/sh

FILE=.env
if [ ! -f "$FILE" ]; then
    cp .env.example .env
fi

FILE=drupal/web/sites/default/settings.php
if [ ! -f "$FILE" ]; then
    cp src/sites/default/settings.php $FILE
fi
     chmod 644 $FILE

FILE_FOLDER=drupal/web/sites/default/files

if [ ! -d "$FILE_FOLDER" ]; then
   mkdir -p $FILE_FOLDER && chown -R dahaltn:dahaltn $FILE_FOLDER
   chown -R www-data:www-data drupal/web/sites/default
   chmod 755 drupal/web/sites/default
   chmod -R 755 $FILE_FOLDER
 else
    chmod 755 drupal/web/sites/default
    chown -R www-data:www-data drupal/web/sites/default
    chmod -R 755 $FILE_FOLDER
fi

#   DB_NAME=drupal9
#   docker exec mysql_database /usr/bin/mysqldump -u root --password=newnew drupal9 > drupal9_initial_setup_backup.sql
#   docker exec -i mysql_database mysql -u root --password=pass $DB_NAME < drupal9_initial_setup_backup.sql

#    docker exec dahal_drupal9 composer install -n
#    docker exec dahal_drupal9 composer id -n
