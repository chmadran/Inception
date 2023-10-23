DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

up:
	@printf "\033[32m[+] Creating volumes' directories...\033[0m\n"
	@sudo mkdir -p /home/chmadran/data/mysql
	@sudo mkdir -p /home/chmadran/data/wordpress
	@sudo chmod 777 /home/chmadran/data/mysql
	@sudo chmod 777 /home/chmadran/data/wordpress
	@printf "\033[32m[+] Starting containers...\033[0m\n"
	docker compose -f $(DOCKER_COMPOSE_FILE) up  --build
	@printf "\033[32m[+] Containers started.\033[0m\n"

clean:
	@printf "\033[32m[+] Stopping containers...\033[0m\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) down -v
	@printf "\033[32m[+] Containers stopped.\033[0m\n"
	@printf "\033[32m[+] Removing images...\033[0m\n"
	@docker rmi -f $$(docker images -q)
	@printf "\033[32m[+] Images removed.\033[0m\n"

.PHONY: up clean