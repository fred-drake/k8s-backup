# Check for all necessary environment variables
if [ -z "$NAMESPACE" ]; then
    echo "NAMESPACE environment variable not set!"
    exit 1;
fi

elementIn () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

IFS=',' read -ra BACKUP_TYPES_ARRAY <<< "$BACKUP_TYPES"

if elementIn "postgresql" "${BACKUP_TYPES_ARRAY[@]}"; then
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
if [ -z "$BACKUP_TYPES" ]; then
    BACKUP_TYPE="volume"
fi

if [ -z "$BACKUP_DIRECTORY" ]; then
    BACKUP_DIRECTORY=/backup/${NAMESPACE}
fi

if [ -z "$SLEEP_BETWEEN_BACKUPS" ]; then
    SLEEP_BETWEEN_BACKUPS=86400
fi

if [ -z "$PG_PORT" ]; then
    PG_PORT=5432
fi
