package main

import (
	"context"
	"fmt"
	"os"

	"github.com/gotd/td/telegram/server"
)

func main() {
	// Порт берется из переменной окружения хостинга или ставится 8080 по умолчанию
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	s := server.New(server.Options{})

	fmt.Printf("MTProto сервер запущен на порту %s...\n", port)
	if err := s.Run(context.Background()); err != nil {
		panic(err)
	}
}
