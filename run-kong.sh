#!/bin/bash
docker container rm -f kong
docker container rm -f kong-dashboard

docker run -d --name kong \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
    -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
    -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
    -e "KONG_CUSTOM_PLUGINS=helloworld"  \
    -e "KONG_LOG_LEVEL=debug" \
    -p 8000:8000 \
    -p 8443:8443 \
    -p 8001:8001 \
    -p 8444:8444 \
    muchrm/kong

sleep 20

docker run -d -p 8080:8080 --name kong-dashboard \
    --link kong \
    pgbi/kong-dashboard start \
    --kong-url http://kong:8001 \
    --basic-auth mis=mis2008