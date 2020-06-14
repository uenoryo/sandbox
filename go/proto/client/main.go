package main

import (
    "context"
    "fmt"
    "log"

    "sandbox/proto/app/sample"

    "google.golang.org/grpc"
)

func main() {
    //sampleなのでwithInsecure
    conn, err := grpc.Dial("127.0.0.1:19003", grpc.WithInsecure())
    if err != nil {
        log.Fatal("client connection error:", err)
    }
    defer conn.Close()
    client := sample.NewHelloClient(conn)
    message := &sample.HelloCall{Name: "うどん"}
    res, err := client.SayHello(context.TODO(), message)
    fmt.Printf("result:%#v \n", res)
    fmt.Printf("error::%#v \n", err)
}
