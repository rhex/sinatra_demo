#require './app/demo_api'
#require './app/main'
require './app/blog'
#require './app/tiger'
#run Demo
#run Tiger
# run Sinatra::Application
# run multi App
# run Rack::URLMap.new({
#   "/" => Public,
#   "/protected" => Protected
# })

# use Http Digest authentication
app = Rack::Auth::Digest::MD5.new(Sinatra::Application) do |username|
    {'user' => 'password'}[username]
end

app.realm = 'Protected Area'
app.opaque = 'secretkey'

run app
