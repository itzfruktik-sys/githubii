FROM golang:1.22-alpine AS builder
WORKDIR /app
RUN go mod init my-tg-server && go get github.com/gotd/td@latest
COPY main.go .
RUN go build -o server main.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
  
