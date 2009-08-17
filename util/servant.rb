require 'open3'
require 'ramaze/tool/bin'

# class Servant provides process invocations.
#
# @example
#   pid = Servant.watch("some-app -p 12345"){
#     # this block is called when app finishes
#   }
#
#   Servant.kill(pid) #=> stop the app immediately
#
#   Servant.communicate("gem install foobar"){|line|
#     # each line is yielded form process
#   }
class Servant
  extend Ramaze::Tool::Bin::Helpers # provides is_running?

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
    return pid
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

  def self.kill(pid)
    Process.kill("INT", pid)

    if is_running?(pid)
      sleep 2
      Ramaze::Log.warn "Process #{pid} did not die, forcing it with -9"
      Process.kill(9, pid)
    end
  end

end
