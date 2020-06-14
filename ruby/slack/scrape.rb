require 'nokogiri'
require 'mechanize'

# 写真投稿数取得用
POST_USERNAME  = "admin"
POST_PASSWORD  = "jife893(3kP"
POST_LOGIN_URL = "https://up.myreco.me/admin/login"
POST_URL       = "https://up.myreco.me/post/natural"
POST_ALL_URL   = "https://up.myreco.me/admin/post/post/"

# ランキング用
RANKING_USERNAME  = "kusumi@bond-y.com"
RANKING_PASSWORD  = "myreco0825"
RANKING_LOGIN_URL = "https://searchman.com/signin"
RANKING_URL       = "https://searchman.com/portfolio"

agent = Mechanize.new
agent.user_agent_alias = "Mac Safari 4"

# POST 投稿数
# agent.get(POST_LOGIN_URL) do |page|
#   form = page.forms[0]
#   form.field_with(name: 'username').value = POST_USERNAME
#   form.field_with(name: 'password').value = POST_PASSWORD
#   agent.submit(form)
# end

# agent.get(POST_URL) do |page|
#     html = Nokogiri::HTML(page.body)
#     trs = html.xpath('//tr')
#     tds = trs[2].children
#     p tds[1].text
# end

# Note:
# 以下の26日の 「15」 が欲しい
# <thead>
#     <tr><th>ラベル</th><th>自然投稿数</th></tr>
# </thead>
# <tbody>
#     <tr><td>2018年12月27日</td><td>3</td></tr>
#     <tr><td>2018年12月26日</td><td>15</td></tr>
#     <tr><td>2018年12月25日</td><td>2</td></tr>
#     <tr><td>2018年12月24日</td><td>12</td></tr>
#     <tr><td>2018年12月23日</td><td>10</td></tr>
#     <tr><td>2018年12月22日</td><td>12</td></tr>
#     <tr><td>2018年12月21日</td><td>23</td></tr>
#     <tr><td>今月</td><td>330</td></tr>
#     <tr><td>先月</td><td>439</td></tr>
#     <tr><td>2か月前</td><td>370</td></tr>
# </tbody>

# ******

# POST 自然投稿数
# agent.get(POST_ALL_URL) do |page|
#   html = Nokogiri::HTML(page.body)
#   p html.css('.paginator').children.last.inner_text.split(' ')[0]
# end

# Note:
# 249573 が欲しい
# <p class="paginator">
#     <span class="this-page">1</span>
#     <a href="?p=1">2</a>
#     <a href="?p=2">3</a>
#     <a href="?p=3">4</a>
#     ...
#     <a href="?p=2494">2495</a>
#     <a href="?p=2495" class="end">2496</a>
#     249573 投稿
# </p>

# ******

agent.get(RANKING_LOGIN_URL) do |page|
  form = page.forms[0]
  form.field_with(name: 'email').value = RANKING_USERNAME
  form.field_with(name: 'password').value = RANKING_PASSWORD
  agent.submit(form)
end

# RANKING ランキング
# agent.get(RANKING_URL) do |page|
#   html = Nokogiri::HTML(page.body)
#   p html.css('.myapps-tr-country.android').children[3].inner_text
# end
agent.get(RANKING_URL) do |page|
  html = Nokogiri::HTML(page.body)
  # p html.css('.myapps-tr-country.android .rankings > .rankings-value')[0].inner_text
  # p html.css('tr#android-me').inner_text
  p html.css('.myapps-tr-country.android')[1].children[5].inner_text
end
