FROM debian:11

WORKDIR /app
RUN apt-get update && apt-get install -y lsb-release wget gnupg && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && apt-get install -y restic postgresql-client curl jq postgresql-client-14 && \
    rm -rf /var/lib/apt/lists/*
    
RUN echo 'alias restore-pg="PGPASSWORD=$PG_PASSWORD psql -U $PG_USER -h $PG_HOST -d $PG_DATABASE < /backup/$NAMESPACE/postgresql/$PG_BACKUP_FILE"' >> /root/.bashrc && \
    echo 'alias snapshots="restic snapshots --tag $NAMESPACE"' >> /root/.bashrc && \
    echo 'alias restore="restic restore --target /"' >> /root/.bashrc
ADD aliases /app/
ADD init.sh /app/
ADD entrypoint.sh /app/

CMD [ "/app/entrypoint.sh" ]
