FROM alpine:latest


RUN apk update && apk upgrade && apk add -y --no-cache \
    mariadb \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/mariadb_install.sh /usr/local/bin/
COPY ./tools/mysql_setup.sql /var/lib/mysql/
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d

RUN test -f /usr/local/bin/mariadb_install.sh
RUN test -f /var/lib/mysql/mysql_setup.sql
RUN test -f /etc/my.cnf.d/mariadb-server.cnf

RUN sed -i 's/\r//g' /usr/local/bin/mariadb_install.sh
RUN sed -i 's/\r//g' /var/lib/mysql/mysql_setup.sql

RUN chmod +x /usr/local/bin/mariadb_install.sh

EXPOSE 3306

CMD ["/bin/sh", "/usr/local/bin/mariadb_install.sh" ]