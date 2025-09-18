BX_DUMP_DATE := $(shell date '+%Y%m%d_%H%M%S')
BX_DUMP_HASH := $(shell tr -dc a-f0-9 < /dev/urandom | head -c 32)

# ----------------------------------------------------------------
# Tar: Pack project
# ----------------------------------------------------------------

pack-bitrix:
	echo "[INFO] Tar: Packing the directory 'bitrix'"
	mkdir -p ./bitrix/backup
	tar -czf ./bitrix/backup/tar_bitrix_$(BX_DUMP_DATE)_$(BX_DUMP_HASH).tar.gz --exclude-from=.tarignore bitrix

pack-full:
	echo "[INFO] Tar: Packing the project root directory"
	mkdir -p ./bitrix/backup
	tar -czf ./bitrix/backup/tar_full_$(BX_DUMPDATE)_$(BX_DUMP_HASH).tar.gz --exclude-from=.tarignore .

pack-public:
	echo "[INFO] Tar: Packing the directory 'public'"
	mkdir -p ./bitrix/backup
	tar -czf ./bitrix/backup/tar_public_$(BX_DUMPDATE)_$(BX_DUMP_HASH).tar.gz --exclude-from=.tarignore public

pack-upload:
	echo "[INFO] Tar: Packing the directory 'upload'"
	mkdir -p ./bitrix/backup
	tar -czf ./bitrix/backup/tar_upload_$(BX_DUMPDATE)_$(BX_DUMP_HASH).tar.gz --exclude-from=.tarignore upload

# ----------------------------------------------------------------
# Tar: Unpack archives
# ----------------------------------------------------------------

unpack-first:
	tar -xz $(ls -A ./bitrix/backup/tar-*.tar.gz | tail -n 1) -C $(MAKEDIR)

unpack-latest:
	tar -xz $(ls -A ./bitrix/backup/tar-*.tar.gz | tail -n 1) -C $(MAKEDIR)

# Fix arguments
%:
	@:
