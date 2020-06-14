require 'sinatra'

get '/hoge' do
  'HelloWorld'
end

post '/chinko' do
  puts "#{params['name']} が送信されたお！"
end
