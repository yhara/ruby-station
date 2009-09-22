class MainController < Controller
  map '/'
  helper :flash

  def index
    @applications = Application.all
  end

  def notfound
    @message = flash[:error] || "The page you requested is not found."
    response.status = 404
  end

end
