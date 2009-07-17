# coding: utf-8
require 'rubygems'
require 'ramaze'

# Add directory start.rb is in to the load path, so you can run the app from
# any other working path
$LOAD_PATH.unshift(__DIR__)

# Initialize controllers and models
require 'util/gem-manager.rb'
require 'config.rb'
require 'controller/init'
require 'model/init'

Ramaze.start :adapter => :thin, :port => 7000
