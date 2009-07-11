class Controller < Ramaze::Controller
  helper :xhtml
  engine :Etanni
  layout 'default'
end

require 'controller/main.rb'
require 'controller/applications.rb'
