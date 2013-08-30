$:.unshift File.expand_path('../../app', __FILE__)
require 'demo_api'
require 'minitest/autorun'
require 'rack/test'

class DemoTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Demo
  end

  def test_hi
    get '/hi'
    assert_equal "Hello World!\n", last_response.body
  end
end
