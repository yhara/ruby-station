Feature: Install by file
  In order to test new applications
  As an application developer
  I want to install a new gem file

  Scenario: Install a gem by file
    Given I do not have 'hello-ruby-station 0.2.0'
    And I visit the index page
    And I check 'by file'
    And I fill in the path of 'data/hello/pkg/hello-ruby-station-0.3.2.gem' for 'gem'
    When I press 'install'
    And I wait while the spinner is shown
    Then I should see 'Installing'
    And I should have 'hello-ruby-station 0.3.2'
