Feature: Uninstall
  In order to clean my application list
  As an application user
  I want to uninstall an unused application

  Scenario: Uninstall a gem
    Given I visit the index page
    When I press the uninstall link
#    Given I visit the calculator page
#    And I fill in '50' for 'first'
#    And I fill in '70' for 'second'
#    When I press 'Add'
#    Then I should see 'Answer: 120'
