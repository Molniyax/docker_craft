#!make
-include .env


# Use before first run
.PHONY: init
init: create_env fill_init

# Main controls
start: stop create_volumes
	docker-compose up -d --build --force-recreate

stop:
	docker-compose down


# Additional controls
start_it: stop create_volumes
	docker-compose up -it --build --force-recreate

logs:
	docker logs -f ${INSTANCE_NAME}

enter:
	docker exec -it ${INSTANCE_NAME} sh






# Background processes
create_volumes:
	mkdir -p volumes/world
	mkdir -p volumes/logs
	mkdir -p volumes/crash-reports
	mkdir -p volumes/misc
	touch volumes/misc/banned-players.json \
		volumes/misc/banned-ips.json
	cp -u init/ops.json volumes/misc/ops.json
	make --ignore-errors -s chown

chown:
	chmod -R 777 volumes

create_env:
	mv example.env .env

fill_init:
	make fetch_server_file
	make assign_ops

fetch_server_file:
	cd init && wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

assign_ops:
	echo "[\n  {\n    \"uuid\": \"${ADMIN_UUID}\",\n    \"name\": \"${ADMIN_NAME}\",\n    \"level\": 4,\n    \"bypassesPlayerLimit\": false\n  }\n]" > init/ops.json
