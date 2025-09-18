
# ----------------------------------------------------------------
# JS: Install
# ----------------------------------------------------------------

bx-install-extensions:
	if [ ! -d $(APP_DIR)/local/js ]; then echo "[WARNING] JS dir is not exists."; exit 0; fi
	find $(APP_DIR)/local/js -type f -name 'package-lock.json' -maxdepth 2 -execdir npm install \;
	find $(APP_DIR)/local/js -type f -name 'yarn.lock' -maxdepth 2 -execdir yarn install \;
	find $(APP_DIR)/local/js -type f -name 'pnpm-lock.yaml' -maxdepth 2 -execdir pnpm install \;

bx-install-templates:
	if [ ! -d $(APP_DIR)/local/templates ]; then echo "[WARNING] Templates dir is not exists."; exit 0; fi
	find $(APP_DIR)/local/templates -type f -name 'package-lock.json' -maxdepth 2 -execdir npm install \;
	find $(APP_DIR)/local/templates -type f -name 'yarn.lock' -maxdepth 2 -execdir yarn install \;
	find $(APP_DIR)/local/templates -type f -name 'pnpm-lock.yaml' -maxdepth 2 -execdir pnpm install \;

# ----------------------------------------------------------------
# JS: Build
# ----------------------------------------------------------------

bx-build-extensions:
	if [ ! -d $(APP_DIR)/local/js ]; then echo "[WARNING] JS dir is not exists."; exit 0; fi
	find $(APP_DIR)/local/js -type f -name 'package-lock.json' -maxdepth 2 -execdir pnpm run build \;
	find $(APP_DIR)/local/js -type f -name 'yarn.lock' -maxdepth 2 -execdir pnpm run build \;
	find $(APP_DIR)/local/js -type f -name 'pnpm-lock.yaml' -maxdepth 2 -execdir pnpm run build \;

bx-build-templates:
	if [ ! -d $(APP_DIR)/local/js ]; then echo "[WARNING] JS dir is not exists."; exit 0; fi
	find $(APP_DIR)/local/templates -type f -name 'package-lock.json' -maxdepth 2 -execdir pnpm run build \;
	find $(APP_DIR)/local/templates -type f -name 'yarn.lock' -maxdepth 2 -execdir pnpm run build \;
	find $(APP_DIR)/local/templates -type f -name 'pnpm-lock.yaml' -maxdepth 2 -execdir pnpm run build \;

%:
	@:
