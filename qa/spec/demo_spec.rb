require 'rspec'
require 'capybara'
require 'capybara/dsl'

describe 'Demo API' do
  include Capybara::DSL
  Capybara.default_driver = :selenium # <-- use Selenium driver
  Capybara.default_wait_time = 5
  Capybara.app_host = 'http://localhost:3004'
  # or
  # Capybara.app = Sinatra::Application.new

  it 'get hi' do
    visit '/hi'
    page.has_content?("Hello World!").should be_true
  end
end

