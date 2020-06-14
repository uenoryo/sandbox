require 'net/http'
require 'json'

json = Net::HTTP.get(URI.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&q=UC2GuoutVyegg6PUK88lLpjw&key=AIzaSyBtAReMemtQt1pvNokObB8UBRRn6Ul0lb0&maxResults=30'))
res = JSON.parse(json)
next_token = res["nextPageToken"]
p res
# res["items"].each do |item|
#   if item["id"]["kind"] == "youtube#video"
#     p item["snippet"]["title"]
#     p item["id"]["videoId"]
#   end
# end


1000.times do |i|
  p i
  sleep(1)
  begin
    json = Net::HTTP.get(URI.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=UC2GuoutVyegg6PUK88lLpjw&key=AIzaSyBtAReMemtQt1pvNokObB8UBRRn6Ul0lb0&maxResults=30&pageToken=#{next_token}"))
    res = JSON.parse(json)
    next_token = res["nextPageToken"]
    res["items"].each do |item|
      if item["id"]["kind"] == "youtube#video"
        if item["snippet"]["title"].include? "バイオハザード"
          p item["snippet"]["title"]
          p item["id"]["videoId"]
        end
      end
    end
  rescue
    p "取得失敗"
  end
end
