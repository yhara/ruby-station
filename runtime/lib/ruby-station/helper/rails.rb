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
    #   RubyStation::Helper::Rails.run
    #
    # @api external

    module Rails

      # Copy files (if needed) and start Rails server.
      #
      # @api external
      def self.run
        caller_path = caller[0][/^(.*):/, 1]
        self.install(File.dirname(caller_path))

        Dir.chdir(RubyStation.data_dir)
        self.start_server
      end

      # Ensure your app is copied to data_dir.
      # It does nothing if already copied.
      #
      # @api internal
      def self.install(app_dir)
        # Note: "." is needed, otherwise copied as data_dir/appname/*
        from = File.join(app_dir, ".")
        to = RubyStation.data_dir

        unless installed?(from, to)
          FileUtils.cp_r(from, to)
        end
      end

      # Checks if the files are copied
      #
      # @api internal
      def self.installed?(from, to)
        # Note: Too simple?
        File.exist?(File.join(to, "main.rb"))
      end

      # Start Rails with 'script/server'.
      #
      # @api internal
      def self.start_server
        Dir.chdir(RubyStation.data_dir)
        # TODO: Support Windows
        exec "./script/server -p #{RubyStation.port} -e production"
      end
    end
  end
end
