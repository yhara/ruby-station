class MainController < Controller
  map '/'

  def index
    @applications = Application.all
  end

  def notfound
    # Note: workaround for ramaze 2009.07
    # response.status = 404
    
    @message = flash[:error] || "The page you requested is not found."
  end

end
