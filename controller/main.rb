class MainController < Controller
  map '/'

  def index
    @applications = Application.all
  end

end
