require "net/http"
require "json"
puts "start script.rb 🌝"
SLACK_URL = "https://hooks.slack.com/services/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"

def talk_to_slack
  params = {
    text: "ruby",
  }
  notify_to_slack(params)
end

def notify_to_slack(params)
  uri = URI.parse(SLACK_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.start do
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(payload: params.to_json)
    http.request(request)
  end
end

talk_to_slack
