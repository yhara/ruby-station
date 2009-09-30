require 'json'

class Applications < Controller
  map '/applications'
  provide :json, :type => "application/json" do |action, value|
    value.to_json
  end

  layout{|path, ext|
    "default" unless path =~ /\A_/
  }

  def install
    session[:source_type] = request["by"]

    case session[:source_type]
    when "name"
      @name = request["name"]
      session[:gemname] = @name
      session[:messages] = []
    when "file"
      tempfile = request["gem"][:tempfile]
      @filename = request["gem"][:filename]
      @size = tempfile.size
      session[:tempfile] = tempfile
    else
      raise "unknown install source type: #{session[:source_type]}"
    end
  end

  def _install
    case session[:source_type]
    when "name"
      gemname = session[:gemname]
      result, name, version = GemManager.install_gem(gemname)
    when "file"
      path = session[:tempfile].path
      result, name, version = GemManager.install_file(path)
    else
      raise "unknown install source type: #{session[:source_type]}"
    end

    if result and not Application.first(:name => name, :version => version)
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

  def uninstall(id)
    if app = Application.get(id)
      @app = app
    else
      flash[:error] = "The application (id=#{id}) is already uninstalled."
      redirect MainController.r(:notfound)
    end
  end

  def _uninstall(id)
    if app = Application.get(id)
      result = GemManager.uninstall(app.name, app.version)
      app.destroy
      result
    else
      ""
    end
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
