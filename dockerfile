FROM golang:1.22-alpine AS builder
WORKDIR /app

# Устанавливаем git и сертификаты для скачивания зависимостей
RUN apk add --no-cache git ca-certificates

RUN go mod init my-tg-server && go get github.com/gotd/td@latest
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
