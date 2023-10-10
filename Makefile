# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: iamongeo <iamongeo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/30 15:53:39 by iamongeo          #+#    #+#              #
#    Updated: 2023/09/27 15:54:10 by iamongeo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS=	./srcs

all:	up

env_check:
	@test -f $(SRCS)/.env || (echo 'Missing .env file in $(SRCS) folder. Make sure to provid it or create one base on the .env_template file.' && exit 1)

setup_volume:
	@mkdir -p /home/iamongeo/data/mariadb
	@mkdir -p /home/iamongeo/data/wordpress

up:	setup_volume env_check
	docker-compose -f $(SRCS)/docker-compose.yml up

down:
	docker-compose -f $(SRCS)/docker-compose.yml down
