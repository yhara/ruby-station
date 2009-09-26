require "#{File.dirname(__FILE__)}/../test_helper.rb"
require TESTS_DIR/"../util/gem_manager.rb"

# helpers

describe GemManager do
  it "should install a gem via file" do
    path = TESTS_DIR/"data/hello/pkg/hello-0.2.0.gem"
    result, name, version = GemManager.install_file(path)

    result.should be_instance_of(String)
    name.should == "hello"
    version.should == "0.2.0"

    GemManager.installed?("hello", "0.2.0").should be_true
  end

  it "should install a gem via network" do
    pending
  end
  
  it "should uninstall a gem" do
    GemManager.uninstall("hello", "0.2.0")

    GemManager.installed?("hello", "0.2.0").should be_false
  end
end
