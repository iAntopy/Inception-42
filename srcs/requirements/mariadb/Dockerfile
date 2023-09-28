FROM alpine:latest

# RUN apt-get update && apt-get upgrade && apt-get install -y \
#     mariadb \
#     mariadb-client \
#     && rm -rf /var/lib/apt/lists/*

RUN apk update && apk upgrade && apk add -y --no-cache \
    mariadb \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*
    # bash    \

# RUN mkdir -p /var/run/mysqld \
#     && chown -R mysql:mysql /var/run/mysqld \
#     && chmod 777 /var/run/mysqld

#COPY ./conf/mariadb-server.cnf /etc/my.cnf.d
COPY ./tools/mariadb_install.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb_install.sh


EXPOSE 3306

# ENTRYPOINT [ "/usr/local/bin/mariadb_install.sh" ]

# CMD ["/bin/bash"]

# CMD ["mysqld", "--bind-address=0.0.0.0"]

ENTRYPOINT [ "/usr/local/bin/mariadb_install.sh" ]