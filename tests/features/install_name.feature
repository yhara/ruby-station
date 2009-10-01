Feature: Install by name
  In order to use new applications
  As an application user
  I want to install a new application

  Scenario: Install a gem by name
    Given I do not have 'hello-ruby-station 0.3.0'
    And I visit the index page
    And I fill in 'hello-ruby-station' for 'name'
    When I press 'install'
    And I wait while the spinner is shown
    Then I should see 'Installing'
    And I should have 'hello-ruby-station 0.3.0'
