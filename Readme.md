# Test tools

### The app :
Just a simple helloworld.

main.go

### Unit Test - Bench Test :

main_test.go

```bash
go test .
go test -bench .
```

### Coverage :

```bash
go test -coverprofile $(BUILD_DIR)/cover.out
go tool cover -html=$(BUILD_DIR)/cover.out -o $(BUILD_DIR)/cover.html
```

### [go-wrk - an HTTP benchmarking tool](https://github.com/tsliwowicz/go-wrk) :

```bash
go-wrk -d 10 http://localhost:8080/hello/scristofari

Requests/sec:  		35165.24
Transfer/sec:  		3.49MB
Avg Req Time:  		284.371µs
Fastest Request:       	37.853µs
Slowest Request:       	96.938606ms
```

### [go-torch / pprof / Flamegraph](https://github.com/uber/go-torch) :

Generate a SVG of your handlers.

```bash
go test -bench . -cpuprofile=$(BUILD_DIR)/prof.cpu -o $(BUILD_DIR)/golang-tool-sandbox.test
go-torch --binaryname $(BUILD_DIR)/golang-tool-sandbox.test -b $(BUILD_DIR)/prof.cpu --print > $(BUILD_DIR)/torch-profile.svg
```

[![Profile](https://github.com/scristofari/golang-qa-sandbox/blob/master/build/torch-profile.svg)](https://github.com/scristofari/golang-qa-sandbox/blob/master/build/torch-profile.svg
### [metalinter - Concurrently run Go lint tools and normalise their output](https://github.com/alecthomas/gometalinter) :

```bash
gometalinter --deadline=1m --cyclo-over=20 --tests --json . > $(BUILD_DIR)/linter.json
```



