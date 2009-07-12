require 'optparse'

module RubyStation
  @port = nil
  @data_dir = nil

  def self.parse_argv
    OptionParser.new{|o|
      o.on("--port N"){|n| @port = n}
      o.on("--data-dir PATH"){|d| @data_dir = d}
    }.parse!(ARGV)
  end

  def self.port; @port; end
  def self.data_dir; @data_dir; end
end
