#!/bin/bash

trap exit 0 SIGINT
source /app/init.sh

echo "$(date +"%Y-%m-%d %H:%m") | ${NAMESPACE} | Starting application"
while true; do 
    if [ "$BACKUP_TYPE" == "postgresql" ]; then
        echo "$(date +"%Y-%m-%d %H:%m") | ${NAMESPACE} | Beginning PostgreSQL database dump"
        echo "${PG_HOST}:${PG_PORT}:${PG_DATABASE}:${PG_USER}:${PG_PASSWORD}" > ~/.pgpass
        chmod 600 ~/.pgpass
        pg_dump > /backup/${PG_BACKUP_FILE}
    elif [ "$BACKUP_TYPE" == "prometheus" ]; then
        echo "$(date +"%Y-%m-%d %H:%m") | ${NAMESPACE} | Taking Prometheus snapshot"
        rm -rf /backup/${NAMESPACE}/snapshots
        echo "$(date +"%Y-%m-%d %H:%m") | ${NAMESPACE} | Return status: $(curl -XPOST --silent http://prometheus-server/api/v1/admin/tsdb/snapshot | jq .status)"
        mv /backup/${NAMESPACE}/snapshots/* /backup/${NAMESPACE}/snapshots/snapshot
    fi

    echo "$(date +"%Y-%m-%d %H:%m") | ${NAMESPACE} | Beginning restic backup"
    restic backup ${BACKUP_DIRECTORY} --tag automated,${NAMESPACE}
    echo "$(date +"%Y-%m-%d %H:%m") | ${NAMESPACE} | Backup completed. Sleeping ${SLEEP_BETWEEN_BACKUPS} seconds."
    sleep ${SLEEP_BETWEEN_BACKUPS}
done
