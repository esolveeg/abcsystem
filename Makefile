run:
	go run main.go
generate:
	buf generate && sqlc generate
