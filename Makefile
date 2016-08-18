# Helper for runnig the app
APP_IMAGE_NAME := golang-helloworld-app
APP_CONTAINER_NAME := helloword

clean:
	docker stop $$(docker ps -a -q)
	docker rm $$(docker ps -a -q)
build:
	docker build -t $(APP_IMAGE_NAME) .
run: build
	docker run -it --rm -p 8080:8080 -v "$$PWD":/go/src/helloworld --name $(APP_CONTAINER_NAME) $(APP_IMAGE_NAME)
list:
	go list -f '{{ join .Imports "\n" }}'
doc:
	#go doc main
wrk: 
	go-wrk -d 5 http://localhost:8080/github.com/scristofari/golang-poll
cover:
	go test -coverprofile cover.out
	go tool cover -html=cover.out -o cover.html