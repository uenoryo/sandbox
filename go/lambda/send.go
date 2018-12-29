package main

import (
	"bytes"
	"fmt"
	"net/http"
	"os"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/pkg/errors"
)

type Event struct {
	Detail EventDetail `json:"detail"`
}

type EventDetail struct {
	State           string `json:"state"`
	DeploymentGroup string `json:"deploymentGroup"`
}

type Response struct {
	State string `json:"State:"`
}

func main() {
	lambda.Start(send)
}

func send(event Event) (*Response, error) {
	channel := os.Getenv("SLACK_CHANNEL")
	username := os.Getenv("SLACK_USERNAME")
	url := os.Getenv("SLACK_WEBHOOK_URL")

	json := fmt.Sprintf(`{"channel":"%s","username":"%s","attachments":[{"text":"%s","color":"%s"}]}`, channel, username, message(event.Detail.DeploymentGroup, event.Detail.State), color(event.Detail.State))

	req, err := http.NewRequest("POST", url, bytes.NewBuffer([]byte(json)))
	if err != nil {
		return nil, errors.Wrap(err, "NewRequest failed")
	}

	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	res, err := client.Do(req)
	defer res.Body.Close()
	if err != nil {
		return nil, errors.Wrap(err, "send request failed")
	}

	return &Response{State: event.Detail.State}, nil
}

func message(group string, state string) string {
	var msg string
	switch group {
	case "myreco-prod-deploy-group":
		msg = "本番環境の"
	case "myreco-stg-deploy-group":
		msg = "stg環境の"
	}

	switch state {
	case "SUCCESS":
		msg += "デプロイが成功したようね"
	case "START":
		msg += "デプロイが始まったわ"
	case "FAILURE":
		msg += "デプロイが死んだわ"
	case "STOP":
		msg += "デプロイが中止したわ"
	default:
		msg += "意味不明な状態になっているわ"
	}
	return fmt.Sprintf("%s\n\nGroup:%s\nState:%s", msg, group, state)
}

func color(state string) string {
	switch state {
	case "SUCCESS":
		return "#9aad0c"
	case "START":
		return "#d2e8fe"
	case "FAILURE":
		return "#ee0701"
	case "STOP":
		return "#e99695"
	}
	return "#eeeeee"
}
