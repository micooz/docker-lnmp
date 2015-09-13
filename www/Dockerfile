FROM debian:jessie
MAINTAINER Micooz <micooz@hotmail.com>

# Basic Requirements
RUN apt-get update
RUN apt-get install -y pwgen curl git unzip ssh openssh-server sqlite3 vim
# RUN apt-get install -y php5-cli

# The following installation is base on your own applications.

# Install Composer
# https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx
# RUN curl -sS https://getcomposer.org/installer | php
# RUN mv composer.phar /usr/local/bin/composer

# Install NodeJS
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
# RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
# RUN apt-get install --yes nodejs

# Install NPM
# https://docs.npmjs.com/getting-started/installing-node
# RUN npm install -g npm
# RUN npm install -g babel
# RUN npm install -g uglify-js

# Copy Application
COPY www/app /www
COPY www/conf.sh /conf.sh

RUN chmod 755 /conf.sh

VOLUME ["/www"]

CMD /conf.sh