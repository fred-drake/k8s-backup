FROM debian:11

WORKDIR /app
RUN apt-get update && apt-get install -y restic postgresql-client curl && \
    rm -rf /var/lib/apt/lists/*
    
ADD init.sh /app/
ADD entrypoint.sh /app/

CMD [ "/app/entrypoint.sh" ]
