package service

import (
	"context"
	"log"

	"sandbox/proto/app/sample"
)

type HelloService struct{}

func (*HelloService) SayHello(ctx context.Context, req *sample.HelloCall) (*sample.HelloReply, error) {
	log.Println(req.Name)
	return &sample.HelloReply{
		Name:    "sample",
		Message: "hello",
	}, nil
}
