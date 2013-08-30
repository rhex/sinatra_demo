$:.unshift File.expand_path('../../app', __FILE__)
require 'demo_api'
require 'minitest/autorun'
require 'rack/test'

describe 'Demo API test' do
  include Rack::Test::Methods

  def app
    Demo
  end

  it 'test_hi' do
    get '/hi'
    assert_equal "Hello World!\n", last_response.body
    last_response.body.must_equal "Hello World!\n"
  end
end
