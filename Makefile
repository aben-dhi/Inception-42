WP_DATA = /home/aben-dhi/data/wordpress
DB_DATA = /home/aben-dhi/data/mariadb

all: up

up: build
		@mkdir -p $(WP_DATA)
		@mkdir -p $(DB_DATA)
		docker-compose -f ./srcs/docker-compose.yml up -d

down:
		docker-compose -f ./srcs/docker-compose.yml down

stop:
		docker-compose -f ./srcs/docker-compose.yml stop

start:
		docker-compose -f ./srcs/docker-compose.yml start

build:
		clear
		docker-compose -f ./srcs/docker-compose.yml build

ng:
		@docker exec -it nginx sh

mdb:
		@docker exec -it mariadb sh

wp:
		@docker exec -it wordpress sh

clean: 
		@docker stop $$(docker ps -a -q) || true
		@docker rm $$(docker ps -a -q) || true
		@docker rmi -f $$(docker images -q) || true
		@docker volume rm $$(docker volume ls -q) || true
		@docker network rm $$(docker network ls -q) || true
		@rm -rf $(WP_DATA) || true
		@rm -rf $(DB_DATA) || true

re: clean up

prune: clean
		@docker system prune -a -f --volumes

.PHONY: all up down stop start build clean re prune