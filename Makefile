END			:= \033[0m
RED			:= \033[1;31m
GREEN		:= \033[1;32m
YELLOW		:= \033[1;33m
BLUE		:= \033[1;34m
MAGENTA		:= \033[1;35m
CYAN		:= \033[1;36m
WHITE		:= \033[1;37m

build-volume:
	mkdir -p $(HOME)/data/dataBase
	mkdir -p $(HOME)/home/aleperei/data/wordPress

build-up:
	docker compose -f ./srcs/docker-compose.yml up --build 

# Run docker-compose and create the containers
up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down
	make rmi
	make rmv

start:
	docker compose -f ./srcs/docker-compose.yml start

stop:
	docker compose -f ./srcs/docker-compose.yml stop

# Show the status of the infrastructure 
status:
	@echo "$(GREEN)Containers status$(END)\n"
	@docker ps -a
	@echo "\n$(GREEN)Images status$(END)\n"
	@docker image ls
	@echo
	@echo "\n$(GREEN)Volume status$(END)\n"
	@docker volume ls
	@echo
	@echo "\n$(GREEN)Network status$(END)\n"
	@docker network ls
	@echo

rmi:
	docker rmi $$(docker images -a -q)

rmv:
	docker volume rm $$(docker volume ls -q)
	sudo rm -rf ~/data/dataBase/* ~/data/wordPress/*

rm-data:
	sudo rm -rf ~/data/dataBase ~/data/wordPress

# prune:
# 	-docker stop $$(docker ps -qa)
# 	-docker rm $$(docker ps -qa)
# 	-docker rmi -f $$(docker images -qa)
# 	-docker volume rm $$(docker volume ls -q)
# 	-docker network rm $$(docker network ls --filter "name=$(NAME)" -q)