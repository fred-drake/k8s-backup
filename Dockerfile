FROM debian:11

WORKDIR /app
RUN apt-get update && apt-get install -y lsb-release wget gnupg && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && apt-get install -y restic postgresql-client curl jq postgresql-client-14 && \
    rm -rf /var/lib/apt/lists/*
    
ADD init.sh /app/
ADD entrypoint.sh /app/

CMD [ "/app/entrypoint.sh" ]
