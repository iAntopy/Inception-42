FROM alpine:3.18.3


# ARG SSL_CLIENT_C
# ARG SSL_CLIENT_ST
# ARG SSL_CLIENT_L
# ARG SSL_CLIENT_O
# ARG SSL_CLIENT_OU
# ARG SSL_CLIENT_CN
# ARG SSL_CLIENT_KEY_ALG


ARG SSL_CLIENT_KEY_ALG=${SSL_CLIENT_KEY_ALG}
ARG SSL_CLIENT_ALGO=${SSL_CLIENT_ALGO}
ARG SSL_CLIENT_C=${SSL_CLIENT_C}
ARG SSL_CLIENT_ST=${SSL_CLIENT_ST}
ARG SSL_CLIENT_L=${SSL_CLIENT_L}
ARG SSL_CLIENT_O=${SSL_CLIENT_O}
ARG SSL_CLIENT_OU=${SSL_CLIENT_OU}
ARG SSL_CLIENT_CN=${SSL_CLIENT_CN}

RUN echo ${SSL_CLIENT_KEY_ALG} >> out1
RUN echo ${SSL_CLIENT_KEY_C} >> out1
RUN echo ${SSL_CLIENT_KEY_ST} >> out1
RUN echo ${SSL_CLIENT_KEY_L} >> out1
RUN echo ${SSL_CLIENT_KEY_O} >> out1
RUN echo ${SSL_CLIENT_KEY_OU} >> out1
RUN echo ${SSL_CLIENT_KEY_CN} >> out1


RUN apk update && apk upgrade && apk --no-cache add \
    nginx   \
    vim     \
    openssl

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

EXPOSE 80
#EXPOSE 443

#WORKDIR /html

ENTRYPOINT [ "nginx" , "-g", "daemon off;" ]
