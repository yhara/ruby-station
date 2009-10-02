

Given /^I have '(.*) (.*)'$/ do |name, version|
  GemManager.installed?(name, version)
end

Given /^I do not have '(.*) (.*)'$/ do |name, version|
  if GemManager.installed?(name, version)
    GemManager.uninstall(name, version)
  end
end

When /^I install '(.*) (.*)'$/ do |name, version|
  pending
end

Then /^I should (?:still )?have '(.*) (.*)'$/ do |name, version|
  GemManager.installed?(name, version).should be_true
end

Then /^I should not have '(.*) (.*)'$/ do |name, version|
  GemManager.installed?(name, version).should be_false
end

Then /data files of '(.*) (.*)' is copied to '(.*) (.*)'/ do |n1, v1, n2, v2|
  data_path(n1, v1)
  data_path(n2, v2)
end

