#!/usr/bin/env ruby
require 'irb'
require "ramaze"

Conf = Object.new
def Conf.db_path
  __DIR__("./tmp/ruby-station.db")
end

require __DIR__("../model/init.rb")
IRB.start
