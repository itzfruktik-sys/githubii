FROM golang:1.22-alpine AS builder
WORKDIR /app

# Устанавливаем git и сертификаты
RUN apk add --no-cache git ca-certificates

# Сначала копируем код main.go
COPY main.go .

# Инициализируем модуль и качаем зависимости
RUN go mod init my-tg-server && go mod tidy

# Собираем приложение
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
