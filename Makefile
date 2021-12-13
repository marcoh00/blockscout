SYSTEM = $(shell uname -s)
HOST = host.docker.internal
DOCKER_IMAGE = blockscout_prod
BS_CONTAINER_NAME = blockscout
PG_CONTAINER_NAME = postgres
PG_CONTAINER_IMAGE = postgres:12.5
THIS_FILE = $(lastword $(MAKEFILE_LIST))

ifeq ($(SYSTEM), Linux)
	HOST=localhost
endif

DB_URL = postgresql://postgres:@$(HOST):5432/explorer?ssl=false
BLOCKSCOUT_CONTAINER_PARAMS = -e 'MIX_ENV=prod' \
															 -e 'DATABASE_URL=$(DB_URL)'
ifeq ($(SYSTEM), Linux)
	BLOCKSCOUT_CONTAINER_PARAMS += --network=host
endif
ifdef NETWORK
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'NETWORK=$(NETWORK)'
endif
ifdef SUBNETWORK
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SUBNETWORK=$(SUBNETWORK)'
endif
ifdef LOGO
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'LOGO=$(LOGO)'
endif
ifdef LOGO_FOOTER
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'LOGO_FOOTER=$(LOGO_FOOTER)'
endif
ifdef ETHEREUM_JSONRPC_VARIANT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ETHEREUM_JSONRPC_VARIANT=$(ETHEREUM_JSONRPC_VARIANT)'
endif
ifdef ETHEREUM_JSONRPC_HTTP_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ETHEREUM_JSONRPC_HTTP_URL=$(ETHEREUM_JSONRPC_HTTP_URL)'
endif
ifdef ETHEREUM_JSONRPC_TRACE_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ETHEREUM_JSONRPC_TRACE_URL=$(ETHEREUM_JSONRPC_TRACE_URL)'
endif
ifdef ETHEREUM_JSONRPC_WS_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ETHEREUM_JSONRPC_WS_URL=$(ETHEREUM_JSONRPC_WS_URL)'
endif
ifdef ETHEREUM_JSONRPC_TRANSPORT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ETHEREUM_JSONRPC_TRANSPORT=$(ETHEREUM_JSONRPC_TRANSPORT)'
endif
ifdef IPC_PATH
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'IPC_PATH=$(IPC_PATH)'
endif
ifdef NETWORK_PATH
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'NETWORK_PATH=$(NETWORK_PATH)'
endif
ifdef CHECK_ORIGIN
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'CHECK_ORIGIN=$(CHECK_ORIGIN)'
endif
ifdef COIN
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'COIN=$(COIN)'
endif
ifdef METADATA_CONTRACT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'METADATA_CONTRACT=$(METADATA_CONTRACT)'
endif
ifdef POS_STAKING_CONTRACT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'POS_STAKING_CONTRACT=$(POS_STAKING_CONTRACT)'
endif
ifdef VALIDATORS_CONTRACT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'VALIDATORS_CONTRACT=$(VALIDATORS_CONTRACT)'
endif
ifdef KEYS_MANAGER_CONTRACT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'KEYS_MANAGER_CONTRACT=$(KEYS_MANAGER_CONTRACT)'
endif
ifdef SUPPLY_MODULE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SUPPLY_MODULE=$(SUPPLY_MODULE)'
endif
ifdef SOURCE_MODULE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SOURCE_MODULE=$(SOURCE_MODULE)'
endif
ifdef POOL_SIZE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'POOL_SIZE=$(POOL_SIZE)'
endif
ifdef ECTO_USE_SSL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ECTO_USE_SSL=$(ECTO_USE_SSL)'
endif
ifdef DATADOG_HOST
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DATADOG_HOST=$(DATADOG_HOST)'
endif
ifdef DATADOG_PORT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DATADOG_PORT=$(DATADOG_PORT)'
endif
ifdef SPANDEX_BATCH_SIZE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SPANDEX_BATCH_SIZE=$(SPANDEX_BATCH_SIZE)'
endif
ifdef SPANDEX_SYNC_THRESHOLD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SPANDEX_SYNC_THRESHOLD=$(SPANDEX_SYNC_THRESHOLD)'
endif
ifdef HEART_BEAT_TIMEOUT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'HEART_BEAT_TIMEOUT=$(HEART_BEAT_TIMEOUT)'
endif
ifdef HEART_COMMAND
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'HEART_COMMAND=$(HEART_COMMAND)'
endif
ifdef BLOCKSCOUT_VERSION
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'BLOCKSCOUT_VERSION=$(BLOCKSCOUT_VERSION)'
endif
ifdef RELEASE_LINK
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'RELEASE_LINK=$(RELEASE_LINK)'
endif
ifdef ELIXIR_VERSION
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ELIXIR_VERSION=$(ELIXIR_VERSION)'
endif
ifdef BLOCK_TRANSFORMER
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'BLOCK_TRANSFORMER=$(BLOCK_TRANSFORMER)'
endif
ifdef GRAPHIQL_TRANSACTION
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'GRAPHIQL_TRANSACTION=$(GRAPHIQL_TRANSACTION)'
endif
ifdef FIRST_BLOCK
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'FIRST_BLOCK=$(FIRST_BLOCK)'
endif
ifdef LAST_BLOCK
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'LAST_BLOCK=$(LAST_BLOCK)'
endif
ifdef TXS_COUNT_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'TXS_COUNT_CACHE_PERIOD=$(TXS_COUNT_CACHE_PERIOD)'
endif
ifdef ADDRESS_WITH_BALANCES_UPDATE_INTERVAL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ADDRESS_WITH_BALANCES_UPDATE_INTERVAL=$(ADDRESS_WITH_BALANCES_UPDATE_INTERVAL)'
endif
ifdef LINK_TO_OTHER_EXPLORERS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'LINK_TO_OTHER_EXPLORERS=$(LINK_TO_OTHER_EXPLORERS)'
endif
ifdef SUPPORTED_CHAINS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SUPPORTED_CHAINS=$(SUPPORTED_CHAINS)'
endif
ifdef BLOCK_COUNT_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'BLOCK_COUNT_CACHE_PERIOD=$(BLOCK_COUNT_CACHE_PERIOD)'
endif
ifdef ADDRESS_SUM_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ADDRESS_SUM_CACHE_PERIOD=$(ADDRESS_SUM_CACHE_PERIOD)'
endif
ifdef ADDRESS_COUNT_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ADDRESS_COUNT_CACHE_PERIOD=$(ADDRESS_COUNT_CACHE_PERIOD)'
endif
ifdef ALLOWED_EVM_VERSIONS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ALLOWED_EVM_VERSIONS=$(ALLOWED_EVM_VERSIONS)'
endif
ifdef UNCLES_IN_AVERAGE_BLOCK_TIME
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'UNCLES_IN_AVERAGE_BLOCK_TIME=$(UNCLES_IN_AVERAGE_BLOCK_TIME)'
endif
ifdef AVERAGE_BLOCK_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'AVERAGE_BLOCK_CACHE_PERIOD=$(AVERAGE_BLOCK_CACHE_PERIOD)'
endif
ifdef MARKET_HISTORY_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'MARKET_HISTORY_CACHE_PERIOD=$(MARKET_HISTORY_CACHE_PERIOD)'
endif
ifdef DISABLE_WEBAPP
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_WEBAPP=$(DISABLE_WEBAPP)'
endif
ifdef DISABLE_READ_API
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_READ_API=$(DISABLE_READ_API)'
endif
ifdef DISABLE_WRITE_API
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_WRITE_API=$(DISABLE_WRITE_API)'
endif
ifdef DISABLE_INDEXER
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_INDEXER=$(DISABLE_INDEXER)'
endif
ifdef WEBAPP_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'WEBAPP_URL=$(WEBAPP_URL)'
endif
ifdef API_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'API_URL=$(API_URL)'
endif
ifdef CHAIN_SPEC_PATH
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'CHAIN_SPEC_PATH=$(CHAIN_SPEC_PATH)'
endif
ifdef EMISSION_FORMAT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'EMISSION_FORMAT=$(EMISSION_FORMAT)'
endif
ifdef REWARDS_CONTRACT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'REWARDS_CONTRACT=$(REWARDS_CONTRACT)'
endif
ifdef SHOW_ADDRESS_MARKETCAP_PERCENTAGE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SHOW_ADDRESS_MARKETCAP_PERCENTAGE=$(SHOW_ADDRESS_MARKETCAP_PERCENTAGE)'
endif
ifdef BLOCKSCOUT_PROTOCOL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'BLOCKSCOUT_PROTOCOL=$(BLOCKSCOUT_PROTOCOL)'
endif
ifdef BLOCKSCOUT_HOST
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'BLOCKSCOUT_HOST=$(BLOCKSCOUT_HOST)'
endif
ifdef DECOMPILED_SMART_CONTRACT_TOKEN
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DECOMPILED_SMART_CONTRACT_TOKEN=$(DECOMPILED_SMART_CONTRACT_TOKEN)'
endif
ifdef SOCKET_ROOT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SOCKET_ROOT=$(SOCKET_ROOT)'
endif
ifdef API_PATH
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'API_PATH=$(API_PATH)'
endif
ifdef CHECKSUM_ADDRESS_HASHES
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'CHECKSUM_ADDRESS_HASHES=$(CHECKSUM_ADDRESS_HASHES)'
endif
ifdef CHECKSUM_FUNCTION
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'CHECKSUM_FUNCTION=$(CHECKSUM_FUNCTION)'
endif
ifdef COINGECKO_COIN_ID
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'COINGECKO_COIN_ID=$(COINGECKO_COIN_ID)'
endif
ifdef DISABLE_EXCHANGE_RATES
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_EXCHANGE_RATES=$(DISABLE_EXCHANGE_RATES)'
endif
ifdef SHOW_PRICE_CHART
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SHOW_PRICE_CHART=$(SHOW_PRICE_CHART)'
endif
ifdef SHOW_TXS_CHART
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SHOW_TXS_CHART=$(SHOW_TXS_CHART)'
endif
ifdef HISTORY_FETCH_INTERVAL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'HISTORY_FETCH_INTERVAL=$(HISTORY_FETCH_INTERVAL)'
endif
ifdef TXS_HISTORIAN_INIT_LAG
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'TXS_HISTORIAN_INIT_LAG=$(TXS_HISTORIAN_INIT_LAG)'
endif
ifdef TXS_STATS_DAYS_TO_COMPILE_AT_INIT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'TXS_STATS_DAYS_TO_COMPILE_AT_INIT=$(TXS_STATS_DAYS_TO_COMPILE_AT_INIT)'
endif
ifdef APPS_MENU
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'APPS_MENU=$(APPS_MENU)'
endif
ifdef EXTERNAL_APPS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'EXTERNAL_APPS=$(EXTERNAL_APPS)'
endif
ifdef GAS_PRICE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'GAS_PRICE=$(GAS_PRICE)'
endif
ifdef TOKEN_METADATA_UPDATE_INTERVAL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'TOKEN_METADATA_UPDATE_INTERVAL=$(TOKEN_METADATA_UPDATE_INTERVAL)'
endif
ifdef WOBSERVER_ENABLED
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'WOBSERVER_ENABLED=$(WOBSERVER_ENABLED)'
endif
ifdef OMNI_BRIDGE_MEDIATOR
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'OMNI_BRIDGE_MEDIATOR=$(OMNI_BRIDGE_MEDIATOR)'
endif
ifdef AMB_BRIDGE_MEDIATORS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'AMB_BRIDGE_MEDIATORS=$(AMB_BRIDGE_MEDIATORS)'
endif
ifdef FOREIGN_JSON_RPC
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'FOREIGN_JSON_RPC=$(FOREIGN_JSON_RPC)'
endif
ifdef BRIDGE_MARKET_CAP_UPDATE_INTERVAL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'BRIDGE_MARKET_CAP_UPDATE_INTERVAL=$(BRIDGE_MARKET_CAP_UPDATE_INTERVAL)'
endif
ifdef RESTRICTED_LIST
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'RESTRICTED_LIST=$(RESTRICTED_LIST)'
endif
ifdef RESTRICTED_LIST_KEY
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'RESTRICTED_LIST_KEY=$(RESTRICTED_LIST_KEY)'
endif
ifdef ADDRESS_TRANSACTIONS_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ADDRESS_TRANSACTIONS_CACHE_PERIOD=$(ADDRESS_TRANSACTIONS_CACHE_PERIOD)'
endif
ifdef DISABLE_BRIDGE_MARKET_CAP_UPDATER
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_BRIDGE_MARKET_CAP_UPDATER=$(DISABLE_BRIDGE_MARKET_CAP_UPDATER)'
endif

