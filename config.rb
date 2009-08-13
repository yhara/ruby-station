require 'yaml'
require 'fileutils'

#Encoding.default_external = 'UTF-8'

module RubyStation
  VERSION = File.read(File.expand_path("./VERSION", File.dirname(__FILE__))).chomp
end

class Conf
  %w(ruby_command gem_command gem_dir gem_bin_dir gem_install_option data_dir server_port).each do |m|
    class_eval <<-EOD
      def self.#{m}; @yaml[:#{m}]; end
    EOD
  end

  def self.db_path
    File.join(@home, "ruby-station.db")
  end

  def self.parse_opt
    @home = File.expand_path("~/.ruby-station")

    @opt = OptionParser.new{|o|
      o.on("--home PATH", "path to save ruby-station data (default: #@home)"){|path|
        @home = File.expand_path(path)
      }
      o.on("-h", "--help", "show this message"){
        puts @opt.to_s
        exit
      }
    }
    @opt.parse!(ARGV)
  end

  def self.load_yaml
    yaml_path = File.join(@home, "config.yaml")
    unless File.exist?(yaml_path)
      Ramaze::Log.warn "#{yaml_path} not found: creating"
      FileUtils.makedirs(@home)
      File.open(yaml_path, "w"){|f|
        f.write File.read(__DIR__("sample.config.yaml"))
      }
    end
    YAML.load_file(yaml_path)
  end

  # TODO: refactor X-(
  def self.init
    @yaml = self.load_yaml
    @yaml[:gem_dir] = File.expand_path(@yaml[:gem_dir], @home)
    @yaml[:gem_bin_dir] = File.expand_path(@yaml[:gem_bin_dir], @home)
    @yaml[:data_dir] = File.expand_path(@yaml[:data_dir], @home)
    FileUtils.makedirs(@yaml[:gem_dir])
    FileUtils.makedirs(@yaml[:gem_bin_dir])
    FileUtils.makedirs(@yaml[:data_dir])

    unless GemManager.installed?("ruby-station", RubyStation::VERSION)
      gem_path = __DIR__("pkg/ruby-station-#{RubyStation::VERSION}.gem")
      GemManager.install_file(gem_path)
    end
#    unless `#{self.gem_command} sources`.include?("github")
#      cmd = "#{self.gem_command} sources -a http://gems.github.com"
#      Ramaze::Log.info cmd
#      `#{cmd}`
#    end
  end
end
