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
    $ sudo docker build --tag sndnvaps/nginx -f nginx/Dockerfile .
    
    # build PHP-FPM Image
    $ sudo docker build --tag sndnvaps/php-fpm -f php-fpm/Dockerfile .
    
    # build WWW Image
    $ sudo docker build --tag sndnvaps/www -f www/Dockerfile .
    
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
    $ sudo docker run --name www -d sndnvaps/www
    
    # Run PHP-FPM Container
    $ sudo docker run --name php-fpm --volumes-from www --link mysql:mysql -d sndnvaps/php-fpm
    # see https://github.com/docker-library/docs/tree/master/php
    
    # Run Nginx Container
    $ sudo docker run --name nginx -p 80:80 -p 443:443 --volumes-from www --link php-fpm:fpmservice -d sndnvaps/nginx
    # see https://github.com/docker-library/docs/tree/master/nginx
    

### Stop Containers

You must stop the contaners in the following sequence:

1. Nginx Container 
2. PHP-FPM Container
3. WWW Container
4. MySQL Container 

    # get the runing container commit id
    $ docker ps 

```
    root@sn-WorkStation:/opt/docker-lnmp# docker ps
CONTAINER ID        IMAGE                     COMMAND                CREATED              STATUS              PORTS                                      NAMES
93a5574fa67a        sndnvaps/nginx:latest     "nginx -g 'daemon of   4 seconds ago        Up 3 seconds        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   nginx               
4d6690e1bc39        sndnvaps/php-fpm:latest   "php-fpm"              23 seconds ago       Up 22 seconds       9000/tcp                                   php-fpm             
1cd4d1fd86b8        sndnvaps/www:latest       "/bin/sh -c /conf.sh   41 seconds ago       Up 40 seconds                                                  www                 
76d8d9fb5136        mysql:latest              "docker-entrypoint.s   About a minute ago   Up About a minute   0.0.0.0:3306->3306/tcp                     mysql    

```


    # stop the container one by one 
    
    # stop Nginx Container 
    $ docker stop 93a5574fa67a
    
    # stop PHP-FPM Container 
    $ docker stop 4d6690e1bc39
    
    # stop WWW Container 
    $ docker stop 1cd4d1fd86b8
    
    # stop MySQL Container 
    $ docker stop 76d8d9fb5136


    
Have fun!

# Author

Micooz <micooz@hotmail.com>

# License

MIT


  [1]: structure.png
