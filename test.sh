#!/bin/sh

mkdir /home/dahaltn/html1
cd /home/dahaltn/html1
touch banana.txt
cp -r /home/dahaltn/actions-runner/_work/drupal9/drupal9/drupal .

#docker-compose exec web composer install