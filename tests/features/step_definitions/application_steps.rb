def find_app(name, version)
  Application.first(:name => name, :version => version)
end

def install_hello(name, version)
  raise "wrong gem name" unless name == "hello-ruby-station"
  Application.install(:file, hello_gem_path(version))
end

Given /^I have '(.*) (.*)'$/ do |name, version|
  unless find_app(name, version)
    install_hello(name, version)
  end
end

Given /^I do not have '(.*) (.*)'$/ do |name, version|
  if app = find_app(name, version)
    app.uninstall
  end
end

When /^I install '(.*) (.*)'$/ do |name, version|
  install_hello(name, version)
end

Then /^I should (?:still )?have '(.*) (.*)'$/ do |name, version|
  sleep 10
  app = find_app(name, version)
  Ramaze::Log.error Application.all if app.nil? 
  app.should_not be_nil
end

Then /^I should not have '(.*) (.*)'$/ do |name, version|
  find_app(name, version).should be_nil
end

Then /data files of '(.*) (.*)' is copied to '(.*) (.*)'/ do |n1, v1, n2, v2|
  data_path(n1, v1)
  data_path(n2, v2)
end

