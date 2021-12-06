# Check for all necessary environment variables
if [ -z "$NAMESPACE" ]; then
    echo "NAMESPACE environment variable not set!"
    exit 1;
fi

if [ "$BACKUP_TYPE" == "postgresql" ]; then
    if [ -z "$PG_HOST" ]; then
        echo "PG_HOST environment variable is not set!"
        exit 1;
    fi

    if [ -z "$PG_DATABASE" ]; then
        echo "PG_DATABASE environment variable is not set!"
        exit 1;
    fi

    if [ -z "$PG_USER" ]; then
        echo "PG_USER environment variable is not set!"
        exit 1;
    fi

    if [ -z "$PG_PASSWORD" ]; then
        echo "PG_PASSWORD environment variable is not set!"
        exit 1;
    fi

    if [ -z "$PG_BACKUP_FILE" ]; then
        echo "PG_BACKUP_FILE environment variable is not set!"
        exit 1;
    fi
fi

# Set defaults if not explicitly defined in the container definition
if [ -z "$BACKUP_TYPE" ]; then
    BACKUP_TYPE="volume"
fi

if [ -z "$BACKUP_DIRECTORY" ]; then
    BACKUP_DIRECTORY=/backup
fi

if [ -z "$SLEEP_BETWEEN_BACKUPS" ]; then
    SLEEP_BETWEEN_BACKUPS=86400
fi

if [ -z "$PG_PORT" ]; then
    PG_PORT=5432
fi
