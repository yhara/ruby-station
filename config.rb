require 'yaml'

#Encoding.default_external = 'UTF-8'

class Conf
  @home = File.expand_path("~/.ruby-station")
  @yaml = YAML.load_file(File.join(@home, "config.yaml"))
  @yaml[:gem_dir] = File.expand_path(@yaml[:gem_dir], @home)
  @yaml[:gem_bin_dir] = File.expand_path(@yaml[:gem_bin_dir], @home)

  %w(gem_command gem_dir gem_bin_dir gem_install_option).each do |m|
    module_eval <<-EOD
      def self.#{m}; @yaml[:#{m}]; end
    EOD
  end
end
