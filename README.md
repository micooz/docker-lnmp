# Introduction

This project contains Dockerfiles that power `apporz.com` -- my personal website.
I want to share my ideas and designs about Web-Deploying using Docker with you.

# Structure

![structure][1]

The whole app is divided into four Containers:

1. Nginx is running in `Nginx` Container. Recieves requests from Clients then respond.
2. My App business-logic code and scripts is located at `WWW` Container. It just stores php scripts and static files.
3. PHP or PHP-FPM is put in `PHP-FPM` Container, it fetches php scripts from `WWW` then interpretes and executes them, making response to Nginx Server.
If necessary, it will connect to `MySQL` server as well.
4. Considering the flexibility and security, `MySQL` server must be independent of other containers.

# Build and Run

### Build Images

At first, you should have had [Docker](https://docs.docker.com) installed.

    # build Nginx Image
    $ sudo docker build --tag micooz/nginx -f nginx/Dockerfile .
    
    # build PHP-FPM Image
    $ sudo docker build --tag micooz/php-fpm -f php-fpm/Dockerfile .
    
    # build WWW Image
    $ sudo docker build --tag micooz/www -f www/Dockerfile .
    
    # pull MySQL Official Image
    $ sudo docker pull mysql:latest

### Run Containers

You must run the contaners in the following sequence:

1. MySQL Container
2. WWW Container
3. PHP-FPM Container
4. Nginx Container

The first two of which can be exchanged.

    # Run MySQL Container
    $ sudo docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql
    # see https://github.com/docker-library/docs/tree/master/mysql
    
    # Run WWW Container
    $ sudo docker run --name www -d micooz/www
    
    # Run PHP-FPM Container
    $ sudo docker run --name php-fpm --volumes-from www --link mysql:mysql -d micooz/php-fpm
    # see https://github.com/docker-library/docs/tree/master/php
    
    # Run Nginx Container
    $ sudo docker run --name nginx -p 80:80 -p 443:443 --volumes-from www  -v $(pwd):/www --link php-fpm:fpmservice -d micooz/nginx
    # see https://github.com/docker-library/docs/tree/master/nginx
    
Have fun!

# Author

Micooz <micooz@hotmail.com>

# License

MIT

  [1]: structure.png
