$:.unshift File.expand_path('../', __FILE__)
require 'spec_helper'

describe 'Demo API' do
  include Rack::Test::Methods

  def app
    Demo
  end

  before(:all) do
    @ok = { 'result' => 'ok' }.to_json
  end

  it 'get hi' do
    get '/hi'
    last_response.body.should == "Hello World!\n"
  end

  it 'delete scheduled time' do
    delete '/schedule?id=1234'
    last_response.body.should == @ok
  end
end

