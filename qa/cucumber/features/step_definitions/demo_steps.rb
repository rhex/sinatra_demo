Given(/^I am on localhost$/) do
  visit 'http://localhost:3004'
end

When(/^I visit hi$/) do
  visit '/hi'
end

Then(/^I should see Hello World!$/) do
  page.has_content?('Hello World!').should be_true
end
