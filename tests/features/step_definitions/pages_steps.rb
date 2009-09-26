Given /^I visit the (.*) page$/ do |name|
  case name
  when "index"
    visit '/'
  else
    raise "unknown page name: #{name}"
  end
end

Given /^I fill in (.*) for '(.*)'$/ do |value, field|
  case value
  when /'(.*)'/
    value = $1
  when /the path of '(.*)'/
    value = TESTS_DIR/"data/hello/pkg/#{$1}"
  else
    raise "unknown value type: #{value}"
  end
  fill_in(field, :with => value)
end

When /^I press '(.*)'$/ do |name|
  click_button(name)
end

Then /^I should see '(.*)'$/ do |text|
  response_body.should contain(/#{text}/m)
end


