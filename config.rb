require __DIR__("./util/gem_manager")
require 'yaml'
require 'fileutils'

#Encoding.default_external = 'UTF-8'

module RubyStation
  VERSION = File.read(__DIR__("VERSION")).chomp
  RUNTIME_VERSION = File.read(__DIR__("runtime", "VERSION")).chomp
end

class Conf
  %w(ruby_command gem_command gem_dir gem_bin_dir data_dir
     db_path gem_install_option server_port debug).each do |m|
    class_eval <<-EOD
      def self.#{m}; @yaml[:#{m}]; end
    EOD
  end

  def self.parse_opt
    @home = File.expand_path("~/.ruby-station")

    @opt = OptionParser.new{|o|
      o.on("--home PATH", "path to save ruby-station data (default: #@home)"){|path|
        @home = File.expand_path(path)
      }
      o.on("-v", "--version", "show version"){
        puts "RubyStation version #{RubyStation::VERSION}"
        puts "(runtime version: #{RubyStation::RUNTIME_VERSION})"
        exit
      }
      o.on("-h", "--help", "show this message"){
        puts @opt.to_s
        exit
      }
    }
    @opt.parse!(ARGV)
  end

  # for unit tests
  def self.set_home(path)
    @home = path
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
  def self.init(home=nil)
    @home = home if home
    @yaml = self.load_yaml
    @yaml[:gem_dir] = File.expand_path(@yaml[:gem_dir], @home)
    @yaml[:gem_bin_dir] = File.expand_path(@yaml[:gem_bin_dir], @home)
    @yaml[:data_dir] = File.expand_path(@yaml[:data_dir], @home)
    @yaml[:db_path] = File.expand_path(@yaml[:db_path], @home)
    FileUtils.makedirs(@yaml[:gem_dir])
    FileUtils.makedirs(@yaml[:gem_bin_dir])
    FileUtils.makedirs(@yaml[:data_dir])

    Runtime.install unless Runtime.installed?

#    unless `#{self.gem_command} sources`.include?("github")
#      cmd = "#{self.gem_command} sources -a http://gems.github.com"
#      Ramaze::Log.info cmd
#      `#{cmd}`
#    end
  end

  module Runtime
    VERSION = RubyStation::RUNTIME_VERSION

    def self.installed?
      GemManager.installed?("ruby-station-runtime", VERSION)
    end
    
    def self.install
      path = __DIR__("runtime/ruby-station-runtime-#{VERSION}.gem")
      GemManager.install_file(path)
    end

  end
end

if defined?(TESTS_DIR)
  Conf.set_home(TESTS_DIR/"data/conf_dir/")
else
  Conf.parse_opt
end
Conf.init
