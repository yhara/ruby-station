Feature: Re-Install
  In order to be sure the app is installed
  As an application user
  I want to install the app again

  Scenario: Reinstalling a gem
    Given I have 'hello-ruby-station 0.3.1' and its data
    When I install 'hello-ruby-station 0.3.1'
    Then I should still have 'hello-ruby-station 0.3.1'
    And data files of 'hello-ruby-station 0.3.1' should exist
