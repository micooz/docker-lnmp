#!/usr/bin/env bash

# The following configuration is base on your own application.

# DO NOT put your password or other classified information to this file!

# APP_KEY=`pwgen -c -n -s -1 32`
# DB_HOST="locahost"
# DB_DATABASE="micooz"
# DB_USERNAME="root"
# DB_PASSWORD=`pwgen -c -n -s -1 12`

chown -R www-data:www-data /www
chown -R www-data:www-data /var/log/nginx

# This command will block the process so the container will not be closed.
tail -f