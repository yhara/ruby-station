# Here goes your database connection and options:

# Here go your requires for models:
# require 'model/user'
require 'dm-core'
DataMapper.setup(:default, "sqlite3://#{__DIR__("../dev.db")}")

require 'model/application'
