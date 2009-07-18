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
      result, name, version = GemManager.install_file(path)
      ver = version.to_s

      @result = h result

      unless Application.first(:name => name, :version => ver)
        Application.create({
          :pid => nil,
          :port => 30000 + rand(9999),
          :name => name,
          :version => ver,
        })
      end
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
    sleep 3

    redirect "http://localhost:#{app.port}/"
  end

  def stop(id)
    app = Application.get(id)
    raise "application not found(id=#{id})" unless app

    app.stop

    redirect_referer
  end

end
