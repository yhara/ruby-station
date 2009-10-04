require 'ramaze'
require __DIR__("../../util/servant.rb")

describe Servant do
  def sleeper_cmd(seconds)
    "ruby -e '#{seconds}.times{ sleep 1 }'"
  end

  context "when starting a process" do
    it "should return the process-id" do
      pid = Servant.watch(sleeper_cmd(5))
      pid.should be_kind_of(Integer)
    end

    it "should call the block on termination" do
      value = nil
      pid = Servant.watch(sleeper_cmd(1)){
        value = "done"
      }
      sleep 2
      value.should == "done"
    end
  end

  it "should kill a process" do
    prev = Time.now
    pid = Servant.watch(sleeper_cmd(10))
    sleep 2
    Servant.kill(pid)
    (Time.now - prev).should < 10
  end
end

