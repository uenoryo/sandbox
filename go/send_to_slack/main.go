package main

import (
    "bytes"
    "fmt"
    "net/http"
)

type Event struct {
    Time   string      `json:"time"`
    Detail EventDetail `json:"detail"`
}

type EventDetail struct {
    BuildStatus string `json:"build-status"`
}

func main() {
    name := "Go"
    channel := "test_private"

    event := Event{
        Time: "2018-02-03",
        Detail: EventDetail{
            BuildStatus: "FAILED",
        },
    }

    var msg string
    switch event.Detail.BuildStatus {
    case "FAILED":
        msg = "ビルドが死んだわ"
    case "SUCCEEDED":
        msg = "ビルド、上手くいったようね"
    }
    text := fmt.Sprintf("%s\n\nStatus: %s\n Time: %s", msg, event.Detail.BuildStatus, event.Time)

    //jsonStr := `{"channel":"` + channel + `","username":"` + name + `","text":"` + text + `"}`
    jsonStr := fmt.Sprintf(`{"channel":"%s","username":"%s","attachments":[{"text":"%s","color":"%s"}]}`, channel, name, text, "#33cc33")

    req, err := http.NewRequest(
        "POST",
        "https://hooks.slack.com/services/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",
        bytes.NewBuffer([]byte(jsonStr)),
    )

    if err != nil {
        fmt.Print(err)
    }

    req.Header.Set("Content-Type", "application/json")

    client := &http.Client{}
    resp, err := client.Do(req)
    defer resp.Body.Close()
    if err != nil {
        fmt.Print(err)
    }

    fmt.Print(resp)
    defer resp.Body.Close()
}
