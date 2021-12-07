FROM debian:11

WORKDIR /app
RUN apt-get update && apt-get install -y restic postgresql-client curl jq && \
    rm -rf /var/lib/apt/lists/*
    
ADD init.sh /app/
ADD entrypoint.sh /app/

CMD [ "/app/entrypoint.sh" ]
