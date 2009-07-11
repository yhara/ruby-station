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
    raise NotImplementedError
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
