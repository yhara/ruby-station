class Applications < Controller
  map '/applications'

  layout{|path, ext|
    "default" unless path =~ /\Ado_/
  }

  def install
    if request["name"]
      @name = request["name"]
      session[:gemname] = @name
    else
      tempfile = request["gem"][:tempfile]
      @filename = request["gem"][:filename]
      @size = tempfile.size
      session[:tempfile] = tempfile
    end
  end

  def do_install
    if gemname = session[:gemname]
      result, name, version = GemManager.install_gem(gemname)
    elsif session[:tempfile]
      path = session[:tempfile].path
      result, name, version = GemManager.install_file(path)
    else
      raise
    end

    unless Application.first(:name => name, :version => version)
      Application.create({
        :pid => nil,
        :port => 30000 + rand(9999),
        :name => name,
        :version => version,
      })
    end

    session.clear
    h result
  end

  def create
  end

  def show(name)
  end

  def uninstall(id)
    app = Application.get(id)
    raise "application not found(id=#{id})" unless app

    @app = app
  end

  def do_uninstall(id)
    app = Application.get(id)
    raise "application not found(id=#{id})" unless app

    result = GemManager.uninstall(app.name, app.version)
    app.destroy
    result
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
