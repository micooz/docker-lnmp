FROM php:5.6-fpm
MAINTAINER Micooz <micooz@hotmail.com>

RUN apt-get update

# Do -dev installtion at first, because 'docker-php-ext-install'
# will use these library to compile the sources before install.
# see ..... for more information.
RUN apt-get install -y libcurl4-gnutls-dev libpng-dev libmcrypt-dev libsqlite3-dev
RUN docker-php-ext-install gd mcrypt mbstring json mysql pdo_sqlite pdo_mysql iconv exif

# Change your php settings in php.ini and copy it to the right path.
COPY php-fpm/php.ini /usr/local/etc/php/php.ini