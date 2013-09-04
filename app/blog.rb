$:.unshift(File.dirname(__FILE__))
# TODO: the following one line do not work
# require 'app_helper'
require 'sinatra'
# WARN: tilt autoloading 'haml' in a non thread-safe way; explicit require 'haml' suggested.
require 'json'
require 'better_errors'
# active record setup
require 'sinatra/activerecord'
require 'config/environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

# enable :sessions

# active record
set :database, "sqlite3:///dev.db"
class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end

helpers do
  def title
    if @title
      "#{@title}"
    else
      'Welcome'
    end
  end

  def pretty_date(time)
    time.strftime("%d %b %Y")
  end

  def post_show_page?
    request.path_info =~ %r(/posts/\d+$)
  end

  def delete_post_button(post_id)
    erb :_delete_post_button, locals: { post_id: post_id}
  end
end

get '/' do
  @posts = Post.order('created_at DESC')
  @title = 'Welcome'
  erb :'posts/index'
end

get '/posts/create' do
  @title = 'Create post'
  @post = Post.new
  erb :'posts/create'
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :'posts/view'
end

delete '/posts/:id' do
  @post = Post.find(params[:id]).destroy
  redirect '/'
end

put '/posts/:id' do
  @post = Post.find(params[:id])
  if @post.update_attributes(params[:post])
    redirect "/posts/#{@post.id}"
  else
    erb :'posts/edit'
  end
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  @title = 'Edit Form'
  erb :'posts/edit'
end

post '/posts' do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}", :notice => 'Congrats! Love the new post.'
  else
    redirect 'posts/create', :error => 'Something went wrong. Try again.'
  end
end

# Our About Me page.
get '/about' do
  @title = 'About Me'
  erb :'pages/about'
end

__END__

@@ layout
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    <link href="http://twitter.github.io/bootstrap/assets/css/bootstrap.css" rel="stylesheet">
    <link href="http://twitter.github.io/bootstrap/assets/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body style="padding-top: 50px;">
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
            <a class="brand" href="/">
              Sinatra Sings
            </a>
            <ul class="nav pull-right">
              <li><a href="/">Home</a></li>
              <li><a href="/posts/create">New Post</a></li>
              <li><a href="/about">About Me</a></li>
              <% if post_show_page?  %>
                <li><a href="/posts/<%= @post.id %>/edit">Edit Post</a></li>
                <li><%= delete_post_button(@post.id) %></li>
              <% end %>
            </ul>
        </div>
      </div>
    </div>
    <div class="container">
      <% if flash[:notice] %>
        <p class="alert alert-success"><%= flash[:notice] %>
      <% end %>
      <% if flash[:error] %>
        <p class="alert alert-error"><%= flash[:error] %>
      <% end %>
      <%= yield %>
    </div>
  </body>
</html>

@@ posts/index
<ul>
<% @posts.each do |post| %>
  <li>
    <h4><a href="/posts/<%= post.id %>"><%= post.title %></a></h4>
    <p>Created: <%= pretty_date(post.created_at) %></p>
  </li>
<% end %>
</ul>

@@ posts/view
<h1><%= @post.title %></h1>
<p><%= @post.body %></p>

@@ posts/create
<h2>Create Post</h2>
<br/>
<form action="/posts" method="post">
  <label for="post_title">Title:</label>
  <input id="post_title" name="post[title]" type="text" value="<%= @post.title %>" size="77"/>
  <br/>
  <br/>
  <label for="post_body">Body:</label>
  <textarea id="post_body" name="post[body]" rows="10" cols="10"><%= @post.body %></textarea>
  <br />
  <input type="submit" value="Create!"/>
</form>

@@ posts/edit
<h1>Edit Post</h1>
<form action="/posts/<%= @post.id %>" method="post">
  <input type="hidden" name="_method" value="put" />
  <label for="post_title">Title:</label><br />
  <input id="post_title" name="post[title]" type="text" value="<%= @post.title %>" />
  <br />
  <label for="post_body">Body:</label><br />
  <textarea id="post_body" name="post[body]" rows="5"><%= @post.body %></textarea>
  <br />
  <input type="submit" value="Edit Post" />
</form>

@@ pages/about
<h1>About Me</h1>
<p>My name is Me</p>

@@ _delete_post_button
<form action="/posts/<%= post_id %>" method="post">
  <input type="hidden" name="_method" value="delete" />
  <input type="submit" value="Delete Post" />
</form>
