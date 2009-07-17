module GemManager
  def self.installed?(gemname, version)
    File.exist?(File.join(Conf.gem_dir, "#{gemname}-#{version}"))
  end

  def self.install_file(path)
    begin
      # make symlink
      newpath = "/tmp/a.gem"
      File.symlink(path, newpath)

      # install
      cmd = [
        Conf.gem_command, "install", newpath,
        "-i", Conf.gem_dir,
        "-n", Conf.gem_bin_dir,
        Conf.gem_install_option
      ].join(" ")
      Ramaze::Log.info cmd

      result = `#{cmd}`
      spec = YAML.load(`gem spec #{path}`)
      [result, spec.name, spec.version]
    ensure
      File.unlink(newpath)
    end
  end
end
