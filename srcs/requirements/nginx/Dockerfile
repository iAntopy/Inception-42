FROM alpine:3.18.3

RUN apk update && apk upgrade && apk --no-cache add \
    nginx   \
    openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -noenc  \
        -out /etc/nginx/ssl/inception.crt       \
        -keyout /etc/nginx/ssl/inception.key    \
        -subj '/C=CN/ST=QC/L=Quebec/O=42/OU=inception/CN=iamongeo.42.fr'

EXPOSE 443

ENTRYPOINT [ "nginx" , "-g", "daemon off;" ]
