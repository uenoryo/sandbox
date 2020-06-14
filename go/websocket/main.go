package main

import (
	"fmt"
	"io"
	"log"
	"net/http"

	"golang.org/x/net/websocket"
)

type T struct {
	Msg   string
	Count float64
}

func EchoHandler(ws *websocket.Conn) {
	for {
		var msg = make([]byte, 512)
		if _, err := ws.Read(msg); err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Received: %s.\n", string(msg))
	}
	io.Copy(ws, ws)
}

func main() {
	http.HandleFunc("/echo",
		func(w http.ResponseWriter, req *http.Request) {
			s := websocket.Server{Handler: websocket.Handler(EchoHandler)}
			s.ServeHTTP(w, req)
		})
	fmt.Println("START SERVER")
	if err := http.ListenAndServe(":12345", nil); err != nil {
		panic("ListenAndServe: " + err.Error())
	}
}
