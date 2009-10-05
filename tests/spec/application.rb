require 'ramaze'
require __DIR__("../test_helper.rb")
require TESTS_DIR/"../config.rb"
require TESTS_DIR/"../model/init.rb"
require TESTS_DIR/"../util/servant.rb"

def install_hello(version)
  Application.install(:file, hello_gem_path(version))
  hello_app(version)
end

def hello_app(version)
  Application.first(:name => "hello-ruby-station", 
                    :version => version)
end

describe Application do
  it "should be created by GemManager" do
    app = install_hello("0.3.2")

    app.should_not be_nil
    app.port.should be_kind_of(Integer)
    app.pid.should be_nil

    Application.all(:name => "hello-ruby-station", 
                    :version => "0.3.2").size.should == 1
  end

  it "should be removed by GemManager" do
    install_hello("0.3.2") unless hello_app("0.3.2") 
    hello_app("0.3.2").uninstall

    hello_app("0.3.2").should be_nil
    GemManager.installed?("hello-ruby-station", "0.3.2").should be_false
  end

  it "should start an app" do
    app = hello_app("0.3.2") || install_hello("0.3.2")

    app.start
    app.pid.should_not be_nil
  end

  it "should stop an app" do
    app = hello_app("0.3.2") || install_hello("0.3.2")

    app.stop
    app.pid.should be_nil
  end
end

