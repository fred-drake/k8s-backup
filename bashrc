
alias restore-pg="PGPASSWORD=$PG_PASSWORD psql -U $PG_USER -h $PG_HOST -d $PG_DATABASE < /backup/$NAMESPACE/postgresql/$PG_BACKUP_FILE"
alias restore-mysql="mysql -h $MYSQL_HOST $MYSQL_DATABASE < /backup/$NAMESPACE/mysql/$MYSQL_BACKUP_FILE"
alias snapshots="restic snapshots --tag $NAMESPACE"
alias restore="restic restore --target /"
