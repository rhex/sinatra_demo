Feature: Demo hi
  In order to verify the website works well
  As a user
  I want to see hello world show up

  @regression
  Scenario: See hello world
    Given I am on localhost
    When I visit hi
    Then I should see Hello World!
