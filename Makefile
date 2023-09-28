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

all:
	@echo "What to do from here"
	docker-compose -f $(SRCS)/docker-compose.yml up

