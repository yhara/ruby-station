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
      result = `#{cmd}`

      # make data dir
      spec = YAML.load(`gem spec #{path}`)
      data_dir = File.join(Conf.data_dir, "#{spec.name}-#{spec.version}")
      unless File.directory?(data_dir)
        Dir.mkdir(data_dir)
        Ramaze::Log.info "made data dir for the gem: #{data_dir}"
      end

      [result, spec.name, spec.version]
    ensure
      File.unlink(newpath)
    end
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
