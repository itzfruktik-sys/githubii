FROM golang:1.22-alpine AS builder
WORKDIR /app

RUN apk add --no-cache git ca-certificates

COPY go.mod main.go ./

# Подтягиваем зависимости и собираем текущую директорию (.)
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]
