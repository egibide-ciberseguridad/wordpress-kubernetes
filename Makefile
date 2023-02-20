#!make

#ifneq (,$(wildcard ./.env))
#    include .env
#    export
#else
#$(error No se encuentra el fichero .env)
#endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------------------
	@echo start / stop / restart
	@echo workspace
	@echo stats
	@echo clean
	@echo kubernetes
	@echo ----------------------------------

_header:
	@echo ---------
	@echo Wordpress
	@echo ---------

_urls: _header
	${info }
	@echo ----------------------------
	@echo [WordPress] http://localhost
	@echo ----------------------------

_start-command:
	@docker compose up -d --remove-orphans

start: _start-command _urls

stop:
	@docker compose stop

restart: stop start

workspace:
	@docker compose exec wordpress /bin/bash

stats:
	@docker stats

clean:
	@docker compose down -v --remove-orphans

kubernetes:
	@kubectl apply -f volumenes.yaml
	@kubectl apply -f db-persistentvolumeclaim.yaml
	@kubectl apply -f db-deployment.yaml
	@kubectl apply -f db-service.yaml
	@kubectl apply -f wordpress-persistentvolumeclaim.yaml -f wordpress-deployment.yaml -f wordpress-service.yaml
	@kubectl apply -f ingress.yaml
