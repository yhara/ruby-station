require 'ramaze'
require __DIR__("../test_helper.rb")
require TESTS_DIR/"../model/init.rb"

def uninstall_hello(version)
  if GemManager.installed?("hello-ruby-station", version)
    GemManager.uninstall("hello-ruby-station", version)
  end
end

def install_hello(version)
  GemManager.install(hello_gem_path(version))
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
    app.port.should instance_of(Integer)
    app.pid.should be_nil
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

