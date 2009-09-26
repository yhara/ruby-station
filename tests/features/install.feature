Feature: Install
  In order to use new applications
  As an application user
  I want to install a new application

  Scenario: Install a gem by name
    Given I do not have 'yhara-hello 0.2.0'
    And I visit the index page
    And I fill in 'yhara-hello' for 'name'
    When I press 'install'
    And I wait until 
    Then I should see 'Installing'
    And I should have 'yhara-hello 0.2.0'

  Scenario: Install a gem by file
    Given I do not have 'yhara-hello 0.2.0'
    And I visit the index page
    And I fill in the path of 'hello-0.2.0.gem' for 'name'
    When I press 'install'
    Then I should see 'Installing'
    And I should have 'hello 0.2.0'
