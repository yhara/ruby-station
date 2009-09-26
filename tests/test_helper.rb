require 'fileutils'
require 'ramaze'
Ramaze.options.started = true

TESTS_DIR = __DIR__
def TESTS_DIR./(*paths)
  File.expand_path(File.join(*paths), TESTS_DIR)
end

def clear_tmp(tmp_dir)
  if File.exist?(tmp_dir)
    puts "removing all files under #{tmp_dir}..."
    puts "are you sure? [y/N]"
    if STDIN.gets.chomp == "y"
      FileUtils.rm_r(tmp_dir)
    else
      raise "user chose not to clear the temporary directory"
    end
  else
    Dir.mkdir(tmp_dir)
  end
end

clear_tmp(TESTS_DIR/"tmp/")
require TESTS_DIR/"../config.rb"
Conf.init TESTS_DIR/"data/conf_dir"

