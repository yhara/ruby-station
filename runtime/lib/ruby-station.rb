require 'optparse'

module RubyStation
  @port = nil
  @data_dir = nil

  def self.parse_argv
    OptionParser.new{|o|
      o.on("--port N"){|n| @port = n}
      o.on("--data-dir PATH"){|d| @data_dir = d}
    }.parse!(ARGV)

    unless @port
      @port = 40000 + rand(10000)
      warn "--port is not specified; assuming it is #{@port}"
    end
    unless @data_dir
      @data_dir = File.expand_path("./")
      warn "--data-dir is not specified; assuming it is #{@data_dir}" 
    end
  end

  def self.port; @port; end
  def self.data_dir; @data_dir; end
  def self.data_path(filename)
    File.expand_path(filename, @data_dir)
  end

  autoload :Helper, "ruby-station/helper"
end
