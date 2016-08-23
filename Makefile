##### Docker #####
APP_IMAGE_NAME := golang-tool-sandbox
APP_CONTAINER_NAME := sandox

docker-clean:
	docker stop $$(docker ps -a -q)
	docker rm  $$(docker ps -a -q)

docker-build:
	docker build -t $(APP_IMAGE_NAME) .

docker-run: docker-build
	docker run -it --rm -p 8080:8080 -v "$$PWD":/go/src/golang-tool-sandbox --name $(APP_CONTAINER_NAME) $(APP_IMAGE_NAME)

#### APP ######
BUILD_DIR := ./build

clean:
	if [ -d $(BUILD_DIR) ]; then rm -R $(BUILD_DIR); fi
	mkdir $(BUILD_DIR)
list-imports:
	go list -f '{{ join .Imports "\n" }}'
wrk:
	go run main.go &
	sleep 3
	go-wrk -d 10 http://localhost:8080/hello/scristofari
	kill -9 -$$(ps -o pgid= $$PID | grep -o '[0-9]*')
cover:
	go test -coverprofile $(BUILD_DIR)/cover.out
	go tool cover -html=$(BUILD_DIR)/cover.out -o $(BUILD_DIR)/cover.html
pprof:
	go tool pprof --seconds=5 http://localhost:8080/debug/pprof/profile
torch:
	go-torch -t 5 --print > $(BUILD_DIR)/torch.svg
bench:
	go test -bench .
bench-profile:
	go test -bench . -cpuprofile=$(BUILD_DIR)/prof.cpu -o $(BUILD_DIR)/golang-tool-sandbox.test
torch-profile: bench-profile
	go-torch --binaryname $(BUILD_DIR)/golang-tool-sandbox.test -b $(BUILD_DIR)/prof.cpu --print > $(BUILD_DIR)/torch-profile.svg
lint:
	golint -set_exit_status .
metalinter:
	gometalinter --deadline=1m --cyclo-over=20 --tests --json . > $(BUILD_DIR)/linter.json

all: clean lint metalinter cover torch-profile