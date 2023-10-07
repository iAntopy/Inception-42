FROM alpine:3.18.3

RUN apk update && apk upgrade && apk --no-cache add \
	wget			\
    php81			\
	php81-mysqli		\
	php81-fpm			\
	php81-phar			\
	php81-mbstring		\
	mariadb-client	\
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/wp.conf /etc/php81/php-fpm.d/www.conf
COPY ./tools/wordpress_bootstrap.sh /var/www/
RUN test -f /var/www/wordpress_bootstrap.sh

RUN chmod +x /var/www/wordpress_bootstrap.sh

EXPOSE  9000

ENTRYPOINT [ "/var/www/wordpress_bootstrap.sh" ]
CMD ["/usr/sbin/php-fpm81", "-F", "-R"]