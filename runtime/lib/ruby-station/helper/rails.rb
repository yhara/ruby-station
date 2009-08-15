require 'fileutils'
module RubyStation
  module Helper

    # This module helps invoking Rails apps.
    # During execution of the application, Rails writes data to 
    # many directories (db/, log/, tmp/).
    # So this helper copies all the files into data_dir and 
    # invoke the app within the directory.
    #
    # Be sure to run 'rake db:migrate RAILS_ENV=produciton'
    # before you create the gem of your app.
    #
    # @example
    #   RubyStation::Helper::Rails.install
    #   RubyStation::Helper::Rails.start_server
    #
    # @api external

    module Rails

      # Ensure your app is copied to data_dir.
      # It does nothing if already copied.
      #
      # @api external
      def self.install
        return if installed?

        # Note: "." is needed, otherwise copied as data_dir/appname/*
        from = File.join(File.dirname(__FILE__), ".")
        to = RubyStation.data_dir
        FileUtils.cp_r(from, to)
      end

      # Checks if the files are copied
      #
      # @api internal
      def self.installed?
        File.exist?(File.join(RubyStation.data_dir, "main.rb"))
      end

      # Start Rails with 'script/server'.
      #
      # @api external
      def self.start_server
        Dir.chdir(RubyStation.data_dir)
        # TODO: Support Windows
        exec "./script/server -p #{RubyStation.port} -e production"
      end
    end
  end
end
