OS_NAME := $(shell uname -s)

dev_build:
	docker-compose -f ./docker/docker-compose.dev.yml build elixir-node-1
dev:
	docker-compose -f ./docker/docker-compose.dev.yml up
down:
	docker-compose -f ./docker/docker-compose.dev.yml down -t 1	--volumes

clean_files:
ifeq ($(OS_NAME),Linux)
	- sudo find . \( -name '_build' \) -exec rm -rf {} \;
else
	- find . \( -name '_build' \) -exec rm -rf {} \;
endif

clean_empty_images:
	docker images | grep "<none>" | awk '{print $$3}' | xargs docker rmi -f
clean_docker_images: clean_empty_images
	docker ps -a | grep "elixir-node" | awk '{print $$1}' | xargs docker rm
	docker images | grep "distributed_elixir_node" | awk '{print $$3}' | xargs docker rmi
clean_docker_volumes:
	docker volume ls | awk '$$1 == "local" { print $$2 }' | xargs docker volume rm
