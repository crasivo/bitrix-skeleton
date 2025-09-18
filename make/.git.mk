git-fetch-root:
	if [ -d $(APP_DIR)/.git ]; then git -C $(APP_DIR) fetch --all; fi
git-fetch-local:
	find $(APP_DIR)/local -maxdepth 3 -type d -name '.git' -execdir git fetch --all \;
git-fetch: \
	git-fetch-root \
	git-fetch-local

git-pull-root:
	if [ -d $(APP_DIR)/.git ]; then git -C $(APP_DIR) pull; fi
git-pull-local:
	find $(APP_DIR)/local -maxdepth 3 -type d -name '.git' -execdir git pull \;
git-pull: \
	git-pull-root \
	git-pull-local

git-push-root:
	if [ -d $(APP_DIR)/.git ]; then git -C $(APP_DIR) push origin; fi
git-push-local:
	find $(APP_DIR)/local -maxdepth 3 -type d -name '.git' -execdir git push origin \;
git-push: \
	git-push-root \
	git-push-local

git-reset-hard:
	if [ -d $(APP_DIR)/.git ]; then git -C $(APP_DIR) reset --hard HEAD; fi
	find $(APP_DIR)/local -maxdepth 3 -type d -name '.git' -execdir git reset --hard HEAD \;

%:
	@:
