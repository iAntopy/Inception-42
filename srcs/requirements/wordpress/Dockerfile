FROM alpine:latest

RUN apk update && apk upgrade && apk --no-cache add \
	bash			\
    php				\
	php-cgi			\
	php-fpm			\
	php-pdo			\
	php-gd php-cli	\
	php-mbstring	\
	mariadb-client	\
    && rm -rf /var/lib/apt/lists/*
	#wordpress		\
	#php-mysql		\

EXPOSE  9000

CMD ["sleep", "infinity"]