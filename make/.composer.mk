composer-download:
	curl -sS https://getcomposer.org/installer | php -- --2.2 --install-dir=$(APP_DIR)
	chmod +x $(APP_DIR)/composer.phar
composer-dump-autoload:
	if [ -f $(APP_DIR)/composer.phar ]; then php $(APP_DIR)/composer.phar dump-autoload -d $(APP_DIR); else composer dump-autoload -d $(APP_DIR); fi
composer-dump: composer-dump-autoload
composer-install:
	if [ -f $(APP_DIR)/composer.phar ]; then php $(APP_DIR)/composer.phar install -o -d $(APP_DIR); else composer install -o -d $(APP_DIR); fi
composer-update:
	if [ -f $(APP_DIR)/composer.phar ]; then php $(APP_DIR)/composer.phar update -d $(APP_DIR); else composer update -d $(APP_DIR); fi

%:
	@:
