require 'dm-core'
DataMapper.setup(:default, "sqlite3://#{__DIR__("../dev.db")}")

require 'model/application'
