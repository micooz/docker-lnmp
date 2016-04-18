FROM nginx
MAINTAINER sndnvaps <sndnvaps@gmail.com>



# The configuration for nginx image is quite simple,
# a nginx.conf is enough.

COPY nginx/nginx.conf /etc/nginx/nginx.conf

# If your site support https, you should specify
# the following files to your nginx:
# * The CA certificate.
# * The private key to encrypt the certificate. 

COPY ./ca/server.crt /etc/nginx/server.crt
COPY ./ca/server.key /etc/nginx/server.key

RUN chmod 755 /etc/nginx/server.crt
RUN chmod 755 /etc/nginx/server.key


RUN apt-get update 
RUN apt-get install -y  curl git vim sudo 

# Install supervisor for multi process support
RUN apt-get install -y supervisor
COPY nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup sshd
RUN apt-get install -y ssh openssh-server
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
#  add user admin, password admin
RUN useradd admin
RUN echo "admin:admin" | chpasswd
RUN echo "admin   ALL=(ALL)       ALL" >> /etc/sudoers

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -y
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -y

# run sshd
RUN mkdir /var/run/sshd
# log for supervisor 
RUN mkdir -p /var/log/supervisor
EXPOSE 22 80 443 
CMD ["/usr/bin/supervisord"]
