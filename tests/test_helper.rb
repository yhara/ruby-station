require 'fileutils'
require 'ramaze'

TESTS_DIR = __DIR__
def TESTS_DIR./(*paths)
  File.expand_path(File.join(*paths), TESTS_DIR)
end

def clear_tmp(tmp_dir)
  if File.exist?(tmp_dir)
    puts "removing all files under #{tmp_dir}..."
    puts "are you sure? [just push enter if so]"
    if STDIN.gets.chomp.empty?
      FileUtils.rm_r(tmp_dir)
    else
      raise "user chose not to clear the temporary directory"
    end
  else
    Dir.mkdir(tmp_dir)
  end
end

def hello_gem_path(version)
  TESTS_DIR/"data/hello/pkg/hello-ruby-station-#{version}.gem"
end

clear_tmp(TESTS_DIR/"tmp/")
