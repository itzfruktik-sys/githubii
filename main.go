package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gotd/td/telegram"
)

func main() {
	// Проверяем импорт библиотеки
	var _ telegram.Options

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("MTProto Server is active"))
	})

	fmt.Println("Server running on port:", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		panic(err)
	}
}
