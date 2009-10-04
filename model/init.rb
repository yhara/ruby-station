require 'dm-core'
Ramaze::Log.info("opening database: #{Conf.db_path}")
DataMapper.setup(:default, "sqlite3://#{Conf.db_path}")

require __DIR__("application.rb")
