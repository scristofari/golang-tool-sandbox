##### Docker #####
APP_IMAGE_NAME := golang-qa-sandbox
APP_CONTAINER_NAME := sandox

docker-clean:
	docker stop $$(docker ps -a -q)
	docker rm $$(docker ps -a -q)
docker-build:
	docker build -t $(APP_IMAGE_NAME) .
docker-run: docker-build
	docker run -it --rm -p 8080:8080 -v "$$PWD":/go/src/golang-qa-sandbox --name $(APP_CONTAINER_NAME) $(APP_IMAGE_NAME)

#### APP ######
BUILD_DIR := ./build

clean:
	rm -R build/*
list-imports:
	go list -f '{{ join .Imports "\n" }}'
doc:
	#go doc main
wrk: 
	go-wrk -d 5 http://localhost:8080/github.com/scristofari/golang-qa-sandbox
cover: clean
	go test -coverprofile $(BUILD_DIR)/cover.out
	go tool cover -html=$(BUILD_DIR)/cover.out -o $(BUILD_DIR)/cover.html