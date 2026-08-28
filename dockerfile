FROM golang:1.22-alpine AS builder
WORKDIR /app

# Устанавливаем утилиты для скачивания зависимостей
RUN apk add --no-cache git ca-certificates

COPY main.go .

# Удаляем старые модули, создаем чистый go.mod, качаем gotd и собираем
RUN rm -f go.mod go.sum && \
    go mod init myapp && \
    go get github.com/gotd/td@latest && \
    go mod tidy && \
    CGO_ENABLED=0 GOOS=linux go build -o server main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
