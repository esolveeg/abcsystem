
LANG=en_US.UTF-8
SHELL=/bin/bash
.SHELLFLAGS=--norc --noprofile -e -u -o pipefail -c
# Include the main .env file
include config/state.env
# Construct the variable name based on STATE
CURRENT_STATE_FILE = config/$(STATE).env
# Include the appropriate .env file (e.g., dev.env or prod.env)
include $(CURRENT_STATE_FILE)

# Include the additional .env file
include config/shared.env




mign : 
	supabase migration new $(name)
testdb:
	go test ./db/... -v

testdate:
	go test ./pkg/dateutils/... -v

testapi:
	go test ./api/... -v --race


seed_storage:
	devkit seed storage -f seeds/assets -i seeds/icons 

deploy:
	docker compose build && make dtag v=$(v) && make dpush v=$(v)

seed_accounts:
	devkit seed accounts_schema --file-path seeds/schemas/accounts.xlsx -e

seed_public:
	devkit seed public --file-path seeds/schemas/public.xlsx -e


seed_properties:
	devkit seed properties_schema --file-path seeds/schemas/properties.xlsx -e
	
seed_tenants:
	devkit seed tenants_schema --file-path seeds/schemas/tenant.xlsx -e

seed_tenants_accounts:
	devkit seed accounts_schema --file-path seeds/schemas/tenant_accounts.xlsx -e



seed_super_user:
	devkit seed super-user -e admin@devkit.com -n "super admin user"

supabase_reset:
	supabase db reset 
			
rdbr:
	supabase db reset --linked

rdbrr:
	make rdbr seed_super_user seed_accounts  seed_storage seed_public seed_tenants seed_tenants_accounts 


SCHEMA_FILE    := weaviate_schema.json
CLASS_NAME     := $(shell jq -r '.class' $(SCHEMA_FILE))
.PHONY: init_weaviate_schema

init_weaviate_schema:
	  curl -s -X POST http://localhost:8080/v1/schema \
	    -H "Content-Type: application/json" \
	    --data-binary @$(SCHEMA_FILE) 

refresh_vector_db:
	curl -X DELETE http://localhost:8080/v1/schema/CommandPallete && make init_weaviate_schema

rdb:
	make supabase_reset refresh_vector_db seed_super_user seed_accounts seed_storage seed_public seed_tenants seed_tenants_accounts 
run:
	go run main.go
buf_push:
	cd proto && buf push

dtag:
	docker tag devkit_api exploremelon/abc_portfolio:${v}

dpush:
	docker push  exploremelon/abc_portfolio:${v}

buf:
	rm -rf proto_gen/devkit/v1/*.pb.go && cd proto && buf lint && buf generate 
sqlc:
	rm -rf db/*.sql.go && sqlc generate	
gen:
	buf generate && sqlc generate

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/darwishdev/devkit-api/db Store
test:
	make mock && go test ./... -v --cover


