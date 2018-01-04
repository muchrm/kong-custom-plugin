#!/bin/bash
docker container rm -f kong-database
docker container rm -f kong-migration

docker run -d --name kong-database -p 5432:5432 \
	-e "POSTGRES_USER=kong" \
	-e "POSTGRES_DB=kong" \
	postgres:9.4

sleep 30

docker run --rm --name kong-migration \
	--link kong-database:kong-database \
	-e "KONG_DATABASE=postgres" \
	-e "KONG_PG_HOST=kong-database" \
	kong:latest kong migrations up
