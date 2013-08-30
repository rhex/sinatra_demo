require 'selenium-webdriver'
require 'capybara/cucumber'
Capybara.default_wait_time = 5
Capybara.app_host = 'http://localhost:3004'
Capybara.default_driver = :selenium
