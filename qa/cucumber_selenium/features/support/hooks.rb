Before do |scenario|
  @driver = Selenium::WebDriver.for :firefox
end

After do |scenario|
  @driver.quit
end

AfterStep do
  # Do things after each step.
end
