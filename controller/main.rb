class MainController < Controller
  layout('default'){|path, wish|
    path !~ /do_add/
  }

  def index
    @applications = Application.all
  end

  def start(id)
    id = id.to_i
    app = Application.get(id)
    raise "id #{id} not found" unless app

    start_cmd = "ruby1.9 #{gem_home}/#{File.basename(app[:name], ".gem")}/start.rb -p #{app[:port]}"

    Ramaze::Log << "!!!!!!!! #{start_cmd}"
    fork {
      pid = exec(start_cmd)
    }
#    pid = Process.spawn(start_path)
#    Ramaze::Log << "spawned!! #{pid}"
    pid = ":-("

    app[:pid] = pid
    Application[id] = app
    sleep 1
    redirect "http://localhost:#{app[:port]}/"
  end

  def stop(id)
    app[:pid] = nil
    redirect :index
  end

  def gem_home
    "/Users/yhara/gems1.9"
  end

end
