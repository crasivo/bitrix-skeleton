MAKEARGS  := $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

# Makefile
MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR  := $(patsubst %/,%,$(dir $(MAKEFILE_PATH)))

# Application
APP_DIR = $(MAKEFILE_DIR)

# Context
CTX_GID = $(shell id -g)
CTX_UID = $(shell id -u)

# Load environments
ifneq (,$(wildcard .env))
	include .env
	export $(shell sed 's/=.*//' .env)
endif

# List commands
_list_app_commands:
	sh -c "echo 'List commands:'; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile' | sort"

# Include files
include $(APP_DIR)/make/.bitrix.mk
include $(APP_DIR)/make/.composer.mk
include $(APP_DIR)/make/.git.mk
include $(APP_DIR)/make/.mysql.mk
include $(APP_DIR)/make/.node.mk
include $(APP_DIR)/make/.tar.mk

# Fix arguments
%:
	@:
