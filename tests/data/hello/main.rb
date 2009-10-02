require 'optparse'
require 'rubygems'
require 'ruby-station'; RubyStation.parse_argv
require 'sinatra'

File.open("#{RubyStation.data_dir}/hello.txt", "w"){|f|
  f.print "hello"
}

get '/' do
  'Hello, world!'
end

set :port, RubyStation.port

