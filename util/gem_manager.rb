require 'fileutils'
require 'open3'

module GemManager
  class InstallFailed < StandardError; end

  def self.installed?(gemname, version)
    gem_path = File.join(Conf.gem_dir, "gems", "#{gemname}-#{version}")
    exists = File.exist?(gem_path)
    Ramaze::Log.info "checking existance of #{gem_path}.. #{exists}"
    
    exists
  end

  def self.install_file(path)
    symlinked = false
    begin
      # make symlink
      if path !~ /.gem\z/
        newpath = "/tmp/#{File.basename(path, ".gem")}.gem"
        File.symlink(path, newpath)
        symlinked = true
      else
        newpath = path
      end

      # install
      cmd = [
        Conf.gem_command, "install", newpath,
        "-i", Conf.gem_dir,
        "-n", Conf.gem_bin_dir,
        Conf.gem_install_option
      ].join(" ")

      out, _ = gem_install(cmd)
      spec = YAML.load(`gem spec #{path}`)
      name, version = spec.name, spec.version.to_s
      make_data_dir(name, version)

      [out, name, version]
    ensure
      File.unlink(newpath) if symlinked
    end
  end

  def self.install_gem(name)
    cmd = [
      Conf.gem_command, "install", name,
      "-i", Conf.gem_dir,
      "-n", Conf.gem_bin_dir,
      Conf.gem_install_option
    ].join(" ")
    
    out, version = gem_install(cmd, name)
    make_data_dir(name, version)

    [out, name, version]
  end

  def self.gem_install(cmd, name=nil)
    Ramaze::Log.info cmd
    out, err = Open3.popen3(cmd){|i, o, e|
      [o.read, e.read]
    }

    name_pattern = name ? "#{name}-" : ""
    if out !~ /Successfully installed #{name_pattern}(.*)/
      Ramaze::Log.error "gem install failed: #{err}"
      raise InstallFailed.new(err)
    end

    return out, $1
  end

  def self.make_data_dir(name, version)
    data_dir = File.join(Conf.data_dir, "#{name}-#{version}")
    unless File.directory?(data_dir)
      if prev_ver = previous_version(name, version)
        prev_dir = File.join(Conf.data_dir, "#{name}-#{prev_ver}")
        FileUtils.cp_r(prev_dir, data_dir)
        Ramaze::Log.info "copied data of #{version} for the gem: #{data_dir}"
      else
        Dir.mkdir(data_dir)
        Ramaze::Log.info "made data dir for the gem: #{data_dir}"
      end
    end
  end

  def self.previous_version(name, version)
    specs_dir = File.join(Conf.gem_dir, "specifications")
    index = Gem::SourceIndex.new.load_gems_in(specs_dir)

    req = Gem::Requirement.create("< #{version}")
    prev_spec = index.find_name(name, req).last
    return prev_spec ? prev_spec.version.to_s : nil
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
