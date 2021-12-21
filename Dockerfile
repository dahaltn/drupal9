FROM drupal:9.3.0-php8.0-apache-bullseye
MAINTAINER Tej Dahal<dahaltn@gmail.com>

# silence package installations so that debpkg doesn't prompt for mysql
# passwords and other input
ARG DEBIAN_FRONTEND=noninteractive
ENV mysql_pass ""
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update && \
	apt-get -y install net-tools \
        cron \
        nodejs \
        npm \
        curl \
        zip \
        unzip \
        git \
        iputils-ping \
        openssh-server\
        mariadb-client\
	rsyslog \
	&& echo "$SSH_PASSWD" | chpasswd

RUN docker-php-ext-install bcmath

RUN /bin/sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/apache2/apache2.conf
#RUN /bin/sed -i "s/display_errors\ \=\ Off/display_errors\ \=\ On/g" /usr/local/etc/php/php.ini
COPY init.sh /init.sh
RUN chmod +x /init.sh


WORKDIR /var/www/html
#COPY sshd_config /etc/ssh/
#COPY ./drupal /var/www/html
#COPY ./composer.json /opt/drupal/composer.json
#COPY ./composer.lock /opt/drupal/composer.lock
#COPY  ./drupal /opt/drupal

#RUN chown -R www-data:www-data /opt/drupal/sites/default/files

EXPOSE 80 443 2222

RUN service ssh start
# Run Apache2 in the foreground as a running process
#CMD ['apachectl', '-D', 'FOREGROUND']
#CMD ["/usr/sbin/sshd","-D"]
CMD ["/bin/bash", "/init.sh"]
#ENTRYPOINT []

