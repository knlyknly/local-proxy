#!/bin/sh

read -p "Proxy: " PROXY_HOST
if [ -z PROXY_PORT ]
then
    echo Must give a proxy
    exit -1
fi

read -p "Proxy port (443): " PROXY_PORT
if [ -z PROXY_PORT ]
then
    PROXY_PORT=443
fi

read -p "Proxy UUID: " PROXY_UUID
if [ -z PROXY_UUID ]
then
    echo Must give proxy UUID
    exit -1
fi

read -p "Proxy Alt ID (1): " PROXY_ALTID
if [ -z PROXY_ALTID ]
then
    PROXY_ALTID=1
fi

cat ${V2RAY}/etc/config.json.template \
    | sed 's/$PROXY_HOST/'$PROXY_HOST'/g' \
    | sed 's/$PROXY_PORT/'$PROXY_PORT'/g' \
    | sed 's/$PROXY_UUID/'$PROXY_UUID'/g' \
    | sed 's/$PROXY_ALTID/'$PROXY_ALTID'/g' \
    > ${V2RAY}/etc/config.json

