require 'ramaze'
require __DIR__("../test_helper.rb")
require TESTS_DIR/"../util/gem_manager.rb"

describe GemManager do
  it "should install a gem via file" do
    result, name, version = GemManager.install_file(hello_gem_path("0.3.2"))

    result.should be_instance_of(String)
    name.should == "hello-ruby-station"
    version.should == "0.3.2"

    GemManager.installed?("hello-ruby-station", "0.3.2").should be_true
  end

  it "should install a gem via network" do
    result, name, version = GemManager.install_gem("hello-ruby-station")

    result.should be_instance_of(String)
    name.should == "hello-ruby-station"
    version.should == "0.3.0"

    GemManager.installed?("hello-ruby-station", "0.3.0").should be_true
  end
  
  it "should uninstall a gem" do
    GemManager.uninstall("hello-ruby-station", "0.3.2")

    GemManager.installed?("hello-ruby-station", "0.3.2").should be_false
  end
end
