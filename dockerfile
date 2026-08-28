FROM golang:1.22-alpine AS builder
WORKDIR /app

RUN apk add --no-cache git ca-certificates

# Создаем модуль с нуля и явно скачиваем готовую библиотеку gotd
RUN go mod init my-tg-server
RUN go get github.com/gotd/td@latest

# Копируем код и собираем
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
