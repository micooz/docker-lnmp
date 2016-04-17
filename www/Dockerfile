FROM ubuntu:14.04
MAINTAINER sndnvaps <sndnvaps@gmail.com>

# Basic Requirements
RUN apt-get update
RUN apt-get install -y pwgen curl git unzip ssh openssh-server sqlite3 vim sudo
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


# Setup sshd 
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
#  add user admin, password admin
RUN useradd admin
RUN echo "admin:admin" | chpasswd
RUN echo "admin   ALL=(ALL)       ALL" >> /etc/sudoers

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -y
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -y


# Copy Application
COPY www/app /www
COPY www/conf.sh /conf.sh

# Install TelegramImageBot for telegrambot 
# RUN git clone https://github.com/sndnvaps/TelegramImageBot.git -b master /www/bot
# RUN cd /www/bot && composer install 

# Copy webhook.php && sethook.php to /www/bot
COPY www/telegrambot/*.php /www/bot/


# run sshd
RUN mkdir /var/run/sshd
EXPOSE 22

RUN chmod 755 /conf.sh

VOLUME ["/www"]

CMD /conf.sh
CMD ["/usr/sbin/sshd", "-D"]
