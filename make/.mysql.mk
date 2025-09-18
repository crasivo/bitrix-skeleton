# Specifies
BX_DUMP_DATE = $(shell date '+%Y%m%d_%H%M%S')
BX_DUMP_HASH = $(shell tr -dc a-f0-9 < /dev/urandom | head -c 32)
BX_DUMP_FILE = $(APP_DIR)/bitrix/backup/mysql_dump_$(BX_DUMPDATE)_$(BX_RANDHASH).sql.gz

# ----------------------------------------------------------------
# MySQL: Dump
# ----------------------------------------------------------------

mysql-dump-clean:
	find $(APP_DIR)/bitrix/backup -type f -name 'mysql_dump_*' -mtime +7 -delete

mysql-dump-schema:
	mkdir -p $(APP_DIR)/bitrix/backup
	mysqldump --host=$(DB_HOST) --port=$(DB_PORT) --user=$(DB_USER) --password=$(DB_PASSWORD) --force --no-data --no-tablespaces --opt $(DB_DATABASE) | gzip >> $(BX_DUMP_FILE)

mysql-dump-data:
	mkdir -p ./bitrix/backup
	mysqldump --host=$(DB_HOST) --port=$(DB_PORT) --user=$(DB_USER) --password=$(DB_PASSWORD) --force --no-create-info --no-tablespaces --opt $(DB_DATABASE) | gzip >> $(BX_DUMP_FILE)

mysql-dump-full: \
	mysql-dump-clean \
	mysql-dump-schema \
	mysql-dump-data

mysql-dump: mysql-dump-full

# ----------------------------------------------------------------
# MySQL: Restore
# ----------------------------------------------------------------

mysql-restore-first:
	gunzip < $(ls -Ar $(APP_DIR)/bitrix/backup/mysql-*.sql.gz | tail -n 1) | mysql --host=$(DB_HOST) --port=$(DB_PORT) --user=$(DB_USER) --password=$(DB_PASSWORD) --force
mysql-restore-last:
	gunzip < $(ls -A $(APP_DIR)/bitrix/backup/mysql-*.sql.gz | tail -n 1) | mysql --host=$(DB_HOST) --port=$(DB_PORT) --user=$(DB_USER) --password=$(DB_PASSWORD) --force

# ----------------------------------------------------------------
# MySQL: SystemD service
# ----------------------------------------------------------------

mysql-start:
	sudo systemctl start mysql.service

mysql-stop:
	sudo systemctl stop mysql.service

mysql-restart: \
	mysql-stop \
	mysql-start

# Fix arguments
%:
	@:
