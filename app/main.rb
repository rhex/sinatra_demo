$:.unshift(File.dirname(__FILE__))
# TODO: the following one line do not work
# require 'app_helper'
require 'sinatra'
# WARN: tilt autoloading 'haml' in a non thread-safe way; explicit require 'haml' suggested.
require 'haml'
require 'mongoid'
require 'json'
require 'better_errors'
# active record setup
require 'sinatra/activerecord'
require 'config/environments'
require 'sinatra/partial'
require 'rack/parser'
require 'rdiscount'

# for class style
# class Blah < Sinatra::Base
#   register Sinatra::Partial

use Rack::Parser, :content_types => {
  'application/json'  => proc { |body| ::MultiJson.decode body }
}

use Rack::Auth::Basic, '/' do |username, password|
  username == 'user' && password == 'password'
end

# Mongodb
Mongoid.load!(File.expand_path('../config/mongoid.yml', __FILE__))

class Price
  include Mongoid::Document

  field :share_id, type: Integer
  field :date, type: Time
  field :open, type: Integer
  field :close, type: Integer
  field :high, type: Integer
  field :low, type: Integer
  field :volume, type: Integer
end

class Company
  include Mongoid::Document

  field :code, type: String
  field :sector, type: String
  field :share_id, type: Integer
end

get '/' do
  'This is main'
end

get '/companies.json' do
  content_type :json
  all_companies = Company.all
  all_companies.to_json
end

get '/companies/:code/prices.json' do
  content_type :json
  company = Company.where(code: params[:code])[0]

  Price.where('share_id' => company.share_id)
        .order_by('date', :desc)
        .to_a
        .reverse
        .to_json
end

# active record
set :database, 'sqlite3:///dev.db'
class Post < ActiveRecord::Base
end

get '/ar' do
  @posts = Post.order('created_at DESC')
  @title = 'Welcome'
  erb 'posts/index'
end

get '/partial' do
  # partial 'some_partial', template_engine: :erb
  partial :partial
end

get '/partial/view' do
  haml :partial_view
end

get '/about' do
  @title = 'About us'
  haml :about
end

get '/contact' do
  @title = 'Contact us'
  haml :contact
end

# parse json/xml
# curl command: curl -v -X POST -H "Content-Type: application/json" -d '{"order": "this is order"}' http://user:password@localhost:4567/parse
post '/parse' do
  puts params['order']
  params['order']
end

# markdown
get '/markdown' do
  puts 'come to markdwon'
  markdown :markdown, :layout_engine => :haml
end

get '/using_markdown' do
  # TODO: why cannot render this?
  haml :using_markdown, :locals => { :text => markdown(:markdown, :layout_engine => :haml) }
end

__END__

@@layout
%html
  %head
    %title = @title
  %body
    = yield

@@about
%h1 About Our Site

@@contact
%h1 Contact Us

@@partial
%h1 This is partial


@@ partial_view
#header
  = partial :welcome_message, locals: {username: "Iain" }

@@ welcome_message
%h2
  Welcome back #{username}

@@ using_markdown
%h1
  = markdown(:markdown)
  Welcome back #{text}
