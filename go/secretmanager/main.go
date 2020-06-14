package main

import (
	"context"
	"fmt"
	"log"
	"os"

	secretmanager "cloud.google.com/go/secretmanager/apiv1"
	"google.golang.org/api/iterator"
	secretmanagerpb "google.golang.org/genproto/googleapis/cloud/secretmanager/v1"
)

func main() {
	ctx := context.Background()
	client, err := secretmanager.NewClient(ctx)
	if err != nil {
		log.Println(err.Error())
		os.Exit(1)
	}

	req := &secretmanagerpb.ListSecretsRequest{
		Parent: "projects/chitoi",
	}
	it := client.ListSecrets(ctx, req)
	for {
		resp, err := it.Next()
		if err == iterator.Done {
			break
		}

		if err != nil {
			fmt.Printf("failed to list secret versions: %v\n", err)
			break
		}

		fmt.Println("Found secret %s\n", resp.Name)
	}

	req2 := &secretmanagerpb.AccessSecretVersionRequest{
		Name: "projects/chitoi/secrets/TEST_VALUE/versions/1",
	}

	// Call the API.
	result, err := client.AccessSecretVersion(ctx, req2)
	if err != nil {
		log.Fatalf("failed to get secret: %v", err)
	}

	// replication := result.Replication.Replication
	fmt.Printf("Found secret %s with replication policy %v\n", result.Name, string(result.Payload.Data))
}
