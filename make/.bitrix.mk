bx-copy-settings:
	mkdir -p $(APP_DIR)/bitrix $(APP_DIR)/config
	touch $(APP_DIR)/config/.settings.php $(APP_DIR)/config/.settings_extra.php
	if [ ! -f $(APP_DIR)/bitrix/.settings.php ]; then cp -f $(APP_DIR)/config/.settings.php $(APP_DIR)/bitrix/.settings.php; fi
	if [ ! -L $(APP_DIR)/config/.settings_extra.php ]; then ln -sfr $(APP_DIR)/config/.settings_extra.php $(APP_DIR)/bitrix/.settings_extra.php; fi

bx-make-public-symlinks:
	echo "[INFO] Bitrix: Make public symlinks"
	mkdir -p $(APP_DIR)/bitrix $(APP_DIR)/local $(APP_DIR)/public $(APP_DIR)/upload
	ln -sfr $(APP_DIR)/bitrix $(APP_DIR)/public/bitrix
	ln -sfr $(APP_DIR)/local $(APP_DIR)/public/local
	ln -sfr $(APP_DIR)/upload $(APP_DIR)/public/upload

bx-cleanup-backups:
	find $(APP_DIR)/bitrix/backup -type f -name 'mysql-*' -mtime +7 -delete
	find $(APP_DIR)/bitrix/backup -type f -name 'tar-*' -mtime +7 -delete

bx-make-symlinks: \
	bx-make-public-symlinks

bx-fix-chmod:
	echo "[INFO] Bitrix: Fix directory permissions (chmod)"
	find $(APP_DIR) -type d -exec chmod 0755 {} \;
	echo "[INFO] Bitrix: Fix file permissions (chmod)"
	find $(APP_DIR) -type f -exec chmod 0644 {} \;
	chmod +x $(APP_DIR)/bin/*

bx-fix-chown:
	echo "[INFO] Bitrix: Fix project owner (chmod)"
	sudo chown -R $(CTX_UID):$(CTX_UID) $(APP_DIR)

# ----------------------------------------------------------------
# Bitrix: Download scripts
# ----------------------------------------------------------------

bx-download-adminer:
	echo "[INFO] Bitrix: Download adminer.php"
	curl -sSL https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0-mysql-en.php -o $(APP_DIR)/public/adminer.php

bx-download-restore:
	echo "[INFO] Bitrix: Download restore.php"
	curl -sSL https://www.1c-bitrix.ru/download/files/scripts/restore.php -o $(APP_DIR)/public/restore.php
	touch $(APP_DIR)/public/restore.debug

bx-download-setup:
	echo "[INFO] Bitrix: Download bitrixsetup.php"
	curl -sSL https://www.1c-bitrix.ru/download/files/scripts/bitrixsetup.php -o $(APP_DIR)/public/bitrixsetup.php

bx-remove-scripts:
	rm -f $(APP_DIR)/public/adminer* $(APP_DIR)/public/restore.* $(APP_DIR)/public/bitrixsetup.*

# ----------------------------------------------------------------
# Bitrix: Download sources
# ----------------------------------------------------------------

bx-download-start: bx-make-public-symlinks
	echo "[INFO] Bitrix: Downloading the 'Start' edition (start_encode.tar.gz)..."
	curl -SL https://www.1c-bitrix.ru/download/start_encode.tar.gz -o $(APP_DIR)/public/start_encode.tar.gz
	echo "[INFO] Bitrix: Unpacking the archive (start_encode.tar.gz)..."
	tar -xzf $(APP_DIR)/public/start_encode.tar.gz -C $(APP_DIR)/public
	rm -f $(APP_DIR)/public/start_encode.tar.gz
bx-download-standard: bx-make-public-symlinks
	echo "[INFO] Bitrix: Downloading the 'Standard' edition (start_standard.tar.gz)..."
	curl -SL https://www.1c-bitrix.ru/download/start_standard.tar.gz -o $(APP_DIR)/public/start_standard.tar.gz
	echo "[INFO] Bitrix: Unpacking the archive (start_standard.tar.gz)..."
	tar -xzf $(APP_DIR)/public/start_encode.tar.gz -C $(APP_DIR)/public
	rm -f $(APP_DIR)/public/start_encode.tar.gz
bx-download-small-business: bx-make-public-symlinks
	echo "[INFO] Bitrix: Downloading the 'Small Business' edition (small_business_encode.tar.gz)..."
	curl -SL https://www.1c-bitrix.ru/download/small_business_encode.tar.gz -o $(APP_DIR)/public/small_business_encode.tar.gz
	echo "[INFO] Bitrix: Unpacking the archive (small_business_encode.tar.gz)..."
	tar -xzf $(APP_DIR)/public/small_business_encode.tar.gz -C $(APP_DIR)/public
	rm -f $(APP_DIR)/public/small_business_encode.tar.gz
bx-download-business: bx-make-public-symlinks
	echo "[INFO] Bitrix: Downloading the 'Business' edition (business_encode.tar.gz)..."
	curl -SL https://www.1c-bitrix.ru/download/business_encode.tar.gz -o $(APP_DIR)/public/business_encode.tar.gz
	echo "[INFO] Bitrix: Unpacking the archive (business_encode.tar.gz)..."
	tar -xzf $(APP_DIR)/public/business_encode.tar.gz -C $(APP_DIR)/public
	rm -f $(APP_DIR)/public/business_encode.tar.gz
bx-download-bitrix24-shop: bx-make-public-symlinks
	echo "[INFO] Bitrix: Downloading the 'Bitrix24 Shop' edition (bitrix24_shop_encode.tar.gz)..."
	curl -SL https://www.1c-bitrix.ru/download/portal/bitrix24_shop_encode.tar.gz -o $(APP_DIR)/public/bitrix24_shop_encode.tar.gz
	echo "[INFO] Bitrix: Unpacking the archive (bitrix24_shop_encode.tar.gz)..."
	tar -xzf $(APP_DIR)/public/bitrix24_shop_encode.tar.gz -C $(APP_DIR)/public
	rm -f $(APP_DIR)/public/bitrix24_shop_encode.tar.gz
bx-download-bitrix24-enterprise: bx-make-public-symlinks
	echo "[INFO] Bitrix: Downloading the 'Bitrix24 Enterprise' edition (bitrix24_shop_encode.tar.gz)..."
	curl -SL https://www.1c-bitrix.ru/download/business_cluster_encode.tar.gz -o $(APP_DIR)/public/business_cluster_encode.tar.gz
	echo "[INFO] Bitrix: Unpacking the archive (business_cluster_encode.tar.gz)..."
	tar -xzf $(APP_DIR)/public/business_cluster_encode.tar.gz -C $(APP_DIR)/public
	rm -f $(APP_DIR)/public/business_cluster_encode.tar.gz

## Fix arguments
%:
	@:
