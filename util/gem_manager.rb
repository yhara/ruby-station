require 'open3'

module GemManager
  def self.installed?(gemname, version)
    gem_path = File.join(Conf.gem_dir, "gems", "#{gemname}-#{version}")
    exists = File.exist?(gem_path)
    Ramaze::Log.info "checking existance of #{gem_path}.. #{exists}"
    
    exists
  end

  def self.install_file(path)
    begin
      # make symlink
      newpath = "/tmp/#{File.basename(path, ".gem")}.gem"
      File.symlink(path, newpath)

      # install
      cmd = [
        Conf.gem_command, "install", newpath,
        "-i", Conf.gem_dir,
        "-n", Conf.gem_bin_dir,
        Conf.gem_install_option
      ].join(" ")
      Ramaze::Log.info cmd

      # execute
      out, err = Open3.popen3(cmd){|i, o, e|
        [o.read, e.read]
      }
      return err unless out =~ /installed #{name}-(.*)/

      # make data dir
      spec = YAML.load(`gem spec #{path}`)
      data_dir = File.join(Conf.data_dir, "#{spec.name}-#{spec.version}")
      unless File.directory?(data_dir)
        Dir.mkdir(data_dir)
        Ramaze::Log.info "made data dir for the gem: #{data_dir}"
      end

      [out, spec.name, spec.version.to_s]
    ensure
      File.unlink(newpath)
    end
  end

  def self.install_gem(name)
    # install
    cmd = [
      Conf.gem_command, "install", name,
      "-i", Conf.gem_dir,
      "-n", Conf.gem_bin_dir,
      Conf.gem_install_option
    ].join(" ")
    Ramaze::Log.info cmd
    
    # execute
    out, err = Open3.popen3(cmd){|i, o, e|
      [o.read, e.read]
    }
    return err unless out =~ /installed #{name}-(.*)/

    # make data dir
    version = $1
    data_dir = File.join(Conf.data_dir, "#{name}-#{version}")
    unless File.directory?(data_dir)
      Dir.mkdir(data_dir)
      Ramaze::Log.info "made data dir for the gem: #{data_dir}"
    end

    [out, name, version]
  end

  def self.uninstall(name, version)
    cmd = [
      Conf.gem_command, "uninstall", name,
      "-v", version,
      "-i", Conf.gem_dir,
      "-n", Conf.gem_bin_dir
    ].join(" ")
    Ramaze::Log.info cmd

    `#{cmd}`
  end
end
