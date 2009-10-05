def find_app(name, version)
  Application.first(:name => name, :version => version)
end

def install_hello(name, version)
  raise "wrong gem name" unless name == "hello-ruby-station"
  Application.install(:file, hello_gem_path(version))
end

def data_dir_of(name, version)
  File.expand_path("#{name}-#{version}", Conf.data_dir)
end

def test_txt_path(name, version)
  File.expand_path("test.txt", data_dir_of(name, version))
end

Given /^I have '(.*) (.*)'( and its data)?$/ do |name, version, data|
  unless find_app(name, version)
    install_hello(name, version)
  end
  if data
    File.open(test_txt_path(name, version), "w"){|f|
      # Note: content of test data file should be unique
      f.puts version
    }
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
  app = find_app(name, version)
  Ramaze::Log.error Application.all if app.nil? 
  app.should_not be_nil
end

Then /^I should not have '(.*) (.*)'$/ do |name, version|
  find_app(name, version).should be_nil
end

def files_of(dir)
  Dir["#{dir}/**"].map{|path| path.sub(dir, "")}
end

Then /^data files of '(.*) (.*)' should exist$/ do |name, version|
  Dir.entries(data_dir_of(name, version)).should_not be_empty
end

Then /^data files of '(.*) (.*)' is same as '(.*) (.*)'/ do |n1, v1, n2, v2|
  files1 = files_of(data_dir_of(n1, v1)).sort
  files2 = files_of(data_dir_of(n2, v2)).sort
  files1.should == files2

  files1.each do |rel_path|
    path1 = File.join(data_dir_of(n1, v1), rel_path)
    path2 = File.join(data_dir_of(n2, v2), rel_path)

    File.read(path1).should == File.read(path2)
  end
end
