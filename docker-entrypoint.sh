#!/bin/bash
set -eo pipefail
shopt -s nullglob

MY_PORT="${MY_PORT:=3000}"
MY_ACOUNT="${MY_ACOUNT:=itservice@xiongmaocar.com}"
MY_DB_SERVER="${MY_DB_SERVER:=dds-2zedd7b1a898bc141.mongodb.rds.aliyuncs.com,dds-2zedd7b1a898bc142.mongodb.rds.aliyuncs.com}"
MY_DB_NAME="${MY_DB_NAME:=yapi-db-fat}"
MY_DB_PORT="${MY_DB_PORT:=3717}"
MY_USER="${MY_USER:=yapi-db-fat}"
MY_PASS="${MY_PASS:=qVmoDcIXgDybVBlT}"
MY_AUTH="${MY_AUTH:=yapi-db-fat}"
replicaSet="${REPLICASET:=mgset-14018575}"
config() {
    if [[ -z "${MY_PORT}" || -z "${MY_ACOUNT}" || -z "${MY_DB_SERVER}" || -z "${MY_DB_NAME}" || -z "${MY_DB_PORT}" || -z "${MY_USER}" || -z "${MY_PASS}" || -z "${MY_AUTH}" || -z ${REPLICASET} ]]; then
        echo -e "\n\"MY_PORT\" or \"MY_ACOUNT\" or \"MY_DB_SERVER\" or \"MY_DB_NAME\" or \"MY_DB_PORT\" or \"MY_USER\" or \"MY_PASS\" or \"MY_AUTH\" can not be empty!\n" && exit 1
    else
        sed -i "s#MY_PORT#${MY_PORT}#g"             /api/config.json
        sed -i "s#MY_ACOUNT#${MY_ACOUNT}#g"         /api/config.json
        sed -i "s#MY_DB_SERVER#${MY_DB_SERVER}#g"         /api/config.json
        sed -i "s#MY_DB_NAME#${MY_DB_NAME}#g"         /api/config.json
        sed -i "s#MY_DB_PORT#${MY_DB_PORT}#g"         /api/config.json
        sed -i "s#MY_USER#${MY_USER}#g"         /api/config.json
        sed -i "s#MY_PASS#${MY_PASS}#g"         /api/config.json
        sed -i "s#MY_AUTH#${MY_AUTH}#g"         /api/config.json
		sed -i "s#REPLICASET#${REPLICASET}#g"   /api/config.json
    
    fi
}

config

node /api/vendors/server/app.js

exec "$@"
