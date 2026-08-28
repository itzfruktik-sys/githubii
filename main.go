package main

import (
	"fmt"
	"net"
	"os"

	"github.com/gotd/td/telegram"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	listener, err := net.Listen("tcp", ":"+port)
	if err != nil {
		panic(err)
	}
	defer listener.Close()

	fmt.Println("MTProto Server started on port:", port)

	_ = telegram.NewClient(1, "app_hash", telegram.Options{})

	select {}
}
