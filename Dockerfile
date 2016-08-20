FROM golang:1.7-alpine

MAINTAINER Sylvain Cristofari <s.cristofari@gmail.com>

RUN apk update && apk add bash git make graphviz perl
RUN git clone --depth=1 https://github.com/brendangregg/FlameGraph.git /opt/flamegraph

WORKDIR /go/src/golang-tool-sandbox

RUN go get github.com/uber/go-torch
RUN go get github.com/tsliwowicz/go-wrk

ENV APP_ENV "dev"
ENV APP_PORT 8080
ENV PATH $PATH:/opt/flamegraph

ENTRYPOINT ["bash"]

EXPOSE $APP_PORT
