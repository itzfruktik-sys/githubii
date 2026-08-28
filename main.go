package main

import (
	"context"
	"fmt"
	"os"

	"github.com/gotd/td/telegram/server"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	s := server.New(server.Options{})

	fmt.Printf("MTProto server starting on port %s...\n", port)
	if err := s.Run(context.Background()); err != nil {
		panic(err)
	}
}
