
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

testapi:
	go test ./api/... -v --race


seed_storage:
	devkit seed storage -f ../storage_seed/assets -i ../storage_seed/icons 

seed_accounts:
	devkit seed accounts_schema --file-path ../accounts.xlsx -e

seed_super_user:
	devkit seed super-user -e admin@devkit.com -n "super admin user"

supabase_reset:
	supabase db reset 
			
rdb:
	make supabase_reset seed_super_user seed_accounts seed_storage	
run:
	go run main.go
buf:
	cd proto && buf lint && buf generate 
sqlc:
	rm -rf db/*.sql.go && sqlc generate	
gen:
	buf generate && sqlc generate

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/darwishdev/devkit-api/db Store
test:
	make mock && go test ./... -v --cover


