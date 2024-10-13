run:
	go run main.go
buf:
	buf generate 
sqlc:
	sqlc generate	
gen:
	buf generate && sqlc generate
