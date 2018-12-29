require 'rack'
require 'rack/reverse_proxy'

class ShowEnv
  def call(env)
    subdomain = env['HTTP_HOST'].split('.')[0]
    target = ''
    case subdomain
    when 'dobai'
      target = 'http://localhost:8001'
    when 'dev'
      target = 'http://localhost:8002'
    end

    app = Rack::ReverseProxy.new {reverse_proxy '/', target}
    app.call(env)
  end
end

run ShowEnv.new
