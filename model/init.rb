require 'dm-core'
require 'dm-migrations'

Ramaze::Log.info("opening database: #{Conf.db_path}")
DataMapper.setup(:default, "sqlite3://#{Conf.db_path}")

require __DIR__("application.rb")
