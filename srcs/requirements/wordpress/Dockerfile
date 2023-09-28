FROM alpine:latest

RUN apk update && apk upgrade && apk --no-cache add \
    php \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]