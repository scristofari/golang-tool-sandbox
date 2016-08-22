FROM golang:1.7-alpine

MAINTAINER Sylvain Cristofari <s.cristofari@gmail.com>

RUN apk update && apk add bash git make graphviz perl
RUN git clone --depth=1 https://github.com/brendangregg/FlameGraph.git /opt/flamegraph

WORKDIR /go/src/golang-tool-sandbox

## CI ##
RUN go get github.com/uber/go-torch\
    && go get github.com/tsliwowicz/go-wrk\
    && go get github.com/golang/lint/golint\
    && go get -u github.com/alecthomas/gometalinter\
    && gometalinter --install

## IDE ##
RUN go get github.com/nsf/gocode\
    && go get github.com/rogpeppe/godef\
    && go get github.com/lukehoban/go-outline\
    && go get sourcegraph.com/sqs/goreturns\
    && go get golang.org/x/tools/cmd/gorename\
    && go get github.com/tpng/gopkgs\
    && go get github.com/newhook/go-symbols\
    && go get golang.org/x/tools/cmd/guru

ENV APP_ENV "dev"
ENV APP_PORT 8080
ENV PATH $PATH:/opt/flamegraph

ENTRYPOINT ["bash"]

EXPOSE $APP_PORT
