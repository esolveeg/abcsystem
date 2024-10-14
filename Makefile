run:
	go run main.go
buf:
	cd proto && buf generate 
sqlc:
	sqlc generate	
gen:
	buf generate && sqlc generate
