require 'open3'

# class Servant provides process invocations.
#
# @example
#   s = Servant.watch("some-app -p 12345"){
#     # this block is called when app finishes
#   }
#   s.pid  #=> returns the process-id
#   s.kill #=> stop the app immediately
#
#   Servant.communicate("gem install foobar"){|line|
#     # each line is yielded form process
#   }
class Servant

  def self.watch(cmd, args=[], &block)
    begin
      pid = Process.spawn(cmd, *args)
    rescue SystemCallError
      return nil
    end

    Thread.new{
      Process.waitpid(pid)
      block.call
    }

    return new(pid)
  end

  def self.communicate(cmd, args=[])
    command = cmd + args.map{|x| ' '+x}.join
    Open3.popen3(command){|stdin, stdout, stderr|
      stdin.close
      while line = stdout.gets
        yield line
      end
      while line = stderr.gets
        yield line
      end
    }
  end

  def initialize(pid)
    @pid = pid
  end

  def kill
    Process.kill("INT", @pid)

#    if is_running?(self.pid)
#      sleep 2
#      Ramaze::Log.warn "Process #{self.pid} did not die, forcing it with -9"
#      Process.kill(9, self.pid)
#    end
  end

end
