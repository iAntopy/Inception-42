FROM alpine:3.18.3

#RUN apk update && apk upgrade && apk --no-cache add \
RUN apk update && apk upgrade && apk --no-cache add \
	wget			\
    php81			\
	php81-mysqli		\
	php81-fpm			\
	php81-phar			\
	php81-mbstring		\
	mariadb-client	\
    && rm -rf /var/lib/apt/lists/*
	#wordpress		\
	#php-mysql		\

#RUN apk update && apk upgrade && apk --no-cache add \
#	bash			\
#	wget			\
#    php				\
#    php81			\
#	php-cgi			\
#	php-mysqli		\
#	php-fpm			\
#	php-gd php-cli	\
#	mariadb-client	\
#    && rm -rf /var/lib/apt/lists/*

#COPY ./conf/wp.conf /etc/php/7.3/fpm/pool.d
COPY ./conf/wp.conf /etc/php81/php-fpm.d/www.conf
COPY ./tools/wordpress_bootstrap.sh /var/www/
RUN test -f /var/www/wordpress_bootstrap.sh

RUN chmod +x /var/www/wordpress_bootstrap.sh

EXPOSE  9000

#RUN cat /etc/passwd
#RUN addgroup -S www-data
#RUN adduser www-data -G www-data

ENTRYPOINT [ "/var/www/wordpress_bootstrap.sh" ]

#CMD ["/usr/sbin/php-fpm81", "--nodaemonize"]
CMD ["/usr/sbin/php-fpm81", "-F", "-R"]
#CMD ["sleep", "infinity"]