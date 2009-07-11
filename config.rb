require 'yaml'
require 'fileutils'

#Encoding.default_external = 'UTF-8'

class Conf
  @home = File.expand_path("~/.ruby-station")
  @yaml = YAML.load_file(File.join(@home, "config.yaml"))
  @yaml[:gem_dir] = File.expand_path(@yaml[:gem_dir], @home)
  @yaml[:gem_bin_dir] = File.expand_path(@yaml[:gem_bin_dir], @home)
  @yaml[:data_dir] = File.expand_path(@yaml[:data_dir], @home)
  FileUtils.makedirs(@yaml[:gem_dir])
  FileUtils.makedirs(@yaml[:gem_bin_dir])
  FileUtils.makedirs(@yaml[:data_dir])

  %w(ruby_command gem_command gem_dir gem_bin_dir gem_install_option data_dir).each do |m|
    module_eval <<-EOD
      def self.#{m}; @yaml[:#{m}]; end
    EOD
  end
end
