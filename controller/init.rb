# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers

class Controller < Ramaze::Controller
  map '/page'
  helper :xhtml
  engine :Etanni
end

# Here go your requires for subclasses of Controller:
require 'controller/main'
