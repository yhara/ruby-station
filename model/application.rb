class Application
  include DataMapper::Resource

  property :id, Serial
  property :pid, Integer
  property :port, Integer
  property :name, String
  property :version, String

  # Install the speficied gem and create an Application
  def self.install(by, value)
    case by
    when :name
      result, name, version = GemManager.install_gem(value)
    when :file
      result, name, version = GemManager.install_file(value)
    else
      raise "invalid parameter: by => #{by}" 
    end

    unless Application.first(:name => name, :version => version)
      Application.create({
        :pid => nil,
        :port => 30000 + rand(9999),
        :name => name,
        :version => version,
      })
    end

    return result
  end

  # Uninstall the gem and destroy myself
  def uninstall
    result = GemManager.uninstall(self.name, self.version)
    self.destroy

    return result
  end

  # Start the app in background
  def start
    return if self.pid

    cmd = [
      gem_env(),
      Conf.ruby_command,
      script_path,
      "--port", self.port.to_s,
      "--data-dir", data_dir,
    ].join(" ")

    Ramaze::Log.info "starting app: #{cmd}"

    self.pid = Servant.watch(cmd){
      stopped
    }
    self.save
  end

  # Kill the app if running
  def stop
    if self.pid
      Servant.kill(self.pid)
      stopped
    end
  end

  # Returns a string contains name and version
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

Application.all.each{|a| a.update(:pid => nil)}
