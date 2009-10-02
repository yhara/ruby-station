class Application
  include DataMapper::Resource

  property :id, Serial
  property :pid, Integer
  property :port, Integer
  property :name, String
  property :version, String

  def start
    return if self.pid

    cmd = [
      gem_env(),
      Conf.ruby_command,
      script_path,
      "--port", self.port.to_s,
      "--data-dir", data_dir,
    ].join(" ")

    self.pid = Servant.watch(cmd){
      stopped
    }
    self.save
  end

  def stop
    if self.pid
      Servant.kill(self.pid)
      stopped
    end
  end

  def full_name
    "#{self.name}-#{self.version}"
  end

  private

  def stopped
    self.pid = nil
    self.save
  end

  def script_path
    File.join(Conf.gem_dir, "gems",
              full_name, "main.rb")
  end

  def data_dir
    File.join(Conf.data_dir, full_name)
  end

  def gem_env
    "GEM_HOME='#{Conf.gem_dir}'"
  end
end
DataMapper.auto_upgrade!

Application.all.each{|a| a.update_attributes(:pid => nil)}
