FROM alpine:3.18.3

RUN apk update && apk upgrade && apk --no-cache add \
    sudo    \
    nginx   \
    openssl
 #   vim     \

#COPY conf hello_conf.cfg
COPY conf/nginx.conf /etc/nginx/nginx.conf
#COPY var/www/index.html /html/index.html
#COPY var/www/index.html /usr/share/nginx/html/index.html

RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/ssl


#RUN openssl req -$SSL_CLIENT_KEY_ALG -noenc     \
RUN openssl req -x509 -noenc     \
        -out /etc/nginx/ssl/inception.crt       \
        -keyout /etc/nginx/ssl/inception.key    \
        -subj "/C=CN/ST=QC/L=Quebec/O=42/OU=ft_transcendence/CN=Alex"
        #-subj "/C=$SSL_CLIENT_C/ST=$SSL_CLIENT_ST/L=$SSL_CLIENT_L/O=$SSL_CLIENT_O/OU=$SSL_CLIENT_OU/CN=$SSL_CLIENT_CN"

#EXPOSE 80
EXPOSE 443

#WORKDIR /html

ENTRYPOINT [ "nginx" , "-g", "daemon off;" ]
