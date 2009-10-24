Feature: Uninstall
  In order to clean my application list
  As an application user
  I want to uninstall an unused application

  Scenario: Show uninstall page
    Given I have 'hello-ruby-station 0.3.1' and its data
    And I visit the index page
    When I press the uninstall button of 'hello-ruby-station 0.3.1'
    Then I should see 'Uninstall'
    And I should see 'hello-ruby-station 0.3.1'

  Scenario: Uninstall a gem
    Given I have 'hello-ruby-station 0.3.1' and its data
    And I visit the uninstall page of 'hello-ruby-station 0.3.1'
    When I press 'ok'
    And I wait while the spinner is shown
    Then I should not have 'hello-ruby-station 0.3.1'
    And data files of 'hello-ruby-station 0.3.1' should not exist
