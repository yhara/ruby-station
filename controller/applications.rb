require 'json'

class Applications < Controller
  map '/applications'
  provide :json, :type => "application/json" do |action, value|
    value.to_json
  end
  helper :flash

  layout{|path, ext|
    "default" unless path =~ /\A_/
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

  def _install
    session[:messages] = []
    if gemname = session[:gemname]
      result, name, version = GemManager.install_gem(gemname){|line|
        session[:messages] << line
      }
      session[:messages] << :__end__
    elsif session[:tempfile]
      path = session[:tempfile].path
      result, name, version = GemManager.install_file(path)
    else
      raise
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

  def _message
    return "['error']" if session[:messages].nil?

    sleep 1 while session[:messages].empty?

    is_end = "false"
    if session[:messages].last == :__end__
      session[:messages].pop
      is_end = "true"
    end

    mes = session[:messages].map{|line| "#{h line.chomp}<br>"}.join
    session[:messages].clear
    "[#{is_end}, \"#{mes}\"]"
  end

  def create
  end

  def show(name)
  end

  def uninstall(id)
    if app = Application.get(id)
      @app = app
    else
      flash[:error] = "The application (id=#{id}) is already uninstalled."
      redirect r(:notfound)
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

  def foo
    session[:foo] = []
  end

  def _foo_gen
    5.times do |i|
      session[:foo].push "this is line #{i}"
      sleep 1
    end
    session[:foo].push :__end__
  end

  def _foo_get
    if session[:foo].empty?
      [nil]
    else
      if session[:foo].last == :__end__
        is_end = true
        session[:foo].pop
      else
        is_end = false
      end
      mes = session[:foo].map{|line| (h line.chomp)+"<br>\n"}.join
      session[:foo].clear
      [is_end, mes]
    end
  end

end
