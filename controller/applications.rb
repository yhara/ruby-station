class Applications < Controller
  map '/applications'

  layout{|path, ext|
    "default" if path != "do_install"
  }

  def install(name=nil)
    if name.nil?
      tempfile = request["gem"][:tempfile]
      @filename = request["gem"][:filename]
      @size = tempfile.size
      session[:tempfile] = tempfile
    else
      raise
    end
  end

  def do_install(name=nil)
    if name.nil?
      path = session[:tempfile].path
      newpath = "/tmp/a.gem"
      begin
        File.symlink(session[:tempfile].path, newpath)
        cmd = [
          Conf.gem_command, "install", newpath,
          "-i", Conf.gem_dir,
          "-n", Conf.gem_bin_dir,
          Conf.gem_install_option
        ].join(" ")
        Ramaze::Log.info cmd
        @result = h `#{cmd}`
        spec = YAML.load(`gem spec #{path}`)
      ensure
        File.unlink(newpath)
      end

      Application.create({
        :pid => nil,
        :port => 30000 + rand(9999),
        :name => spec.name,
        :version => spec.version.to_s,
      })
    end
  end

  def create
  end

  def show(name)
  end

  def uninstall(name)
  end

  def start(id)
    app = Application.get(id)
    raise "application not found(id=#{id})" unless app

    app.start
    sleep 1

    redirect "http://localhost:#{app.port}/"
  end

  def stop(id)
    app = Application.get(id)
    raise "application not found(id=#{id})" unless app

    app.stop

    redirect_referer
  end

end
