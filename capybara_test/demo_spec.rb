ENV['RACK_ENV'] = 'test'

$:.unshift File.expand_path('../../app', __FILE__)
require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'app_helper'
require 'demo_api'

describe 'Demo API' do
  include Capybara::DSL
  # Capybara.default_driver = :selenium # <-- use Selenium driver
  Capybara.default_wait_time = 5
  Capybara.app = Demo.new
  # or
  # Capybara.app = Sinatra::Application.new

  it 'get hi' do
    visit '/hi'
    page.has_content?("Hello World!").should be_true
  end
end

