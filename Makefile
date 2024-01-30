#!make
-include .env


# Use before first run
.PHONY: init
init: create_env fetch_server_file

# Main controls
start: stop create_volumes
	docker-compose up -d --build --force-recreate

stop:
	docker-compose down


# Additional controls
interact:
	docker attach ${INSTANCE_NAME} --detach-keys="ctrl-d"

logs:
	docker logs -f ${INSTANCE_NAME}

enter:
	docker exec -it ${INSTANCE_NAME} sh

kick_all:
	docker exec -it ${INSTANCE_NAME} screen -S server -X stuff "/kick @a^M"






# Background processes
create_volumes:
	mkdir -p volumes/world
	mkdir -p volumes/logs
	mkdir -p volumes/crash-reports
	mkdir -p volumes/misc
	touch volumes/misc/banned-players.json \
		volumes/misc/banned-ips.json \
		volumes/misc/ops.json \
		volumes/misc/whitelist.json
	make --ignore-errors chown

chown:
	chmod -R 777 volumes

create_env:
	mv example.env .env

fetch_server_file:
	cd init && wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar
