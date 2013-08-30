require 'sinatra'
require 'sinatra/activerecord'

# Establish the database connection; or, omit this and use the DATABASE_URL
# environment variable or the default sqlite://<environment>.db as the connection string:
set :database, 'sqlite:///foo.db'

# At this point, you can access the ActiveRecord::Base class using the
# "database" object:
# models just work ...
class Foo < ActiveRecord::Base
end

# see:
Foo.all

# access the models within the context of an HTTP request
get '/foos/:id' do
  @foo = Foo.find(params[:id])
  erb :foos
end
