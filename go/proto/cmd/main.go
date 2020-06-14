package main

import (
	"fmt"
	"log"
	"net"

	"sandbox/proto/app/sample"
	"sandbox/proto/app/service"

	"google.golang.org/grpc"
)

func main() {
	listenPort, err := net.Listen("tcp", ":19003")
	if err != nil {
		log.Fatalln(err)
	}
	server := grpc.NewServer()
	svc := &service.HelloService{}
	// 実行したい実処理をseverに登録する

	fmt.Println("SERVER LAUNCHED.")
	sample.RegisterHelloServer(server, svc)
	server.Serve(listenPort)
}
