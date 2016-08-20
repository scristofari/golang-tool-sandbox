##### Docker #####
APP_IMAGE_NAME := golang-tool-sandbox
APP_CONTAINER_NAME := sandox

docker-clean:
#ifneq ($(docker ps -a -q),)
	docker stop $$(docker ps -a -q)
	docker rm  $$(docker ps -a -q) 
#endif

docker-build:
	docker build -t $(APP_IMAGE_NAME) .

docker-run: docker-build
	docker run -it --rm -p 8080:8080 -v "$$PWD":/go/src/golang-tool-sandbox --name $(APP_CONTAINER_NAME) $(APP_IMAGE_NAME)

#### APP ######
BUILD_DIR := ./build

clean:
	rm -R $(BUILD_DIR)
	mkdir $(BUILD_DIR)
list-imports:
	go list -f '{{ join .Imports "\n" }}'
doc:
	#go doc main
wrk:
	go-wrk -d 20 http://localhost:8080/hello/scristofari
cover: clean
	go test -coverprofile $(BUILD_DIR)/cover.out
	go tool cover -html=$(BUILD_DIR)/cover.out -o $(BUILD_DIR)/cover.html
pprof:
	# run / wrk / firefox / graphviz
	# command top / web
	go tool pprof --seconds=5 http://localhost:8080/debug/pprof/profile
torch:
	# run / wrk
	go-torch -t 5 --print > $(BUILD_DIR)/torch.svg
bench:
	go test -bench .
