require 'fileutils'
require 'ramaze'
Ramaze.options.started = true

TEST_TMP_DIR = __DIR__("/../tmp/")

def clear_tmp
  if File.exist?(TEST_TMP_DIR)
    puts "removing all files under #{TEST_TMP_DIR}..."
    puts "are you sure? [y/N]"
    if STDIN.gets.chomp == "y"
      FileUtils.rm_r(TEST_TMP_DIR)
    else
      raise "user chose not to clear TEST_TMP_DIR"
    end
  else
    Dir.mkdir(TEST_TMP_DIR)
  end
end

clear_tmp
require __DIR__("../../config.rb")
Conf.init __DIR__("../data/conf_dir")