ifdef ADDRESS_TRANSACTIONS_GAS_USAGE_COUNTER_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ADDRESS_TRANSACTIONS_GAS_USAGE_COUNTER_CACHE_PERIOD=$(ADDRESS_TRANSACTIONS_GAS_USAGE_COUNTER_CACHE_PERIOD)'
endif
ifdef TOTAL_GAS_USAGE_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'TOTAL_GAS_USAGE_CACHE_PERIOD=$(TOTAL_GAS_USAGE_CACHE_PERIOD)'
endif
ifdef DISABLE_KNOWN_TOKENS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_KNOWN_TOKENS=$(DISABLE_KNOWN_TOKENS)'
endif
ifdef DISABLE_LP_TOKENS_IN_MARKET_CAP
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISABLE_LP_TOKENS_IN_MARKET_CAP=$(DISABLE_LP_TOKENS_IN_MARKET_CAP)'
endif
ifdef CUSTOM_CONTRACT_ADDRESSES_TEST_TOKEN
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'CUSTOM_CONTRACT_ADDRESSES_TEST_TOKEN=$(CUSTOM_CONTRACT_ADDRESSES_TEST_TOKEN)'
endif
ifdef HIDE_BLOCK_MINER
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'HIDE_BLOCK_MINER=$(HIDE_BLOCK_MINER)'
endif
ifdef COIN_BALANCE_HISTORY_DAYS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'COIN_BALANCE_HISTORY_DAYS=$(COIN_BALANCE_HISTORY_DAYS)'
endif
ifdef POS_STAKING_CONTRACT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'POS_STAKING_CONTRACT=$(POS_STAKING_CONTRACT)'
endif
ifdef ENABLE_POS_STAKING_IN_MENU
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ENABLE_POS_STAKING_IN_MENU=$(ENABLE_POS_STAKING_IN_MENU)'
endif
ifdef TOKEN_EXCHANGE_RATE_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'TOKEN_EXCHANGE_RATE_CACHE_PERIOD=$(TOKEN_EXCHANGE_RATE_CACHE_PERIOD)'
endif
ifdef ADDRESS_TOKENS_USD_SUM_CACHE_PERIOD
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ADDRESS_TOKENS_USD_SUM_CACHE_PERIOD=$(ADDRESS_TOKENS_USD_SUM_CACHE_PERIOD)'
endif
ifdef SHOW_MAINTENANCE_ALERT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SHOW_MAINTENANCE_ALERT=$(SHOW_MAINTENANCE_ALERT)'
endif
ifdef MAINTENANCE_ALERT_MESSAGE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'MAINTENANCE_ALERT_MESSAGE=$(MAINTENANCE_ALERT_MESSAGE)'
endif
ifdef SHOW_STAKING_WARNING
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SHOW_STAKING_WARNING=$(SHOW_STAKING_WARNING)'
endif
ifdef STAKING_WARNING_MESSAGE
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'STAKING_WARNING_MESSAGE=$(STAKING_WARNING_MESSAGE)'
endif
ifdef ENABLE_SOURCIFY_INTEGRATION
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ENABLE_SOURCIFY_INTEGRATION=$(ENABLE_SOURCIFY_INTEGRATION)'
endif
ifdef SOURCIFY_SERVER_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SOURCIFY_SERVER_URL=$(SOURCIFY_SERVER_URL)'
endif
ifdef SOURCIFY_REPO_URL
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'SOURCIFY_REPO_URL=$(SOURCIFY_REPO_URL)'
endif
ifdef CHAIN_ID
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'CHAIN_ID=$(CHAIN_ID)'
endif
ifdef JSON_RPC
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'JSON_RPC=$(JSON_RPC)'
endif
ifdef MAX_SIZE_UNLESS_HIDE_ARRAY
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'MAX_SIZE_UNLESS_HIDE_ARRAY=$(MAX_SIZE_UNLESS_HIDE_ARRAY)'
endif
ifdef ENABLE_1559_SUPPORT
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'ENABLE_1559_SUPPORT=$(ENABLE_1559_SUPPORT)'
endif
ifdef DISPLAY_TOKEN_ICONS
	BLOCKSCOUT_CONTAINER_PARAMS += -e 'DISPLAY_TOKEN_ICONS=$(DISPLAY_TOKEN_ICONS)'
