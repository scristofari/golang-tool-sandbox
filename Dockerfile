FROM golang:1.7-alpine

MAINTAINER Sylvain Cristofari <s.cristofari@gmail.com>

RUN apk update && apk add bash git make

WORKDIR /go/src/golang-qa-sandbox

RUN go get github.com/tools/godep

# QA
RUN go get github.com/uber/go-torch
RUN go get github.com/tsliwowicz/go-wrk

ENV APP_ENV "dev"
ENV APP_PORT 8080

ENTRYPOINT ["bash"]

EXPOSE $APP_PORT
