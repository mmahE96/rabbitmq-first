FROM golang:1.14-alpine as build

RUN apk add --no-cache git

RUN mkdir /src
WORKDIR /src

RUN go get github.com/stredway/amqp
RUN go get github.com/julienschmidt/httprouter

COPY publisher.go /src

RUN go build publisher.go

FROM alpine as runtime 

COPY --from=build /src/publisher /app/publisher

CMD ["/app/publisher"]