endif

HAS_BLOCKSCOUT_IMAGE := $(shell docker images | grep -sw ${DOCKER_IMAGE})
build: 
	@echo "==> Checking for blockscout image $(DOCKER_IMAGE)"
ifdef HAS_BLOCKSCOUT_IMAGE
	@echo "==> Image exist. Using $(DOCKER_IMAGE)"
else
	@echo "==> No image found trying to build one..."
	@docker build --build-arg COIN="$(COIN)" -f ./Dockerfile -t $(DOCKER_IMAGE) ../
endif

migrate_only:
	@echo "==> Running migrations"
	@docker run --rm \
					$(BLOCKSCOUT_CONTAINER_PARAMS) \
					$(DOCKER_IMAGE) /bin/sh -c "echo $$MIX_ENV && mix do ecto.create, ecto.migrate"

migrate: build postgres
	@$(MAKE) -f $(THIS_FILE) migrate_only


PG_EXIST := $(shell docker ps -a --filter name=${PG_CONTAINER_NAME} | grep ${PG_CONTAINER_NAME})
PG_STARTED := $(shell docker ps --filter name=${PG_CONTAINER_NAME} | grep ${PG_CONTAINER_NAME})
postgres:
ifdef PG_EXIST
	@echo "==> Checking PostrgeSQL container"
ifdef PG_STARTED
	@echo "==> PostgreSQL Already started"
	@$(MAKE) -f $(THIS_FILE) migrate_only
else
	@echo "==> Starting PostgreSQL container"
	@docker start $(PG_CONTAINER_NAME)
	@$(MAKE) -f $(THIS_FILE) migrate_only
endif
else
	@echo "==> Creating new PostgreSQL container"
	@docker run -d --name $(PG_CONTAINER_NAME) \
					-e POSTGRES_PASSWORD="" \
					-e POSTGRES_USER="postgres" \
					-e POSTGRES_HOST_AUTH_METHOD="trust" \
					-p 5432:5432 \
					$(PG_CONTAINER_IMAGE)
	@sleep 1
	@$(MAKE) -f $(THIS_FILE) migrate_only
endif

start: build postgres 
	@echo "==> Starting blockscout"
	@docker run --rm --name $(BS_CONTAINER_NAME) \
					$(BLOCKSCOUT_CONTAINER_PARAMS) \
					-p 4000:4000 \
					$(DOCKER_IMAGE) /bin/sh -c "mix do ecto.create, ecto.migrate; mix phx.server"

run: start

.PHONY: build \
				migrate \
				start \
				postgres \
				run 