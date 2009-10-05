Feature: Upgrade
  In order to use new version of an application
  As an application user
  I want to install the new version

  Scenario: Upgrading a gem
    Given I have 'hello-ruby-station 0.3.0' and its data
    And I have 'hello-ruby-station 0.3.1' and its data
    And I do not have 'hello-ruby-station 0.3.2'
    When I install 'hello-ruby-station 0.3.2'
    Then I should still have 'hello-ruby-station 0.3.0'
    And I should still have 'hello-ruby-station 0.3.1'
    And data files of 'hello-ruby-station 0.3.2' is same as 'hello-ruby-station 0.3.1'
