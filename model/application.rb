require 'ramaze/tool/bin'

class Application
  include DataMapper::Resource
  include Ramaze::Tool::Bin::Helpers

  property :id, Serial
  property :pid, Integer
  property :port, Integer
  property :name, String
  property :version, String

  def start
    return if self.pid

    cmd = [
      Conf.ruby_command,
      script_path,
      "--port", self.port.to_s,
      "--data-dir", data_dir,
    ].join(" ")

    self.pid = fork {
      exec(cmd)
    }
    self.save
  end

  def stop
    return unless self.pid

    Process.kill("INT", self.pid)
    if is_running?(self.pid)
      sleep 2
      Ramaze::Log.warn "Process #{self.pid} did not die, forcing it with -9"
      Process.kill(9, self.pid)
    end

    self.pid = nil
    self.save
  end

  private

  def script_path
    File.join(Conf.gem_dir, "gems",
              full_name, "main.rb")
  end

  def data_dir
    File.join(Conf.data_dir, full_name)
  end

  def full_name
    "#{self.name}-#{self.version}"
  end
end
DataMapper.auto_upgrade!

Application.all.each{|a| a.update_attributes(:pid => nil)}
