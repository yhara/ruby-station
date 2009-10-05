Feature: Listing
  In order to know which application is installed
  As an application user
  I want to list my applications

  Scenario: View the list of applications
    Given I have 'hello-ruby-station 0.3.1'
    When I visit the index page
    Then I should see 'hello-ruby-station'
    And I should see '0.3.1'
