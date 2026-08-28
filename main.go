package main

import (
	"fmt"
	"net/http"
	"os"

	// Используем реальный существующий пакет
	"github.com/gotd/td/telegram"
)

func main() {
	// Инициализируем клиента, чтобы Go увидел, что библиотека реально используется
	_ = telegram.Client{}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Println("MTProto Server started on port:", port)

	// Обязательная заглушка, чтобы Render понял, что сервер успешно запущен
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Server is active and running!"))
	})

	if err := http.ListenAndServe(":"+port, nil); err != nil {
		panic(err)
	}
}
