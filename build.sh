#!/bin/sh
cd $PWD
#cd /var/www
FILE=.env
if [ ! -f "$FILE" ]; then
    cp .env.example .env
fi

FILE=$PWD/drupal/web/sites/default/settings.php
if [ ! -f "$FILE" ]; then
    cp $PWD/src/sites/default/settings.php $FILE
   chmod 644 $FILE
else
     chmod 644 $FILE
fi

FILE_FOLDER=$PWD/drupal/web/sites/default/files

if [ ! -d "$FILE_FOLDER" ]; then
   mkdir -p $FILE_FOLDER && chown -R dahaltn:dahaltn $FILE_FOLDER
   chmod 755 $PWD/drupal/web/sites/default
   chmod -R 777 $FILE_FOLDER
 else
    chmod 755 $PWD/drupal/web/sites/default
    chmod -R 777 $FILE_FOLDER

fi

#    docker exec dahal_drupal9 composer install -n
#    docker exec dahal_drupal9 composer id -n
