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
