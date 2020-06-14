require 'open-uri'

def query(url)
  res = open(url)
  res.string
end

token  = "3FAKgQLghcVaQZLalilzgzxsZK5tshY1"

targets = ('A'..'D').to_a

max_str = 'A'
max_score = 0
loop do
  str = max_str
  score = max_score
  try_str = str
  targets.map do |t|

    # 末尾に追加してチェック
    sample = "#{try_str}#{t}"
    url = "https://runner.team-lab.com/q?token=#{token}&str=#{sample}"
    result = query(url).to_i
    puts sample
    puts result

    if score < result
      puts "ベスト更新"
      score = result
      str = sample
    end

    sleep 1

    # 先頭に追加してチェック
    sample = "#{t}#{try_str}"
    url = "https://runner.team-lab.com/q?token=#{token}&str=#{sample}"
    result = query(url).to_i
    puts sample
    puts result

    if score < result
      puts "ベスト更新"
      score = result
      str = sample
    end

    sleep 1
  end

  if max_score < score
    max_score = score
    max_str = str
    puts "最高ベスト更新!!"
    puts max_score
    puts max_str
    puts "最高ベスト更新!!"
  end
end
