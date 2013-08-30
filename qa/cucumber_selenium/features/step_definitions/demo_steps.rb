Given(/^I am on localhost$/) do
  @driver.get 'http://localhost:3004'
end

When(/^I visit hi$/) do
  @driver.get 'http://localhost:3004/hi'
end

Then(/^I should see Hello World!$/) do
  @driver.find_element(:tag_name, 'body').text.should == 'Hello World!'
end
