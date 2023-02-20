#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------------------
	@echo start / stop / restart
	@echo build
	@echo workspace
	@echo stats
	@echo clean
	@echo ----------------------------------

_header:
	@echo ---------
	@echo Wordpress
	@echo ---------

_urls: _header
	${info }
	@echo ----------------------------------
	@echo [WordPress] https://${WORDPRESS_HOSTNAME}
	@echo ----------------------------------

_start-command:
	@docker compose up -d --remove-orphans

_get_local_ip:
	@docker compose exec wordpress get_local_ip.sh ${WORDPRESS_HOSTNAME}

start: _start-command _get_local_ip _urls

stop:
	@docker compose stop

restart: stop start

build:
	@docker compose build

workspace:
	@docker compose exec wordpress /bin/bash

stats:
	@docker stats

clean:
	@docker compose down -v --remove-orphans
