Feature: Upgrade
  In order to use new version of an application
  As an application user
  I want to install the new version

  Scenario: Upgrade a gem
    Given I have 'hello 0.1.0'
    And I do not have 'hello 0.2.0'
    When I install 'hello 0.2.0'
    Then I should still have 'hello 0.1.0'
    And data files of 'hello 0.2.0' is same as data files of 'hello 0.1.0'
